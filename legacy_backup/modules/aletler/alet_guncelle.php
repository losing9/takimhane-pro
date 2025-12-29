<?php
require_once '../../config/database.php';
header('Content-Type: application/json; charset=utf-8');

$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
$seri_no = trim($_POST['seri_no'] ?? '');
$adi = trim($_POST['adi'] ?? '');
$marka = trim($_POST['marka'] ?? '');
$kategori = trim($_POST['kategori'] ?? '');
$raf_id = isset($_POST['raf_id']) && $_POST['raf_id'] !== '' ? (int)$_POST['raf_id'] : null;
$durum = trim($_POST['durum'] ?? 'aktif');
$aciklama = trim($_POST['aciklama'] ?? '');

// Sadece izin verilen durumlar
$allowedDurum = ['aktif', 'pasif', 'servis', 'kalibrasyon'];
if (!in_array($durum, $allowedDurum)) {
    $durum = 'aktif';
}

if ($id <= 0 || $seri_no === '' || $adi === '' || $marka === '') {
    echo json_encode(['success' => false, 'message' => 'Eksik veya geçersiz veri!']);
    exit;
}

try {
    $stmt = $db->prepare("UPDATE aletler SET seri_no=?, adi=?, marka=?, kategori=?, raf_id=?, durum=?, aciklama=?, guncelleme_tarihi=NOW() WHERE id=?");
    $stmt->bindValue(1, $seri_no);
    $stmt->bindValue(2, $adi);
    $stmt->bindValue(3, $marka);
    $stmt->bindValue(4, $kategori);
    if ($raf_id === null) {
        $stmt->bindValue(5, null, PDO::PARAM_NULL);
    } else {
        $stmt->bindValue(5, $raf_id, PDO::PARAM_INT);
    }
    $stmt->bindValue(6, $durum);
    $stmt->bindValue(7, $aciklama);
    $stmt->bindValue(8, $id, PDO::PARAM_INT);
    $stmt->execute();
    echo json_encode(['success' => true, 'message' => 'Alet başarıyla güncellendi.']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Veritabanı hatası: ' . $e->getMessage()]);
}
