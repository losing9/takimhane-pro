<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';
require_once '../../includes/qr_functions.php';

$raf_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$stmt = $db->prepare("SELECT * FROM raf_listesi WHERE id=?");
$stmt->execute([$raf_id]);
$raf = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$raf) { echo '<div class="alert alert-danger m-4">Raf bulunamadı.</div>'; exit; }

// Bu raftaki aletler
$stmt2 = $db->prepare("SELECT * FROM aletler WHERE raf_id=?");
$stmt2->execute([$raf_id]);
$aletler = $stmt2->fetchAll(PDO::FETCH_ASSOC);

// QR kodları için aletleri 10'lu gruplara böl
$qrList = array_chunk($aletler, 10);
$qrCodes = [];
foreach ($qrList as $i => $group) {
    $qrData = 'Raf ID: ' . ($raf['id'] ?? '-') . "\nRaf: " . ($raf['adi'] ?? '-');
    if (count($qrList) > 1) {
        $qrData .= "\nSayfa: " . ($i+1) . "/" . count($qrList);
    }
    if (is_array($group) && count($group) > 0) {
        $qrData .= "\n--- İçerik ---";
        foreach($group as $a) {
            $adi = $a['adi'] ?? '';
            $seri = $a['seri_no'] ?? '';
            $qrData .= "\n" . $adi . " (" . $seri . ")";
        }
    }
    $qrCodes[] = generateQrCodeBase64($qrData);
}

if (isset($_GET['qr_only']) && $_GET['qr_only'] == '1') {
    foreach ($qrCodes as $qrBase64) {
        echo '<img src="' . $qrBase64 . '" width="220" height="220" alt="QR Kod" class="border rounded bg-white p-2 shadow m-2">';
    }
    exit;
}
include_once '../../includes/header.php';
?>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2><i class="fa fa-archive"></i> <?= htmlspecialchars($raf['adi']) ?> <small class="text-muted">(<?= htmlspecialchars($raf['konum']) ?>)</small></h2>
        <div>
        <?php foreach ($qrCodes as $qrBase64): ?>
            <img src="<?= $qrBase64 ?>" width="220" height="220" alt="QR Kod" class="border rounded bg-white p-2 shadow m-2">
        <?php endforeach; ?>
        </div>
    </div>
    <div class="card mb-4">
        <div class="card-header bg-primary text-white"><b>Bu Raftaki Aletler</b></div>
        <div class="table-responsive">
            <table class="table table-striped table-bordered mb-0">
                <thead class="table-dark">
                    <tr><th>ID</th><th>Adı</th><th>Seri No</th></tr>
                </thead>
                <tbody>
                <?php if(count($aletler) === 0): ?>
                    <tr><td colspan="3" class="text-center text-muted">Bu rafta kayıtlı alet yok.</td></tr>
                <?php else: foreach($aletler as $a): ?>
                    <tr><td><?= $a['id'] ?></td><td><?= htmlspecialchars($a['adi']) ?></td><td><?= htmlspecialchars($a['seri_no']) ?></td></tr>
                <?php endforeach; endif; ?>
                </tbody>
            </table>
        </div>
    </div>
    <a href="index.php" class="btn btn-secondary"><i class="fa fa-arrow-left"></i> Raf Listesine Dön</a>
</div>
<?php include_once '../../includes/footer.php'; ?>
