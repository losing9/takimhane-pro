<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id <= 0) {
    echo '<div class="alert alert-danger">Geçersiz personel ID.</div>';
    exit;
}
$stmt = $db->prepare('SELECT * FROM personel WHERE id = ?');
$stmt->execute([$id]);
$personel = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$personel) {
    echo '<div class="alert alert-danger">Personel bulunamadı.</div>';
    exit;
}
?>
<div class="mb-2"><strong>Ad Soyad:</strong> <?php echo htmlspecialchars($personel['ad'] . ' ' . $personel['soyad']); ?></div>
<div class="mb-2"><strong>Departman:</strong> <?php echo htmlspecialchars($personel['departman']); ?></div>
<div class="mb-2"><strong>Email:</strong> <?php echo htmlspecialchars($personel['email']); ?></div>
<div class="mb-2"><strong>Telefon:</strong> <?php echo htmlspecialchars($personel['telefon']); ?></div>
<img src="../../modules/aletler/barkod.php?code=<?php echo urlencode($personel['ad'] . ' ' . $personel['soyad']); ?>" alt="Barkod" style="height:60px;display:block;margin:10px 0;">
