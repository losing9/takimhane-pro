<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
if ($id <= 0) {
    echo json_encode(['success' => false, 'message' => 'Geçersiz ID']);
    exit;
}
$stmt = $db->prepare('DELETE FROM personel WHERE id = ?');
$success = $stmt->execute([$id]);
if ($success) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'Silme işlemi başarısız']);
}
