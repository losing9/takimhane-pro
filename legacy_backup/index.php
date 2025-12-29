<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

session_start();
require_once './config/database.php';
require_once './includes/functions.php';

// Oturum kontrolü
checkLogin();

// Debug: Veritabanı bağlantısını kontrol et
if (!$db) {
    die("Veritabanı bağlantısı kurulamadı");
}

try {
    // Debug bilgisi
    echo "<!-- Debug başlangıç -->";
    
    // İstatistikleri ve listeleri al
    $istatistikler = getAletIstatistikleri();
    echo "<!-- İstatistikler alındı -->";
    
    $gunlukOduncler = getGunlukOduncKayitlari();
    echo "<!-- Günlük ödünç kayıtları alındı: " . count($gunlukOduncler) . " kayıt -->";
    
    $iadeEdilmemisler = getIadeEdilmemisAletler();
    echo "<!-- İade edilmemiş aletler alındı: " . count($iadeEdilmemisler) . " kayıt -->";
    
    $personelListesi = getPersonelListesi();
    echo "<!-- Personel listesi alındı: " . count($personelListesi) . " kayıt -->";
    
    $aletListesi = getAletListesi();
    echo "<!-- Alet listesi alındı: " . count($aletListesi) . " kayıt -->";
    
    echo "<!-- Debug bitiş -->";
    
    // Debug: Listeleri kontrol et
    error_log('Ana Sayfa - Personel sayısı: ' . count($personelListesi));
    error_log('Ana Sayfa - Alet sayısı: ' . count($aletListesi));
    
} catch (Exception $e) {
    error_log('Ana sayfa hata: ' . $e->getMessage());
    die("Bir hata oluştu: " . $e->getMessage());
}
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Takımhane Takip Sistemi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
</head>
<body>
    <?php include './includes/header.php'; ?>

    <div class="container mt-4">
        <!-- İstatistik kartları -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <h5><i class="bi bi-tools"></i> Toplam Alet</h5>
                        <h3><?php echo $istatistikler['toplam']; ?></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-dark">
                    <div class="card-body">
                        <h5><i class="bi bi-wrench"></i> Servisteki Aletler</h5>
                        <h3><?php echo $istatistikler['servisteki']; ?></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-danger text-white">
                    <div class="card-body">
                        <h5><i class="bi bi-calendar-check"></i> Kalibrasyonda</h5>
                        <h3><?php echo $istatistikler['kalibrasyondaki']; ?></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-secondary text-white">
                    <div class="card-body">
                        <h5><i class="bi bi-dash-circle"></i> Pasif Aletler</h5>
                        <h3><?php echo $istatistikler['pasif']; ?></h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Ödünç İşlemleri -->
        <div class="row mb-4">
            <!-- Ödünç Verme Formu -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="bi bi-box-arrow-right"></i> Hızlı Ödünç Verme</h5>
                    </div>
                    <div class="card-body">
                        <?php
                        // Debug için personel ve alet listelerini kontrol et
                        if (empty($personelListesi)) {
                            echo '<div class="alert alert-warning">Personel listesi boş veya yüklenemedi.</div>';
                        }
                        if (empty($aletListesi)) {
                            echo '<div class="alert alert-warning">Alet listesi boş veya yüklenemedi.</div>';
                        }
                        ?>
                        <form id="oduncVerForm" action="modules/odunc/ver.php" method="post">
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="mb-3">
                                        <label for="personel_input" class="form-label">Personel</label>
                                        <input type="text" class="form-control" id="personel_input" 
                                               placeholder="Personel adı veya sicil no ile ara..."
                                               autocomplete="off" required>
                                        <input type="hidden" id="personel_id" name="personel_id">
                                        <ul class="list-group position-absolute w-100 d-none" id="personel_results"></ul>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="mb-3">
                                        <label for="alet_input" class="form-label">Alet(ler)</label>
                                        <input type="text" class="form-control" id="alet_input" placeholder="Seri no veya alet adı ile ara..." autocomplete="off">
                                        <ul class="list-group position-absolute w-100 d-none" id="alet_results"></ul>
                                        <div id="selected_aletler" class="mt-2"></div>
                                        <input type="hidden" id="alet_ids" name="alet_ids">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label class="form-label">&nbsp;</label>
                                        <button type="submit" class="btn btn-primary w-100" id="oduncVerBtn" disabled>
                                            <i class="bi bi-box-arrow-right"></i> Ödünç Ver
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Günlük Ödünç Kayıtları -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="bi bi-clock-history"></i> Bugünkü Ödünç Kayıtları</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Saat</th>
                                <th>İşlem</th>
                                <th>Personel</th>
                                <th>Alet</th>
                                <th>Durum</th>
                                <th>İşlem</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($gunlukOduncler as $kayit): ?>
                            <tr>
                                <td><?php echo date('H:i', strtotime($kayit['verilis_tarihi'])); ?></td>
                                <td>
                                    <?php if ($kayit['iade_tarihi']): ?>
                                        <span class="badge bg-success">İade Alındı</span>
                                    <?php else: ?>
                                        <span class="badge bg-primary">Ödünç Verildi</span>
                                    <?php endif; ?>
                                </td>
                                <td><?php echo htmlspecialchars($kayit['personel_adi'] . ' ' . $kayit['personel_soyadi']); ?></td>
                                <td><?php echo htmlspecialchars($kayit['seri_no'] . ' - ' . $kayit['alet_adi']); ?></td>
                                <td>
                                    <?php if ($kayit['iade_tarihi']): ?>
                                        <span class="text-success">
                                            <i class="bi bi-check-circle"></i> 
                                            İade: <?php echo date('H:i', strtotime($kayit['iade_tarihi'])); ?>
                                        </span>
                                    <?php else: ?>
                                        <span class="text-primary">
                                            <i class="bi bi-arrow-right-circle"></i> 
                                            Henüz iade edilmedi
                                        </span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <?php if (!$kayit['iade_tarihi']): ?>
                                        <button type="button" class="btn btn-sm btn-success" 
                                                onclick="hizliIadeAl(<?php echo $kayit['id']; ?>)">
                                            <i class="bi bi-box-arrow-in-left"></i> İade Al
                                        </button>
                                    <?php endif; ?>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- İade Edilmemiş Eski Aletler Uyarısı -->
        <?php if (!empty($iadeEdilmemisler)): ?>
        <div class="card border-danger">
            <div class="card-header bg-danger text-white">
                <h5><i class="bi bi-exclamation-triangle"></i> İade Edilmemiş Eski Aletler</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Personel</th>
                                <th>Alet</th>
                                <th>Veriliş Tarihi</th>
                                <th>Geçen Süre</th>
                                <th>İşlem</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($iadeEdilmemisler as $kayit): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($kayit['personel_adi'] . ' ' . $kayit['personel_soyadi']); ?></td>
                                <td><?php echo htmlspecialchars($kayit['seri_no'] . ' - ' . $kayit['alet_adi']); ?></td>
                                <td><?php echo date('d.m.Y', strtotime($kayit['verilis_tarihi'])); ?></td>
                                <td>
                                    <span class="badge bg-danger"><?php echo $kayit['gecen_gun']; ?> gün</span>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-success" 
                                            onclick="hizliIadeAl(<?php echo $kayit['id']; ?>)">
                                        <i class="bi bi-box-arrow-in-left"></i> İade Al
                                    </button>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <?php endif; ?>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        // Personel ve alet listelerini JavaScript değişkenlerine aktar
        const personelListesi = <?php echo json_encode($personelListesi); ?>;
        const aletListesi = <?php echo json_encode($aletListesi); ?>;

        $(document).ready(function() {
            // Form submit
            $('#oduncVerForm').on('submit', function(e) {
                e.preventDefault();
                
                const personelId = $('#personel_id').val();
                const aletIds = $('#alet_ids').val();
                
                console.log('Form gönderiliyor:', {
                    personelId: personelId,
                    aletIds: aletIds
                });
                
                if (!personelId || !aletIds) {
                    alert('Lütfen personel ve en az bir alet seçin');
                    return;
                }

                const formData = $(this).serialize();
                console.log('Form verisi:', formData);

                $.ajax({
                    url: $(this).attr('action'),
                    method: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        console.log('Başarılı yanıt:', response);
                        if (response.success) {
                            alert('Alet(ler) başarıyla ödünç verildi.');
                            location.reload();
                        } else {
                            alert('Hata: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log('Hata detayı:', {
                            status: status,
                            error: error,
                            response: xhr.responseText
                        });
                        try {
                            const response = JSON.parse(xhr.responseText);
                            alert('Hata: ' + response.message);
                        } catch(e) {
                            alert('Bir hata oluştu: ' + error);
                        }
                    }
                });
            });

            // Personel araması
            $('#personel_input').on('input', function() {
                const input = $(this).val().toLowerCase();
                const results = $('#personel_results');
                
                console.log('Personel araması:', input);
                
                if (input.length < 2) {
                    results.addClass('d-none').html('');
                    return;
                }

                const matches = personelListesi.filter(p => 
                    p.sicil_no.toLowerCase().includes(input) || 
                    (p.ad + ' ' + p.soyad).toLowerCase().includes(input)
                );

                console.log('Eşleşen personel:', matches);

                if (matches.length > 0) {
                    results.html(matches.map(p => `
                        <li class="list-group-item list-group-item-action" 
                            data-id="${p.id}" 
                            data-value="${p.sicil_no} - ${p.ad} ${p.soyad}">
                            ${p.sicil_no} - ${p.ad} ${p.soyad}
                        </li>
                    `).join('')).removeClass('d-none');
                } else {
                    results.html('<li class="list-group-item">Sonuç bulunamadı</li>').removeClass('d-none');
                }
            });

            // Alet araması
            $('#alet_input').on('input', function() {
                const input = $(this).val().toLowerCase();
                const results = $('#alet_results');
                if (input.length < 2) {
                    results.addClass('d-none').html('');
                    return;
                }
                const matches = aletListesi.filter(a =>
                    a.seri_no.toLowerCase().includes(input) ||
                    a.adi.toLowerCase().includes(input)
                );
                if (matches.length > 0) {
                    results.html(matches.map(a => `
                        <li class="list-group-item list-group-item-action" data-id="${a.id}" data-value="${a.seri_no} - ${a.adi}">
                            ${a.seri_no} - ${a.adi}
                        </li>
                    `).join('')).removeClass('d-none');
                } else {
                    results.html('<li class="list-group-item">Sonuç bulunamadı</li>').removeClass('d-none');
                }
            });

            // Çoklu alet seçimi
            let selectedAletler = [];
            $(document).on('click', '#alet_results li[data-id]', function() {
                const id = $(this).data('id');
                const value = $(this).data('value');
                if (!selectedAletler.find(a => a.id == id)) {
                    selectedAletler.push({id, value});
                    updateSelectedAletler();
                }
                $('#alet_input').val('');
                $('#alet_results').addClass('d-none');
                checkForm();
            });
            function updateSelectedAletler() {
                const container = $('#selected_aletler');
                if (selectedAletler.length === 0) {
                    container.html('');
                    $('#alet_ids').val('');
                    return;
                }
                container.html(selectedAletler.map(a =>
                    `<span class="badge bg-info text-dark me-1 mb-1">${a.value} <a href="#" class="text-danger ms-1 remove-alet" data-id="${a.id}">&times;</a></span>`
                ).join(''));
                $('#alet_ids').val(selectedAletler.map(a => a.id).join(','));
            }
            $(document).on('click', '.remove-alet', function(e) {
                e.preventDefault();
                const id = $(this).data('id');
                selectedAletler = selectedAletler.filter(a => a.id != id);
                updateSelectedAletler();
                checkForm();
            });

            // Personel seçimi
            $(document).on('click', '#personel_results li[data-id]', function() {
                const id = $(this).data('id');
                const value = $(this).data('value');
                console.log('Personel seçildi:', { id, value });
                $('#personel_id').val(id);
                $('#personel_input').val(value);
                $('#personel_results').addClass('d-none');
                checkForm();
            });

            // Tıklama ile sonuç listelerini gizle
            $(document).on('click', function(e) {
                if (!$(e.target).closest('.mb-3').length) {
                    $('.list-group').addClass('d-none');
                }
            });

            // Form kontrolü
            function checkForm() {
                const personelId = $('#personel_id').val();
                const aletIds = $('#alet_ids').val();
                $('#oduncVerBtn').prop('disabled', !personelId || !aletIds);
            }
        });

        // Hızlı iade alma fonksiyonu
        function hizliIadeAl(oduncId) {
            if (confirm('Bu aleti iade almak istediğinizden emin misiniz?')) {
                $.post('modules/odunc/iade.php', {odunc_id: oduncId}, function(response) {
                    if (response.success) {
                        alert('Alet başarıyla iade alındı.');
                        location.reload();
                    } else {
                        alert('Hata: ' + response.message);
                    }
                });
            }
        }
    </script>
</body>
</html>
