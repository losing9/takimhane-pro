<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

header('Content-Type: application/json');

function generateSicilNo($db) {
    do {
        // Örn: Yıl + 5 haneli random sayı (2025-XXXXX)
        $sicil_no = date('Y') . '-' . str_pad(rand(0, 99999), 5, '0', STR_PAD_LEFT);
        $checkSql = "SELECT id FROM personel WHERE sicil_no = ?";
        $checkStmt = $db->prepare($checkSql);
        $checkStmt->execute([$sicil_no]);
    } while ($checkStmt->rowCount() > 0);
    return $sicil_no;
}

try {
    // Form verilerini al
    $ad = cleanInput($_POST['ad']);
    $soyad = cleanInput($_POST['soyad']);
    $departman = cleanInput($_POST['departman']);
    $email = cleanInput($_POST['email']);
    $telefon = cleanInput($_POST['telefon']);

    // Email kontrolü
    if (!empty($email)) {
        $checkSql = "SELECT id FROM personel WHERE email = ?";
        $checkStmt = $db->prepare($checkSql);
        $checkStmt->execute([$email]);
        if ($checkStmt->rowCount() > 0) {
            echo json_encode([
                'success' => false,
                'message' => 'Bu email adresi zaten kullanımda.'
            ]);
            exit;
        }
    }
    // Otomatik ve uniq sicil_no üret
    $sicil_no = generateSicilNo($db);

    // Veritabanına kaydet
    $sql = "INSERT INTO personel (ad, soyad, sicil_no, departman, email, telefon) VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $db->prepare($sql);
    $stmt->execute([
        $ad,
        $soyad,
        $sicil_no,
        $departman,
        $email,
        $telefon
    ]);

    echo json_encode([
        'success' => true,
        'message' => 'Personel başarıyla kaydedildi.',
        'sicil_no' => $sicil_no,
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
