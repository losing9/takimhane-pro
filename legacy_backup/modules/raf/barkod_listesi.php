<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';
require_once '../../includes/qr_functions.php';
include_once '../../includes/header.php';

// Tüm rafları çek
$stmt = $db->query("SELECT * FROM raf_listesi ORDER BY adi ASC");
$raflar = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2><i class="bi bi-shelves"></i> Raf QR Kod/Etiket Listesi</h2>
        <a href="barkod_listesi_yazdir.php" class="btn btn-success" target="_blank"><i class="bi bi-printer"></i> Etiket Yazıcı Listesi</a>
    </div>
    <div class="row">
        <?php foreach($raflar as $raf): ?>
        <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
            <div class="card h-100 text-center p-2">
                <div class="card-body">
                    <div class="mb-2">
                        <?php
                        // QR kod verisi: raf ve içerik
                        $stmt2 = $db->prepare("SELECT * FROM aletler WHERE raf_id=?");
                        $stmt2->execute([$raf['id']]);
                        $aletler = $stmt2->fetchAll(PDO::FETCH_ASSOC);
                        $qrData ="\nRaf: " . $raf['adi'];
                        if(count($aletler) > 0) {
                            $qrData .= "\n--- Envanter ---";
                            foreach($aletler as $a) {
                                $qrData .= "\n" . $a['adi'] . " (" . $a['seri_no'] . ")";
                            }
                        }
                        $qrBase64 = generateQrCodeBase64($qrData);
                        ?>
                        <img src="<?= $qrBase64 ?>" width="180" height="180" alt="QR Kod" class="border rounded bg-white p-2 mb-2">
                    </div>
                    <div><b><?= htmlspecialchars($raf['adi']) ?></b></div>
                    <div class="text-muted small">Konum: <?= htmlspecialchars($raf['konum']) ?></div>
                    <div class="text-muted small">ID: <?= $raf['id'] ?></div>
                </div>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
</div>
<?php include_once '../../includes/footer.php'; ?>
