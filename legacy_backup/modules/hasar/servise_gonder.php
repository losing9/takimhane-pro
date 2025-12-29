<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Hata raporlamayı aktifleştir
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Debug log dosyası
$logFile = __DIR__ . '/debug.log';

function writeLog($message) {
    global $logFile;
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($logFile, "[$timestamp] $message\n", FILE_APPEND);
}

// Oturum kontrolü
checkLogin();

// JSON yanıtı hazırla
header('Content-Type: application/json');
$response = ['success' => false, 'message' => ''];

try {
    // POST verilerini al ve logla
    writeLog("Gelen POST verileri: " . print_r($_POST, true));

    $id = $_POST['id'] ?? null;
    $firma = $_POST['firma'] ?? null;
    $gonderim_tarihi = $_POST['gonderim_tarihi'] ?? null;
    $tahmini_donus_tarihi = $_POST['tahmini_donus_tarihi'] ?? null;
    $servis_no = $_POST['servis_no'] ?? null;
    $servis_aciklama = $_POST['servis_aciklama'] ?? null;

    // Debug için verileri yazdır
    writeLog("ID: $id");
    writeLog("Firma: $firma");
    writeLog("Gönderim Tarihi: $gonderim_tarihi");

    // Gerekli alanları kontrol et
    $eksik_alanlar = [];
    if (empty($id)) $eksik_alanlar[] = 'Hasar ID';
    if (empty($firma)) $eksik_alanlar[] = 'Firma';
    if (empty($gonderim_tarihi)) $eksik_alanlar[] = 'Gönderim Tarihi';

    if (!empty($eksik_alanlar)) {
        throw new Exception('Lütfen şu alanları doldurun: ' . implode(', ', $eksik_alanlar));
    }

    // Aletler tablosunun yapısını kontrol et
    $table_query = "DESCRIBE aletler";
    $table_stmt = $db->query($table_query);
    $table_structure = $table_stmt->fetchAll(PDO::FETCH_ASSOC);
    writeLog("Aletler tablo yapısı: " . print_r($table_structure, true));

    // Hasar kaydını al
    $hasar_query = "SELECT h.*, a.adi as alet_adi FROM hasar_tutanaklari h 
                    LEFT JOIN aletler a ON h.alet_id = a.id 
                    WHERE h.id = ?";
    writeLog("Hasar sorgusu: " . $hasar_query);
    writeLog("Hasar ID: " . $id);
    
    $hasar_stmt = $db->prepare($hasar_query);
    $hasar_stmt->execute([$id]);
    $hasar = $hasar_stmt->fetch(PDO::FETCH_ASSOC);
    
    writeLog("Hasar sorgu sonucu: " . print_r($hasar, true));

    if (!$hasar) {
        throw new Exception('Hasar kaydı bulunamadı.');
    }

    // Servis işlemi ekle
    $servis_query = "INSERT INTO servis_islemler (tutanak_id, firma, gonderim_tarihi, tahmini_donus_tarihi, servis_no, servis_aciklama, durum) 
                     VALUES (?, ?, ?, ?, ?, ?, 'servise_gonderildi')";
    writeLog("Servis ekleme sorgusu: " . $servis_query);
    writeLog("Servis parametreleri: " . print_r([
        $id, $firma, $gonderim_tarihi, $tahmini_donus_tarihi, $servis_no, $servis_aciklama
    ], true));
    
    $servis_stmt = $db->prepare($servis_query);
    $servis_stmt->execute([
        $id,
        $firma,
        $gonderim_tarihi,
        $tahmini_donus_tarihi,
        $servis_no,
        $servis_aciklama
    ]);

    // Hasar durumunu güncelle
    $hasar_update = "UPDATE hasar_tutanaklari SET durum = 'serviste' WHERE id = ?";
    writeLog("Hasar güncelleme sorgusu: " . $hasar_update);
    $hasar_update_stmt = $db->prepare($hasar_update);
    $hasar_update_stmt->execute([$id]);

    // Aletin durumunu güncelle
    $alet_update = "UPDATE aletler a
        JOIN hasar_tutanaklari ht ON a.id = ht.alet_id
        SET a.durum = 'beklemede'
        WHERE ht.id = :id";
    writeLog("Alet güncelleme sorgusu: " . $alet_update);
    $stmt = $db->prepare($alet_update);
    $stmt->execute(['id' => $id]);

    $response['success'] = true;
    $response['message'] = 'Alet başarıyla servise gönderildi.';

} catch (PDOException $e) {
    writeLog("PDO HATASI: " . $e->getMessage());
    writeLog("PDO Hata kodu: " . $e->getCode());
    writeLog("PDO Hata detayı: " . print_r($e->errorInfo, true));
    $response['message'] = 'Veritabanı hatası: ' . $e->getMessage();
} catch (Exception $e) {
    writeLog("HATA: " . $e->getMessage());
    writeLog("Hata detayı: " . print_r($e, true));
    $response['message'] = $e->getMessage();
}

writeLog("Son yanıt: " . print_r($response, true));
echo json_encode($response);
