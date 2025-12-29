<?php
// Hata gösterimi ve limitler
ini_set('display_errors', 1);
error_reporting(E_ALL);
ini_set('max_execution_time', 600); // 10 dakika
ini_set('memory_limit', '256M');
set_time_limit(600);

// Çıktı tamponlaması
ob_implicit_flush(true);
ob_end_flush();

// UTF-8
header('Content-Type: text/html; charset=utf-8');
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>İçe Aktarma</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
<?php
try {
    require_once '../config/database.php';
    
    if (!$db) {
        throw new Exception("Veritabanı bağlantısı kurulamadı!");
    }
    
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // CSV dosyasını kontrol et
    $inputFileName = __DIR__ . '/liste.csv';
    if (!file_exists($inputFileName)) {
        throw new Exception("CSV dosyası bulunamadı: $inputFileName");
    }
    
    echo '<div class="alert alert-info">CSV dosyası okunuyor...</div>';
    flush();
    
    // CSV dosyasını aç
    $file = fopen($inputFileName, 'r');
    if (!$file) {
        throw new Exception("CSV dosyası açılamadı!");
    }
    
    // İlk satırı atla (başlıklar)
    fgetcsv($file);
    
    $successCount = 0;
    $errorCount = 0;
    $errors = [];
    $rafCache = [];
    
    // Her satırı oku
    $row = 2; // Başlık satırını atladığımız için 2'den başlıyoruz
    while (($data = fgetcsv($file)) !== FALSE) {
        try {
            // CSV verilerini al
            $seri_no = trim($data[0] ?? ''); // A sütunu
            $alet_adi = trim($data[1] ?? ''); // B sütunu
            $raf_kodu = trim($data[2] ?? ''); // C sütunu
            $aciklama = trim($data[3] ?? ''); // D sütunu
            $stok_giris = trim($data[5] ?? ''); // F sütunu
            
            // Boş satırı atla
            if (empty($seri_no) && empty($alet_adi)) {
                $row++;
                continue;
            }
            
            // Zorunlu alanları kontrol et
            if (empty($seri_no) || empty($alet_adi)) {
                throw new Exception("Seri no veya alet adı boş olamaz!");
            }
            
            // Raf kodunu işle
            $raf_id = null;
            if (!empty($raf_kodu)) {
                if (isset($rafCache[$raf_kodu])) {
                    $raf_id = $rafCache[$raf_kodu];
                } else {
                    // Rafı ara
                    $stmt = $db->prepare("SELECT id FROM raflar WHERE kod = ?");
                    $stmt->execute([$raf_kodu]);
                    $raf = $stmt->fetch(PDO::FETCH_ASSOC);
                    
                    if ($raf) {
                        $raf_id = $raf['id'];
                    } else {
                        // Yeni raf oluştur
                        $stmt = $db->prepare("INSERT INTO raflar (kod) VALUES (?)");
                        $stmt->execute([$raf_kodu]);
                        $raf_id = $db->lastInsertId();
                    }
                    
                    $rafCache[$raf_kodu] = $raf_id;
                }
            }
            
            // Aleti ekle
            $sql = "INSERT INTO aletler (barkod, seri_no, adi, raf_id, aciklama, eklenme_tarihi) 
                    VALUES (:barkod, :seri_no, :adi, :raf_id, :aciklama, :eklenme_tarihi)";
            
            $params = [
                'barkod' => $seri_no,
                'seri_no' => $seri_no,
                'adi' => $alet_adi,
                'raf_id' => $raf_id,
                'aciklama' => $aciklama,
                'eklenme_tarihi' => !empty($stok_giris) ? date('Y-m-d H:i:s', strtotime($stok_giris)) : date('Y-m-d H:i:s')
            ];
            
            $stmt = $db->prepare($sql);
            $result = $stmt->execute($params);
            
            if ($result) {
                $successCount++;
                echo '<div class="alert alert-success">✓ Satır ' . $row . ': ' . $alet_adi . ' (Seri No: ' . $seri_no . ') eklendi.</div>';
                flush();
            } else {
                throw new Exception("Veritabanına eklenemedi!");
            }
            
        } catch (Exception $e) {
            $errorCount++;
            $error = "Satır $row hatası: " . $e->getMessage();
            $errors[] = $error;
            echo '<div class="alert alert-danger">✗ ' . htmlspecialchars($error) . '</div>';
            flush();
        }
        
        $row++;
    }
    
    // CSV dosyasını kapat
    fclose($file);
    
    // Sonuç özeti
    echo '<div class="alert alert-info mt-3">';
    echo '<h5>İşlem Tamamlandı</h5>';
    echo 'Başarılı: ' . $successCount . ' kayıt<br>';
    echo 'Hatalı: ' . $errorCount . ' kayıt';
    
    if (!empty($errors)) {
        echo '<h5 class="mt-3">Hata Detayları:</h5>';
        echo '<ul>';
        foreach ($errors as $error) {
            echo '<li>' . htmlspecialchars($error) . '</li>';
        }
        echo '</ul>';
    }
    echo '</div>';
    
} catch (Exception $e) {
    echo '<div class="alert alert-danger">';
    echo '<h5>Kritik Hata:</h5>';
    echo htmlspecialchars($e->getMessage());
    echo '</div>';
}
?>
<div class="mt-3 mb-4">
    <a href="index.php" class="btn btn-primary">Geri Dön</a>
</div>
</div>
</body>
</html>
