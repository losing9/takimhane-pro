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
<form id="kalibrasyonDuzenleForm">
    <input type="hidden" name="id" value="<?= $k['id'] ?>">
    <div class="mb-2">
        <label class="form-label">Alet</label>
        <input type="text" class="form-control" value="<?= htmlspecialchars($k['alet_adi']) ?> (<?= htmlspecialchars($k['seri_no']) ?>)" disabled>
    </div>
    <div class="mb-2">
        <label class="form-label">Kalibrasyon Tarihi</label>
        <input type="date" class="form-control" name="kalibrasyon_tarihi" value="<?= htmlspecialchars($k['kalibrasyon_tarihi']) ?>" required>
    </div>
    <div class="mb-2">
        <label class="form-label">Geçerlilik Süresi (Ay)</label>
        <input type="number" class="form-control" name="gecerlilik_suresi" value="<?= htmlspecialchars($k['gecerlilik_suresi']) ?>" required>
    </div>
    <div class="mb-2">
        <label class="form-label">Sertifika No</label>
        <input type="text" class="form-control" name="sertifika_no" value="<?= htmlspecialchars($k['sertifika_no']) ?>" required>
    </div>
    <div class="mb-2">
        <label class="form-label">Firma</label>
        <input type="text" class="form-control" name="firma" value="<?= htmlspecialchars($k['firma']) ?>" required>
    </div>
    <div class="mb-2">
        <label class="form-label">Açıklama</label>
        <textarea class="form-control" name="aciklama" rows="2"><?= htmlspecialchars($k['aciklama']) ?></textarea>
    </div>
</form>
