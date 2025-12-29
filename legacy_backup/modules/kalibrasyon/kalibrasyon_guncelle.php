<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

header('Content-Type: application/json');

try {
    $id = (int)$_POST['id'];
    $kalibrasyon_tarihi = cleanInput($_POST['kalibrasyon_tarihi']);
    $gecerlilik_suresi = (int)$_POST['gecerlilik_suresi'];
    $sertifika_no = cleanInput($_POST['sertifika_no']);
    $firma = cleanInput($_POST['firma']);
    $aciklama = cleanInput($_POST['aciklama']);

    $sonraki_kalibrasyon_tarihi = date('Y-m-d', strtotime($kalibrasyon_tarihi . " + {$gecerlilik_suresi} months"));

    $sql = "UPDATE kalibrasyon SET 
                kalibrasyon_tarihi = ?,
                gecerlilik_suresi = ?,
                sonraki_kalibrasyon_tarihi = ?,
                sertifika_no = ?,
                firma = ?,
                aciklama = ?
            WHERE id = ?";
    $stmt = $db->prepare($sql);
    $stmt->execute([
        $kalibrasyon_tarihi,
        $gecerlilik_suresi,
        $sonraki_kalibrasyon_tarihi,
        $sertifika_no,
        $firma,
        $aciklama,
        $id
    ]);

    echo json_encode(['success' => true]);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
