<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

// JSON yanıtı için header
header('Content-Type: application/json');

try {
    // POST verilerini al
    $tutanak_id = $_POST['tutanak_id'] ?? null;
    $durum = $_POST['durum'] ?? null;
    $gercek_maliyet = $_POST['gercek_maliyet'] ?? null;

    // Zorunlu alanları kontrol et
    if (!$tutanak_id || !$durum) {
        throw new Exception('Tutanak ID ve durum belirtilmelidir.');
    }

    // Tutanağı güncelle
    $stmt = $db->prepare("
        UPDATE hasar_tutanaklari 
        SET durum = ?, gercek_maliyet = ?
        WHERE id = ?
    ");

    $stmt->execute([$durum, $gercek_maliyet, $tutanak_id]);

    // Tutanak bilgilerini al
    $stmt = $db->prepare("
        SELECT ht.*, a.id as alet_id 
        FROM hasar_tutanaklari ht
        LEFT JOIN aletler a ON ht.alet_id = a.id
        WHERE ht.id = ?
    ");
    $stmt->execute([$tutanak_id]);
    $tutanak = $stmt->fetch(PDO::FETCH_ASSOC);

    // Aletin durumunu güncelle
    $alet_durum = 'hasarli';
    if ($durum == 'onarildi') {
        $alet_durum = 'aktif';
    } elseif ($durum == 'onarilamaz') {
        $alet_durum = 'hasarli';
    }

    $stmt = $db->prepare("UPDATE aletler SET durum = ? WHERE id = ?");
    $stmt->execute([$alet_durum, $tutanak['alet_id']]);

    // Başarılı yanıt
    echo json_encode([
        'success' => true,
        'message' => 'Hasar tutanağı başarıyla güncellendi.'
    ]);

} catch (Exception $e) {
    // Hata yanıtı
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
