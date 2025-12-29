<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

// Personel ve alet listelerini al
$personelListesi = getPersonelListesi();
$aletListesi = getAletListesi();

// İş emirlerini al
$stmt = $db->prepare("
    SELECT id, is_emri_no 
    FROM is_emirleri 
    WHERE durum = 'devam_ediyor'
    ORDER BY id DESC
");
$stmt->execute();
$isEmirleri = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasar Yönetimi - Takımhane Takip</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.4.33/sweetalert2.min.css" />
</head>
<body>
    <?php include '../../includes/header.php'; ?>

    <div class="container mt-4">
        <div class="row">
            <!-- Yeni Hasar Tutanağı -->
            <div class="col-md-12 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="bi bi-exclamation-triangle"></i> Yeni Hasar Tutanağı</h5>
                    </div>
                    <div class="card-body">
                        <form id="hasarForm">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="personel_input" class="form-label">Personel</label>
                                        <input type="text" class="form-control" id="personel_input" 
                                               placeholder="Personel adı veya sicil no ile ara..."
                                               autocomplete="off" required>
                                        <input type="hidden" id="personel_id" name="personel_id">
                                        <ul class="list-group position-absolute w-100 d-none" id="personel_results"></ul>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="alet_input" class="form-label">Alet</label>
                                        <input type="text" class="form-control" id="alet_input" 
                                               placeholder="Seri no veya alet adı ile ara..."
                                               autocomplete="off" required>
                                        <input type="hidden" id="alet_id" name="alet_id">
                                        <ul class="list-group position-absolute w-100 d-none" id="alet_results"></ul>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="hasar_tarihi" class="form-label">Hasar Tarihi</label>
                                        <input type="datetime-local" class="form-control" id="hasar_tarihi" 
                                               name="hasar_tarihi" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="hasar_yeri" class="form-label">Hasar Yeri</label>
                                        <input type="text" class="form-control" id="hasar_yeri" 
                                               name="hasar_yeri" required>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="hasar_turu" class="form-label">Hasar Türü</label>
                                        <select class="form-select" id="hasar_turu" name="hasar_turu" required>
                                            <option value="">Seçiniz</option>
                                            <option value="Fiziksel Hasar">Fiziksel Hasar</option>
                                            <option value="Elektronik Arıza">Elektronik Arıza</option>
                                            <option value="Kalibrasyon Hatası">Kalibrasyon Hatası</option>
                                            <option value="Yazılım Sorunu">Yazılım Sorunu</option>
                                            <option value="Diğer">Diğer</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="tahmini_maliyet" class="form-label">Tahmini Maliyet</label>
                                        <input type="number" class="form-control" id="tahmini_maliyet" 
                                               name="tahmini_maliyet" step="0.01" min="0">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label for="is_emri_no" class="form-label">İş Emri No</label>
                                        <input type="text" class="form-control" id="is_emri_no" 
                                               name="is_emri_no">
                                        <small class="form-text text-muted">İş emri numarasını manuel giriniz</small>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="hasar_nedeni" class="form-label">Hasar Nedeni</label>
                                        <textarea class="form-control" id="hasar_nedeni" name="hasar_nedeni" 
                                                  rows="3" required></textarea>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="hasar_aciklamasi" class="form-label">Hasar Açıklaması</label>
                                        <textarea class="form-control" id="hasar_aciklamasi" name="hasar_aciklamasi" 
                                                  rows="3" required></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="text-end">
                                <button type="submit" class="btn btn-primary" id="hasarKaydetBtn">
                                    <i class="bi bi-save"></i> Tutanak Oluştur
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Hasar Listesi -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5><i class="bi bi-list-ul"></i> Hasar Tutanakları</h5>
                        <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-durum="beklemede">Bekleyenler</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-durum="incelemede">İncelemede</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-durum="onarildi">Onarılanlar</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-durum="onarilamaz">Onarılamayanlar</button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Tutanak No</th>
                                        <th>Tarih</th>
                                        <th>Alet</th>
                                        <th>Personel</th>
                                        <th>Hasar Türü</th>
                                        <th>Durum</th>
                                        <th>Maliyet</th>
                                        <th>İşlem</th>
                                    </tr>
                                </thead>
                                <tbody id="hasarListesi">
                                    <!-- JavaScript ile doldurulacak -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Durum Güncelleme Modalı -->
    <div class="modal fade" id="durumModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Durum Güncelle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="durumForm">
                        <input type="hidden" id="tutanak_id" name="tutanak_id">
                        <div class="mb-3">
                            <label for="durum" class="form-label">Durum</label>
                            <select class="form-select" id="durum" name="durum" required>
                                <option value="beklemede">Beklemede</option>
                                <option value="incelemede">İncelemede</option>
                                <option value="onarilabilir">Onarılabilir</option>
                                <option value="onarilamaz">Onarılamaz</option>
                                <option value="onarildi">Onarıldı</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="gercek_maliyet" class="form-label">Gerçek Maliyet</label>
                            <input type="number" class="form-control" id="gercek_maliyet" 
                                   name="gercek_maliyet" step="0.01" min="0">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-primary" id="durumGuncelleBtn">Güncelle</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Servise Gönder Modal -->
    <div class="modal fade" id="servisModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Servise Gönder</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="servisForm">
                        <input type="hidden" name="id" id="hasar_id">
                        <div class="mb-3">
                            <label>Firma <span class="text-danger">*</span></label>
                            <input type="text" name="firma" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Gönderim Tarihi <span class="text-danger">*</span></label>
                            <input type="date" name="gonderim_tarihi" class="form-control" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label>Tahmini Dönüş Tarihi <span class="text-danger">*</span></label>
                            <input type="date" name="tahmini_donus_tarihi" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Servis No</label>
                            <input type="text" name="servis_no" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label>Açıklama</label>
                            <textarea name="servis_aciklama" class="form-control" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-primary" id="servisGonderBtn">Gönder</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.4.33/sweetalert2.min.js"></script>
    <script>
        // Personel ve alet listelerini JavaScript değişkenlerine aktar
        const personelListesi = <?php echo json_encode($personelListesi); ?>;
        const aletListesi = <?php echo json_encode($aletListesi); ?>;

        $(document).ready(function() {
            // Hasar listesini yükle
            loadHasarListesi();

            // Personel araması
            $('#personel_input').on('input', function() {
                const input = $(this).val().toLowerCase();
                const results = $('#personel_results');
                
                if (input.length < 2) {
                    results.addClass('d-none').html('');
                    return;
                }

                const matches = personelListesi.filter(p => 
                    p.sicil_no.toLowerCase().includes(input) || 
                    (p.ad + ' ' + p.soyad).toLowerCase().includes(input)
                );

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
                        <li class="list-group-item list-group-item-action" 
                            data-id="${a.id}" 
                            data-value="${a.seri_no} - ${a.adi}">
                            ${a.seri_no} - ${a.adi}
                        </li>
                    `).join('')).removeClass('d-none');
                } else {
                    results.html('<li class="list-group-item">Sonuç bulunamadı</li>').removeClass('d-none');
                }
            });

            // Personel seçimi
            $(document).on('click', '#personel_results li[data-id]', function() {
                const id = $(this).data('id');
                const value = $(this).data('value');
                $('#personel_id').val(id);
                $('#personel_input').val(value);
                $('#personel_results').addClass('d-none');
            });

            // Alet seçimi
            $(document).on('click', '#alet_results li[data-id]', function() {
                const id = $(this).data('id');
                const value = $(this).data('value');
                $('#alet_id').val(id);
                $('#alet_input').val(value);
                $('#alet_results').addClass('d-none');
            });

            // Hasar formu gönderimi
            $('#hasarForm').on('submit', function(e) {
                e.preventDefault();
                
                const formData = new FormData(this);
                
                $.ajax({
                    url: 'ekle.php',
                    method: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Başarılı!',
                                text: 'Hasar tutanağı başarıyla oluşturuldu.',
                                showConfirmButton: false,
                                timer: 1500
                            }).then(function() {
                                $('#hasarForm')[0].reset();
                                loadHasarListesi();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Hata!',
                                text: response.message || 'Bir hata oluştu!'
                            });
                        }
                    },
                    error: function(xhr) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            Swal.fire({
                                icon: 'error',
                                title: 'Hata!',
                                text: response.message || 'Bir hata oluştu!'
                            });
                        } catch(e) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Hata!',
                                text: 'Bir hata oluştu!'
                            });
                        }
                    }
                });
            });

            // Durum güncelleme
            $('#durumGuncelleBtn').click(function() {
                const formData = new FormData($('#durumForm')[0]);
                
                $.ajax({
                    url: 'guncelle.php',
                    method: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Başarılı!',
                                text: 'Durum başarıyla güncellendi.',
                                showConfirmButton: false,
                                timer: 1500
                            }).then(function() {
                                $('#durumModal').modal('hide');
                                loadHasarListesi();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Hata!',
                                text: response.message || 'Bir hata oluştu!'
                            });
                        }
                    },
                    error: function(xhr) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            Swal.fire({
                                icon: 'error',
                                title: 'Hata!',
                                text: response.message || 'Bir hata oluştu!'
                            });
                        } catch(e) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Hata!',
                                text: 'Bir hata oluştu!'
                            });
                        }
                    }
                });
            });

            // Servise gönderme işlemi
            function serviseGonder(hasarId) {
                $('#hasar_id').val(hasarId);
                $('#servisModal').modal('show');
            }

            // Servis gönderme formu submit
            $('#servisGonderBtn').on('click', function() {
                var form = $('#servisForm')[0];
                if (!form.checkValidity()) {
                    form.reportValidity();
                    return;
                }

                // Form verilerini kontrol et
                var formData = $('#servisForm').serialize();
                console.log('Form verileri:', formData);

                $.ajax({
                    url: 'servise_gonder.php',
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Başarılı!',
                                text: response.message
                            }).then(() => {
                                $('#servisModal').modal('hide');
                                $('#servisForm')[0].reset();
                                loadHasarListesi();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Hata!',
                                text: response.message
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Ajax hatası:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Hata!',
                            text: 'Bir hata oluştu. Lütfen tekrar deneyin.'
                        });
                    }
                });
            });

            // Durum filtreleme
            $('.btn-group button').click(function() {
                $(this).siblings().removeClass('active');
                $(this).addClass('active');
                loadHasarListesi($(this).data('durum'));
            });
        });

        // Hasar listesini yükle
        function loadHasarListesi(durum = null) {
            let url = 'listele.php';
            if (durum) {
                url += '?durum=' + durum;
            }

            $.getJSON(url, function(response) {
                if (response.success) {
                    const tutanaklar = response.tutanaklar;
                    $('#hasarListesi').html(tutanaklar.map(t => `
                        <tr>
                            <td>${t.tutanak_no}</td>
                            <td>${formatDate(t.hasar_tarihi)}</td>
                            <td>${t.alet_seri_no} - ${t.alet_adi}</td>
                            <td>${t.personel_sicil_no} - ${t.personel_ad_soyad}</td>
                            <td>${t.hasar_turu}</td>
                            <td>${formatDurum(t.durum)}</td>
                            <td>${formatMoney(t.gercek_maliyet || t.tahmini_maliyet)}</td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-info btn-sm" onclick="durumGuncelle(${t.id}, '${t.durum}', ${t.gercek_maliyet || t.tahmini_maliyet})">
                                        <i class="bi bi-pencil"></i> Durum
                                    </button>
                                    ${t.durum === 'beklemede' || t.durum === 'incelemede' ? `
                                        <button type="button" class="btn btn-primary btn-sm" onclick="serviseGonder(${t.id})">
                                            <i class="bi bi-tools"></i> Servise Gönder
                                        </button>
                                    ` : ''}
                                    <a href="tutanak_pdf.php?id=${t.id}" target="_blank" class="btn btn-danger btn-sm">
                                        <i class="bi bi-file-pdf"></i> PDF
                                    </a>
                                </div>
                            </td>
                        </tr>
                    `).join(''));
                }
            });
        }

        // Durum güncelleme modalını aç
        function durumGuncelle(id, durum, maliyet) {
            $('#tutanak_id').val(id);
            $('#durum').val(durum);
            $('#gercek_maliyet').val(maliyet);
            $('#durumModal').modal('show');
        }

        // Servise gönder butonuna basılınca modal açılır
        function serviseGonder(hasarId) {
            $('#hasar_id').val(hasarId);
            $('#servisModal').modal('show');
        }

        // Tarih formatla
        function formatDate(date) {
            return new Date(date).toLocaleString('tr-TR');
        }

        // Para formatla
        function formatMoney(amount) {
            return parseFloat(amount).toLocaleString('tr-TR', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }) + ' ₺';
        }

        // Durum formatla
        function formatDurum(durum) {
            const durumlar = {
                'beklemede': ['warning', 'Beklemede'],
                'incelemede': ['info', 'İncelemede'],
                'onarilabilir': ['primary', 'Onarılabilir'],
                'onarilamaz': ['danger', 'Onarılamaz'],
                'onarildi': ['success', 'Onarıldı']
            };

            const [color, text] = durumlar[durum] || ['secondary', durum];
            return `<span class="badge bg-${color}">${text}</span>`;
        }
    </script>
</body>
</html>
