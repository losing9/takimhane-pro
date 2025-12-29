<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

header('Content-Type: application/json');

try {
    // Form verilerini al
    $personel_id = (int)$_POST['personel_id'];
    $alet_id = (int)$_POST['alet_id'];
    $planlanan_iade_tarihi = cleanInput($_POST['planlanan_iade_tarihi']);

    // Aletin müsait olup olmadığını kontrol et
    $checkSql = "SELECT durum FROM aletler WHERE id = ?";
    $checkStmt = $db->prepare($checkSql);
    $checkStmt->execute([$alet_id]);
    $alet = $checkStmt->fetch(PDO::FETCH_ASSOC);

    if (!$alet || $alet['durum'] !== 'aktif') {
        echo json_encode([
            'success' => false,
            'message' => 'Bu alet şu anda zimmetlenemez.'
        ]);
        exit;
    }

    // Transaction başlat
    $db->beginTransaction();

    // Zimmet kaydı oluştur
    $zimmetSql = "INSERT INTO odunc_islemler (alet_id, personel_id, planlanan_iade_tarihi) 
                  VALUES (?, ?, ?)";
    $zimmetStmt = $db->prepare($zimmetSql);
    $zimmetStmt->execute([
        $alet_id,
        $personel_id,
        $planlanan_iade_tarihi
    ]);

    // Alet durumunu güncelle
    $updateSql = "UPDATE aletler SET durum = 'odunc_verildi' WHERE id = ?";
    $updateStmt = $db->prepare($updateSql);
    $updateStmt->execute([$alet_id]);

    // Transaction'ı tamamla
    $db->commit();

    echo json_encode([
        'success' => true,
        'message' => 'Alet başarıyla zimmetlendi.'
    ]);

} catch (PDOException $e) {
    // Hata durumunda transaction'ı geri al
    $db->rollBack();
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
} catch (Exception $e) {
    $db->rollBack();
    echo json_encode([
        'success' => false,
        'message' => 'Hata: ' . $e->getMessage()
    ]);
}
