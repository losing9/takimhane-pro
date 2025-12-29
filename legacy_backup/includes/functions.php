<?php

// Genel yardımcı fonksiyonlar
function cleanInput($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Barkod oluşturma fonksiyonu
function generateBarcode($text, $type = 'code128') {
    require_once __DIR__ . '/../vendor/picqer/php-barcode-generator/src/BarcodeGeneratorPNG.php';
    require_once __DIR__ . '/../vendor/picqer/php-barcode-generator/src/BarcodeGenerator.php';
    $generator = new \Picqer\Barcode\BarcodeGeneratorPNG();
    $barcode = $generator->getBarcode($text, $generator::TYPE_CODE_128, 2, 60);
    return 'data:image/png;base64,' . base64_encode($barcode);
}

// Bildirim oluşturma
function createNotification($userId, $message, $type) {
    global $db;
    $sql = "INSERT INTO notifications (user_id, message, type, created_at) VALUES (?, ?, ?, NOW())";
    $stmt = $db->prepare($sql);
    return $stmt->execute([$userId, $message, $type]);
}

// Tarih formatlama
function formatDate($date) {
    return date('d.m.Y H:i', strtotime($date));
}

// Kalibrasyon durumu kontrolü
function checkCalibrationStatus($calibrationDate, $calibrationPeriod) {
    $calibrationDue = strtotime($calibrationDate . ' + ' . $calibrationPeriod . ' months');
    $now = time();
    $daysLeft = floor(($calibrationDue - $now) / (60 * 60 * 24));
    
    return [
        'daysLeft' => $daysLeft,
        'status' => $daysLeft <= 30 ? 'warning' : 'ok'
    ];
}

// Hata mesajı gösterme
function showError($message) {
    return '<div class="alert alert-danger">' . $message . '</div>';
}

// Başarı mesajı gösterme
function showSuccess($message) {
    return '<div class="alert alert-success">' . $message . '</div>';
}

// Oturum kontrolü
function checkLogin() {
    if (!isset($_SESSION['kullanici_id'])) {
        header('Location: ../login.php');
        exit();
    }
}

// Yönetici kontrolü
function isAdmin() {
    return isset($_SESSION['yetki_seviyesi']) && $_SESSION['yetki_seviyesi'] === 'admin';
}

// İstatistik fonksiyonları
function getAletIstatistikleri() {
    global $db;
    
    try {
        // Toplam alet sayısı
        $stmt = $db->query("SELECT COUNT(*) as total FROM aletler WHERE silindi = 0");
        $toplam = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
        
        // Servisteki aletler
        $stmt = $db->query("SELECT COUNT(*) as total FROM aletler WHERE durum = 'servis' AND silindi = 0");
        $servisteki = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
        
        // Kalibrasyondaki aletler
        $stmt = $db->query("SELECT COUNT(*) as total FROM aletler WHERE durum = 'kalibrasyon' AND silindi = 0");
        $kalibrasyondaki = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
        
        // Pasif aletler
        $stmt = $db->query("SELECT COUNT(*) as total FROM aletler WHERE durum = 'pasif' AND silindi = 0");
        $pasif = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
        
        // Son eklenen 5 alet
        $stmt = $db->query("
            SELECT a.*, r.kod as raf_kodu 
            FROM aletler a 
            LEFT JOIN raflar r ON a.raf_id = r.id 
            WHERE a.silindi = 0 
            ORDER BY a.eklenme_tarihi DESC 
            LIMIT 5
        ");
        $son_eklenenler = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        return [
            'toplam' => $toplam,
            'servisteki' => $servisteki,
            'kalibrasyondaki' => $kalibrasyondaki,
            'pasif' => $pasif,
            'son_eklenenler' => $son_eklenenler
        ];
    } catch (PDOException $e) {
        error_log('İstatistik hatası: ' . $e->getMessage());
        return [
            'toplam' => 0,
            'servisteki' => 0,
            'kalibrasyondaki' => 0,
            'pasif' => 0,
            'son_eklenenler' => []
        ];
    }
}

// Ödünç işlemleri için fonksiyonlar
function getGunlukOduncKayitlari() {
    global $db;
    
    try {
        $stmt = $db->prepare("
            SELECT 
                o.id,
                o.alet_id,
                o.personel_id,
                o.verilis_tarihi,
                o.iade_tarihi,
                a.seri_no,
                a.adi as alet_adi,
                p.ad as personel_adi,
                p.soyad as personel_soyadi
            FROM odunc_kayitlari o
            JOIN aletler a ON o.alet_id = a.id
            JOIN personel p ON o.personel_id = p.id
            WHERE DATE(o.verilis_tarihi) = CURDATE()
            ORDER BY o.verilis_tarihi DESC
        ");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        error_log('Günlük ödünç kayıtları hatası: ' . $e->getMessage());
        return [];
    }
}

function getIadeEdilmemisAletler() {
    global $db;
    
    try {
        $stmt = $db->prepare("
            SELECT 
                o.id,
                o.alet_id,
                o.personel_id,
                o.verilis_tarihi,
                a.seri_no,
                a.adi as alet_adi,
                p.ad as personel_adi,
                p.soyad as personel_soyadi,
                DATEDIFF(CURDATE(), o.verilis_tarihi) as gecen_gun
            FROM odunc_kayitlari o
            JOIN aletler a ON o.alet_id = a.id
            JOIN personel p ON o.personel_id = p.id
            WHERE o.iade_tarihi IS NULL
            AND DATE(o.verilis_tarihi) < CURDATE()
            ORDER BY o.verilis_tarihi ASC
        ");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        error_log('İade edilmemiş aletler hatası: ' . $e->getMessage());
        return [];
    }
}

function getPersonelListesi() {
    global $db;
    try {
        // Önce tablo yapısını kontrol et
        $check = $db->query("DESCRIBE personel");
        error_log("Personel tablo yapısı: " . print_r($check->fetchAll(PDO::FETCH_ASSOC), true));

        // DURUM alanı yoksa veya tüm personelleri getirmek isteniyorsa, WHERE koşulunu kaldır
        $stmt = $db->prepare("
            SELECT id, sicil_no, ad, soyad
            FROM personel
            ORDER BY ad, soyad
        ");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Sonuçları logla
        error_log("Personel sorgusu sonucu: " . print_r($result, true));
        
        return $result;
    } catch (PDOException $e) {
        error_log('Personel listesi hatası: ' . $e->getMessage());
        return [];
    }
}

function getAletListesi() {
    global $db;
    try {
        // Tüm aletleri kontrol et
        echo "<!-- Alet listesi sorgusu başlıyor -->\n";
        
        // Basit sorgu ile deneyelim
        $stmt = $db->prepare("
            SELECT id, seri_no, adi, durum
            FROM aletler
            WHERE silindi = 0
        ");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        echo "<!-- Bulunan alet sayısı: " . count($result) . " -->\n";
        
        if (count($result) == 0) {
            echo "<!-- UYARI: Hiç alet bulunamadı -->\n";
            // Tablo yapısını kontrol et
            $check = $db->query("SHOW TABLES LIKE 'aletler'");
            if ($check->rowCount() == 0) {
                echo "<!-- HATA: aletler tablosu bulunamadı -->\n";
            } else {
                $cols = $db->query("DESCRIBE aletler");
                echo "<!-- Tablo yapısı: " . print_r($cols->fetchAll(PDO::FETCH_ASSOC), true) . " -->\n";
            }
        }
        
        return $result;
    } catch (PDOException $e) {
        echo "<!-- HATA: " . $e->getMessage() . " -->\n";
        return [];
    }
}

// Hasarlı aletleri getir
function getHasarliAletler() {
    global $db;
    try {
        $stmt = $db->prepare("
            SELECT a.*, ht.id as tutanak_id, ht.hasar_turu, ht.hasar_tarihi
            FROM aletler a
            JOIN hasar_tutanaklari ht ON a.id = ht.alet_id
            WHERE a.durum = 'hasarli'
            AND ht.id NOT IN (
                SELECT tutanak_id 
                FROM servis_islemler 
                WHERE durum IN ('servise_gonderildi', 'serviste')
            )
            ORDER BY ht.hasar_tarihi DESC
        ");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        error_log('Hasarlı aletler listesi hatası: ' . $e->getMessage());
        return [];
    }
}

// Servisteki aletleri getir
function getServistekiAletler() {
    global $db;
    try {
        $stmt = $db->prepare("
            SELECT 
                si.*, 
                a.seri_no, 
                a.adi as alet_adi,
                ht.hasar_turu,
                ht.hasar_tarihi
            FROM servis_islemler si
            JOIN hasar_tutanaklari ht ON si.tutanak_id = ht.id
            JOIN aletler a ON ht.alet_id = a.id
            WHERE si.durum IN ('servise_gonderildi', 'serviste')
            ORDER BY si.gonderim_tarihi DESC
        ");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        error_log('Servisteki aletler listesi hatası: ' . $e->getMessage());
        return [];
    }
}

// Servis durumu güncelle
function updateServisDurum($servisId, $yeniDurum, $gercekMaliyet = null, $aciklama = null) {
    global $db;
    try {
        $db->beginTransaction();

        // Servis kaydını al
        $stmt = $db->prepare("
            SELECT si.*, ht.alet_id 
            FROM servis_islemler si
            JOIN hasar_tutanaklari ht ON si.tutanak_id = ht.id
            WHERE si.id = ?
        ");
        $stmt->execute([$servisId]);
        $servis = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$servis) {
            throw new Exception('Servis kaydı bulunamadı.');
        }

        // Servis durumunu güncelle
        $sql = "UPDATE servis_islemler SET durum = ?";
        $params = [$yeniDurum];

        if ($yeniDurum == 'onarildi' || $yeniDurum == 'onarilamaz' || $yeniDurum == 'pert') {
            $sql .= ", gercek_donus_tarihi = CURRENT_DATE";
            if ($gercekMaliyet !== null) {
                $sql .= ", maliyet = ?";
                $params[] = $gercekMaliyet;
            }
        }

        $sql .= " WHERE id = ?";
        $params[] = $servisId;

        $stmt = $db->prepare($sql);
        $stmt->execute($params);

        // Alet durumunu güncelle
        $aletDurum = 'aktif';
        switch ($yeniDurum) {
            case 'servise_gonderildi':
            case 'serviste':
                $aletDurum = 'serviste';
                break;
            case 'onarildi':
                $aletDurum = 'aktif';
                break;
            case 'onarilamaz':
                $aletDurum = 'onarilamaz';
                break;
            case 'pert':
                $aletDurum = 'pert';
                break;
        }

        $stmt = $db->prepare("UPDATE aletler SET durum = ? WHERE id = ?");
        $stmt->execute([$aletDurum, $servis['alet_id']]);

        // Servis takip kaydı oluştur
        if ($aciklama) {
            $stmt = $db->prepare("
                INSERT INTO servis_takip (servis_islem_id, tarih, durum, aciklama)
                VALUES (?, CURRENT_TIMESTAMP, ?, ?)
            ");
            $stmt->execute([$servisId, $yeniDurum, $aciklama]);
        }

        $db->commit();
        return true;
    } catch (Exception $e) {
        $db->rollBack();
        error_log('Servis durumu güncelleme hatası: ' . $e->getMessage());
        throw $e;
    }
}

// Servis takip geçmişini getir
function getServisTakip($servisId) {
    global $db;
    try {
        $stmt = $db->prepare("
            SELECT * FROM servis_takip
            WHERE servis_islem_id = ?
            ORDER BY tarih DESC
        ");
        $stmt->execute([$servisId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        error_log('Servis takip geçmişi hatası: ' . $e->getMessage());
        return [];
    }
}

// Servis durumu için badge class
function getServisBadgeClass($servis) {
    switch ($servis['durum']) {
        case 'servise_gonderildi':
            return 'bg-info';
        case 'serviste':
            return 'bg-warning';
        case 'onarildi':
            return 'bg-success';
        case 'onarilamaz':
            return 'bg-danger';
        case 'pert':
            return 'bg-dark';
        default:
            return 'bg-secondary';
    }
}

// Servis durumu için metin
function getServisDurumText($durum) {
    switch ($durum) {
        case 'servise_gonderildi':
            return 'Servise Gönderildi';
        case 'serviste':
            return 'Serviste';
        case 'onarildi':
            return 'Onarıldı';
        case 'onarilamaz':
            return 'Onarılamaz';
        case 'pert':
            return 'Pert';
        default:
            return 'Bilinmiyor';
    }
}

// Tarih ve saat formatlama
function formatDateTime($datetime) {
    return date('d.m.Y H:i', strtotime($datetime));
}

?>
