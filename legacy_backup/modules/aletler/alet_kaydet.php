<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

header('Content-Type: application/json');

try {
    // Form verilerini al
    $seri_no = cleanInput($_POST['seri_no']);
    $adi = cleanInput($_POST['adi']);
    $marka = cleanInput($_POST['marka']);
    $kategori = cleanInput($_POST['kategori']);
    $raf_no = cleanInput($_POST['raf_no']);
    $raf_id = isset($_POST['raf_id']) ? (int)$_POST['raf_id'] : null;
    $aciklama = cleanInput($_POST['aciklama']);

    // Seri numarası kontrolü
    $checkSql = "SELECT id FROM aletler WHERE seri_no = ?";
    $checkStmt = $db->prepare($checkSql);
    $checkStmt->execute([$seri_no]);
    
    if ($checkStmt->rowCount() > 0) {
        echo json_encode([
            'success' => false,
            'message' => 'Bu seri numarası zaten kullanımda.'
        ]);
        exit;
    }

    // Barkod oluştur
    $barkod = generateBarcode($seri_no);

    // Veritabanına kaydet
    $sql = "INSERT INTO aletler (seri_no, barkod, adi, marka, kategori, raf_no, aciklama, raf_id) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    
    $stmt = $db->prepare($sql);
    $stmt->execute([
        $seri_no,
        $barkod,
        $adi,
        $marka,
        $kategori,
        $raf_no,
        $aciklama,
        $raf_id
    ]);

    echo json_encode([
        'success' => true,
        'message' => 'Alet başarıyla kaydedildi.',
        'id' => $db->lastInsertId()
    ]);

} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Hata: ' . $e->getMessage()
    ]);
}
