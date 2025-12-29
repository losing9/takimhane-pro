<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if (!$id) {
    echo '<div class="alert alert-danger">Kayıt bulunamadı.</div>';
    exit;
}
$stmt = $db->prepare("SELECT k.*, a.adi as alet_adi, a.seri_no FROM kalibrasyon k JOIN aletler a ON k.alet_id = a.id WHERE k.id = ?");
$stmt->execute([$id]);
$k = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$k) {
    echo '<div class="alert alert-danger">Kayıt bulunamadı.</div>';
    exit;
}
?>
<div class="mb-2"><strong>Alet:</strong> <?= htmlspecialchars($k['alet_adi']) ?> (<?= htmlspecialchars($k['seri_no']) ?>)</div>
<div class="mb-2"><strong>Kalibrasyon Tarihi:</strong> <?= isset($k['kalibrasyon_tarihi']) ? formatDate($k['kalibrasyon_tarihi']) : '-' ?></div>
<div class="mb-2"><strong>Geçerlilik Süresi:</strong> <?= isset($k['gecerlilik_suresi']) ? htmlspecialchars($k['gecerlilik_suresi']) . ' ay' : '-' ?></div>
<div class="mb-2"><strong>Sonraki Kalibrasyon:</strong> <?= isset($k['sonraki_kalibrasyon_tarihi']) ? formatDate($k['sonraki_kalibrasyon_tarihi']) : '-' ?></div>
<div class="mb-2"><strong>Sertifika No:</strong> <?= isset($k['sertifika_no']) ? htmlspecialchars($k['sertifika_no']) : '-' ?></div>
<div class="mb-2"><strong>Firma:</strong> <?= isset($k['firma']) ? htmlspecialchars($k['firma']) : '-' ?></div>
<div class="mb-2"><strong>Açıklama:</strong> <?= isset($k['aciklama']) ? nl2br(htmlspecialchars($k['aciklama'])) : '-' ?></div>
