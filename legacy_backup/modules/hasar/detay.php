<?php
require_once '../../includes/header.php';
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Hasar ID'sini al
$hasar_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Hasar bilgilerini getir
$stmt = $db->prepare("
    SELECT ht.*, a.adi as alet_adi, a.seri_no, 
           a.durum as alet_durumu,
           CONCAT(p.ad, ' ', p.soyad) as zimmetli_personel
    FROM hasar_tutanaklari ht
    JOIN aletler a ON ht.alet_id = a.id
    LEFT JOIN personel p ON a.zimmetli_personel_id = p.id
    WHERE ht.id = ?
");
$stmt->execute([$hasar_id]);
$hasar = $stmt->fetch(PDO::FETCH_ASSOC);

// Hasar bulunamazsa ana sayfaya yönlendir
if (!$hasar) {
    header('Location: index.php');
    exit;
}

// Servis geçmişini getir
$stmt = $db->prepare("
    SELECT si.*, ht.hasar_turu
    FROM servis_islemler si
    JOIN hasar_tutanaklari ht ON si.tutanak_id = ht.id
    WHERE si.tutanak_id = ?
    ORDER BY si.olusturma_tarihi DESC
");
$stmt->execute([$hasar_id]);
$servisler = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="container-fluid mt-3">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Hasar Detayı #<?php echo $hasar_id; ?></h3>
                    <div class="card-tools">
                        <a href="index.php" class="btn btn-secondary btn-sm">
                            <i class="fas fa-arrow-left"></i> Geri
                        </a>
                        <?php if ($hasar['durum'] == 'hasarli'): ?>
                        <button type="button" class="btn btn-primary btn-sm" onclick="serviseGonder(<?php echo $hasar_id; ?>)">
                            <i class="fas fa-tools"></i> Servise Gönder
                        </button>
                        <?php endif; ?>
                        <a href="tutanak_pdf.php?id=<?php echo $hasar_id; ?>" target="_blank" class="btn btn-danger btn-sm">
                            <i class="fas fa-file-pdf"></i> PDF İndir
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Alet Bilgileri -->
                    <h4>Alet Bilgileri</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <tr>
                                <th width="200">Alet Adı</th>
                                <td><?php echo htmlspecialchars($hasar['alet_adi']); ?></td>
                            </tr>
                            <tr>
                                <th>Seri No</th>
                                <td><?php echo htmlspecialchars($hasar['seri_no']); ?></td>
                            </tr>
                            <tr>
                                <th>Zimmetli Personel</th>
                                <td><?php echo htmlspecialchars($hasar['zimmetli_personel']); ?></td>
                            </tr>
                            <tr>
                                <th>Durum</th>
                                <td>
                                    <span class="badge <?php echo getDurumClass($hasar['durum']); ?>">
                                        <?php echo getDurumText($hasar['durum']); ?>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- Hasar Bilgileri -->
                    <h4 class="mt-4">Hasar Bilgileri</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <tr>
                                <th width="200">Hasar Türü</th>
                                <td><?php echo htmlspecialchars($hasar['hasar_turu']); ?></td>
                            </tr>
                            <tr>
                                <th>Hasar Tarihi</th>
                                <td><?php echo date('d.m.Y', strtotime($hasar['hasar_tarihi'])); ?></td>
                            </tr>
                            <tr>
                                <th>Tahmini Maliyet</th>
                                <td><?php echo number_format($hasar['tahmini_maliyet'], 2, ',', '.') . ' ₺'; ?></td>
                            </tr>
                            <tr>
                                <th>Gerçek Maliyet</th>
                                <td><?php echo $hasar['gercek_maliyet'] ? number_format($hasar['gercek_maliyet'], 2, ',', '.') . ' ₺' : '-'; ?></td>
                            </tr>
                            <tr>
                                <th>Açıklama</th>
                                <td><?php echo nl2br(htmlspecialchars($hasar['aciklama'])); ?></td>
                            </tr>
                        </table>
                    </div>

                    <?php if (!empty($servisler)): ?>
                    <!-- Servis Geçmişi -->
                    <h4 class="mt-4">Servis Geçmişi</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Firma</th>
                                    <th>İş Emri No</th>
                                    <th>Gönderim Tarihi</th>
                                    <th>Tahmini Dönüş</th>
                                    <th>Durum</th>
                                    <th>Maliyet</th>
                                    <th>Açıklama</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($servisler as $servis): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($servis['firma']); ?></td>
                                    <td><?php echo htmlspecialchars($servis['is_emri_no']); ?></td>
                                    <td><?php echo date('d.m.Y', strtotime($servis['gonderim_tarihi'])); ?></td>
                                    <td><?php echo date('d.m.Y', strtotime($servis['tahmini_donus_tarihi'])); ?></td>
                                    <td>
                                        <span class="badge <?php echo getDurumClass($servis['durum']); ?>">
                                            <?php echo getDurumText($servis['durum']); ?>
                                        </span>
                                    </td>
                                    <td><?php echo $servis['maliyet'] ? number_format($servis['maliyet'], 2, ',', '.') . ' ₺' : '-'; ?></td>
                                    <td><?php echo nl2br(htmlspecialchars($servis['aciklama'])); ?></td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Servise Gönder Modal -->
<div class="modal fade" id="servisModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Servise Gönder</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="servisForm">
                    <input type="hidden" name="hasar_tutanak_id" id="hasar_tutanak_id">
                    <div class="form-group">
                        <label>İş Emri No <span class="text-danger">*</span></label>
                        <input type="text" name="is_emri_no" class="form-control" required>
                        <small class="form-text text-muted">İş emri numarasını manuel olarak giriniz</small>
                    </div>
                    <div class="form-group">
                        <label>Firma <span class="text-danger">*</span></label>
                        <input type="text" name="firma" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Gönderim Tarihi <span class="text-danger">*</span></label>
                        <input type="date" name="gonderim_tarihi" class="form-control" value="<?php echo date('Y-m-d'); ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Tahmini Dönüş Tarihi <span class="text-danger">*</span></label>
                        <input type="date" name="tahmini_donus_tarihi" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Servis No</label>
                        <input type="text" name="servis_no" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Açıklama</label>
                        <textarea name="servis_aciklama" class="form-control" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">İptal</button>
                <button type="button" class="btn btn-primary" id="servisGonderBtn">Gönder</button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Servis gönderme işlemi
    $('#servisGonderBtn').click(function(e) {
        e.preventDefault();
        var form = $('#servisForm');
        
        // Form validasyonu
        if (!form.find('[name="is_emri_no"]').val()) {
            Swal.fire({
                icon: 'error',
                title: 'Hata!',
                text: 'İş emri numarası gereklidir!'
            });
            return;
        }

        if (!form.find('[name="firma"]').val()) {
            Swal.fire({
                icon: 'error',
                title: 'Hata!',
                text: 'Firma bilgisi gereklidir!'
            });
            return;
        }

        if (!form.find('[name="gonderim_tarihi"]').val()) {
            Swal.fire({
                icon: 'error',
                title: 'Hata!',
                text: 'Gönderim tarihi gereklidir!'
            });
            return;
        }

        if (!form.find('[name="tahmini_donus_tarihi"]').val()) {
            Swal.fire({
                icon: 'error',
                title: 'Hata!',
                text: 'Tahmini dönüş tarihi gereklidir!'
            });
            return;
        }

        // Form verilerini gönder
        $.ajax({
            url: '../servis/servis_kaydet.php',
            type: 'POST',
            data: form.serialize(),
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Başarılı!',
                        text: response.message,
                        showConfirmButton: false,
                        timer: 1500
                    }).then(function() {
                        window.location.reload();
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Hata!',
                        text: response.message || 'Bir hata oluştu!'
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                Swal.fire({
                    icon: 'error',
                    title: 'Hata!',
                    text: 'Sunucu ile iletişim kurulurken bir hata oluştu!'
                });
            }
        });
    });
});

function serviseGonder(tutanakId) {
    $('#hasar_tutanak_id').val(tutanakId);
    $('#servisModal').modal('show');
}

// Durum badge rengini belirle
function getDurumClass(durum) {
    switch (durum) {
        case 'servise_gonderildi':
            return 'bg-info';
        case 'serviste':
            return 'bg-primary';
        case 'onarildi':
            return 'bg-success';
        case 'onarilamaz':
            return 'bg-danger';
        case 'pert':
            return 'bg-dark';
        case 'hasarli':
            return 'bg-warning';
        default:
            return 'bg-secondary';
    }
}

// Durum metnini formatla
function getDurumText(durum) {
    switch (durum) {
        case 'servise_gonderildi':
            return 'Servise Gönderildi';
        case 'serviste':
            return 'Serviste';
        case 'onarildi':
            return 'Onarıldı';
        case 'onarilamaz':
            return 'Onarılamaz';
        case 'pert':
            return 'Pert';
        case 'hasarli':
            return 'Hasarlı';
        default:
            return durum;
    }
}
</script>

<?php require_once '../../includes/footer.php'; ?>
