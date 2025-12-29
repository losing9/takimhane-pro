<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';
include_once '../../includes/header.php';

// Rafları getir
$stmt = $db->query("SELECT * FROM raf_listesi ORDER BY id DESC");
$raflar = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2><i class="fa fa-archive"></i> Raf Listesi</h2>
        <button class="btn btn-primary" onclick="showRafEkleModal()"><i class="fa fa-plus"></i> Yeni Raf Ekle</button>
    </div>
    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Raf Adı</th>
                    <th>Konum</th>
                    <th>İşlemler</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($raflar as $raf): ?>
                <tr>
                    <td><?= htmlspecialchars($raf['adi']) ?></td>
                    <td><?= htmlspecialchars($raf['konum']) ?></td>
                    <td>
                        <a href="raf_icerik.php?id=<?= $raf['id'] ?>" class="btn btn-sm btn-info" title="İçerik"><i class="fa fa-list"></i> Envanter</a>
                        <button class="btn btn-sm btn-secondary" title="QR Kod" onclick="showQrModal(<?= $raf['id'] ?>, '<?= htmlspecialchars($raf['adi'], ENT_QUOTES) ?>')"><i class="fa fa-qrcode"></i> QR</button>
                        <button class="btn btn-sm btn-warning" onclick="showRafDuzenleModal(<?= $raf['id'] ?>, '<?= htmlspecialchars($raf['adi'], ENT_QUOTES) ?>', '<?= htmlspecialchars($raf['konum'], ENT_QUOTES) ?>')"><i class="fa fa-edit"></i> Düzenle</button>
                        <button class="btn btn-sm btn-danger" onclick="rafSil(<?= $raf['id'] ?>)"><i class="fa fa-trash"></i> Sil</button>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <div id="rafModal" style="display:none;"></div>
    <!-- QR Modal -->
    <div class="modal fade" id="qrModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="qrModalLabel">Raf QR Kodu</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
          </div>
          <div class="modal-body text-center" id="qrModalBody">
            <!-- QR kod buraya gelecek -->
          </div>
        </div>
      </div>
    </div>
</div>
<script src="raf.js"></script>
<script>
function showQrModal(rafId, rafAdi) {
    fetch('raf_icerik.php?id=' + rafId + '&qr_only=1')
        .then(r => r.text())
        .then(html => {
            document.getElementById('qrModalBody').innerHTML = html;
            var qrModal = new bootstrap.Modal(document.getElementById('qrModal'));
            qrModal.show();
        });
}
</script>
<?php include_once '../../includes/footer.php'; ?>
