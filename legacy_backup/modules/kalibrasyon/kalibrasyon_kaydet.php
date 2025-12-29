<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

require_once '../../config/database.php';
require_once '../../includes/functions.php';

header('Content-Type: application/json');

try {
    // Form verilerini al
    $alet_id = isset($_POST['alet_id']) ? (int)$_POST['alet_id'] : 0;
    $kalibrasyon_tarihi = !empty($_POST['kalibrasyon_tarihi']) ? cleanInput($_POST['kalibrasyon_tarihi']) : null;
    $gecerlilik_suresi = isset($_POST['gecerlilik_suresi']) ? (int)$_POST['gecerlilik_suresi'] : 0;
    $sertifika_no = !empty($_POST['sertifika_no']) ? cleanInput($_POST['sertifika_no']) : null;
    $firma = !empty($_POST['firma']) ? cleanInput($_POST['firma']) : null;
    $aciklama = !empty($_POST['aciklama']) ? cleanInput($_POST['aciklama']) : null;

    if (!$alet_id || !$kalibrasyon_tarihi || !$gecerlilik_suresi || !$sertifika_no || !$firma) {
        throw new Exception('Tüm zorunlu alanları doldurunuz.');
    }

    // Sonraki kalibrasyon tarihini hesapla
    $sonraki_kalibrasyon_tarihi = date('Y-m-d', strtotime("$kalibrasyon_tarihi +$gecerlilik_suresi months"));

    $db->beginTransaction();

    // Aynı alet için aktif bir kalibrasyon kaydı varsa pasif yap
    $db->prepare("UPDATE kalibrasyon SET aktif = 0 WHERE alet_id = ? AND aktif = 1")
        ->execute([$alet_id]);

    // Yeni kalibrasyon kaydını ekle
    $sql = "INSERT INTO kalibrasyon (
                alet_id, kalibrasyon_tarihi, gecerlilik_suresi, sonraki_kalibrasyon_tarihi, sertifika_no, firma, aciklama, aktif
            ) VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
    $stmt = $db->prepare($sql);
    $stmt->execute([
        $alet_id,
        $kalibrasyon_tarihi,
        $gecerlilik_suresi,
        $sonraki_kalibrasyon_tarihi,
        $sertifika_no,
        $firma,
        $aciklama
    ]);

    // Alet durumunu güncelle (isteğe bağlı)
    $db->prepare("UPDATE aletler SET durum = 'aktif' WHERE id = ?")
        ->execute([$alet_id]);

    $db->commit();

    echo json_encode([
        'success' => true,
        'message' => 'Kalibrasyon kaydı başarıyla oluşturuldu.'
    ]);
} catch (Exception $e) {
    if ($db->inTransaction()) $db->rollBack();
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
