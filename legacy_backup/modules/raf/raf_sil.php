<?php
require_once '../../config/database.php';
header('Content-Type: application/json');

$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
if ($id < 1) {
    echo json_encode(['success' => false, 'message' => 'Geçersiz raf ID.']);
    exit;
}
try {
    $stmt = $db->prepare("DELETE FROM raf_listesi WHERE id=?");
    $stmt->execute([$id]);
    echo json_encode(['success' => true, 'message' => 'Raf silindi.']);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Veritabanı hatası.']);
}
