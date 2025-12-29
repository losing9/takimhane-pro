<?php
require_once '../../config/database.php';
header('Content-Type: application/json');

$adi = trim($_POST['adi'] ?? '');
$konum = trim($_POST['konum'] ?? '');
$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;

if ($adi === '') {
    echo json_encode(['success' => false, 'message' => 'Raf adı boş olamaz.']);
    exit;
}

try {
    if ($id > 0) {
        $stmt = $db->prepare("UPDATE raf_listesi SET adi=?, konum=? WHERE id=?");
        $stmt->execute([$adi, $konum, $id]);
        echo json_encode(['success' => true, 'message' => 'Raf güncellendi.']);
    } else {
        $stmt = $db->prepare("INSERT INTO raf_listesi (adi, konum) VALUES (?, ?)");
        $stmt->execute([$adi, $konum]);
        echo json_encode(['success' => true, 'message' => 'Raf eklendi.']);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Veritabanı hatası.']);
}
