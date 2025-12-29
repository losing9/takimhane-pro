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
    $odunc_id = $_POST['odunc_id'] ?? null;

    // Verileri kontrol et
    if (!$odunc_id) {
        throw new Exception('Ödünç kaydı seçilmelidir.');
    }

    // Ödünç kaydını kontrol et
    $stmt = $db->prepare("
        SELECT o.*, a.durum 
        FROM odunc_kayitlari o
        JOIN aletler a ON o.alet_id = a.id
        WHERE o.id = ? AND o.iade_tarihi IS NULL
    ");
    $stmt->execute([$odunc_id]);
    $odunc = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$odunc) {
        throw new Exception('Ödünç kaydı bulunamadı veya alet zaten iade edilmiş.');
    }

    // İade işlemini gerçekleştir
    $stmt = $db->prepare("
        UPDATE odunc_kayitlari 
        SET iade_tarihi = NOW()
        WHERE id = ?
    ");
    $stmt->execute([$odunc_id]);

    // Başarılı yanıt
    echo json_encode([
        'success' => true,
        'message' => 'Alet başarıyla iade alındı.'
    ]);

} catch (Exception $e) {
    // Hata yanıtı
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
