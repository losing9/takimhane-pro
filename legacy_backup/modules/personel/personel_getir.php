<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id <= 0) {
    echo json_encode(['success' => false, 'message' => 'Geçersiz ID']);
    exit;
}
$stmt = $db->prepare('SELECT * FROM personel WHERE id = ?');
$stmt->execute([$id]);
$personel = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$personel) {
    echo json_encode(['success' => false, 'message' => 'Personel bulunamadı']);
    exit;
}
echo json_encode($personel);
