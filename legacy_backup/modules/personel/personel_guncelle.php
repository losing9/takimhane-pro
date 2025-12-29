<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

$id = isset($_POST['duzenle_id']) ? (int)$_POST['duzenle_id'] : 0;
$ad = isset($_POST['duzenle_ad']) ? cleanInput($_POST['duzenle_ad']) : '';
$soyad = isset($_POST['duzenle_soyad']) ? cleanInput($_POST['duzenle_soyad']) : '';
$departman = isset($_POST['duzenle_departman']) ? cleanInput($_POST['duzenle_departman']) : '';
$email = isset($_POST['duzenle_email']) ? cleanInput($_POST['duzenle_email']) : '';
$telefon = isset($_POST['duzenle_telefon']) ? cleanInput($_POST['duzenle_telefon']) : '';

if ($id <= 0 || !$ad || !$soyad) {
    echo json_encode(['success' => false, 'message' => 'Eksik veya hatalı bilgi']);
    exit;
}
$stmt = $db->prepare('UPDATE personel SET ad = ?, soyad = ?, departman = ?, email = ?, telefon = ? WHERE id = ?');
$success = $stmt->execute([$ad, $soyad, $departman, $email, $telefon, $id]);
if ($success) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'Güncelleme başarısız']);
}
