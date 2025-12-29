// Kalibrasyon işlemleri için sadece Select2 ve AJAX ile alet arama

$('#yeniKalibrasyonModal').on('shown.bs.modal', function () {
    // Eski select2'yi kaldır
    if ($.fn.select2 && $('#alet_id').hasClass('select2-hidden-accessible')) {
        $('#alet_id').select2('destroy');
    }
    $('#alet_id').val(null).trigger('change');
    $('#alet_id').select2({
        dropdownParent: $('#yeniKalibrasyonModal'),
        width: '100%',
        placeholder: 'Alet adı veya seri no ile ara',
        allowClear: true,
        minimumInputLength: 2,
        ajax: {
            url: 'aletleri_getir.php',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term // arama terimi
                };
            },
            processResults: function (data, params) {
                params = params || {}; // params undefined ise boş obje yap
                return {
                    results: data.map(function(alet) {
                        return {
                            id: alet.id,
                            text: alet.adi + ' (' + alet.seri_no + ')',
                            kalibrasyon_durumu: alet.kalibrasyon_durumu
                        };
                    })
                };
            },
            cache: true,
            error: function(xhr, status, error) {
                console.error('Select2 AJAX error:', status, error, xhr.responseText);
            }
        },
        templateResult: function (data) {
            if (data.loading) return data.text;
            var $result = $('<span>' + data.text +
                (data.kalibrasyon_durumu ? ' <small class="text-muted">[' + data.kalibrasyon_durumu + ']</small>' : '') +
                '</span>');
            return $result;
        }
    });
});

function kalibrasyonDetay(id) {
    $('#kalibrasyonDetayModal .modal-body').html('<div class="text-center text-muted">Yükleniyor...</div>');
    fetch('kalibrasyon_detay.php?id=' + id)
        .then(r => r.text())
        .then(html => {
            $('#kalibrasyonDetayModal .modal-body').html(html);
        });
    var modal = new bootstrap.Modal(document.getElementById('kalibrasyonDetayModal'));
    modal.show();
}

function kalibrasyonDuzenle(id) {
    $('#kalibrasyonDuzenleModal .modal-body').html('<div class="text-center text-muted">Yükleniyor...</div>');
    fetch('kalibrasyon_duzenle.php?id=' + id)
        .then(r => r.text())
        .then(html => {
            $('#kalibrasyonDuzenleModal .modal-body').html(html);
        });
    var modal = new bootstrap.Modal(document.getElementById('kalibrasyonDuzenleModal'));
    modal.show();
}

function yeniKalibrasyon(alet_id) {
    // Modalı aç ve select2'yi tetikle
    var modal = new bootstrap.Modal(document.getElementById('yeniKalibrasyonModal'));
    modal.show();
    setTimeout(function() {
        $('#alet_id').val(alet_id).trigger('change');
    }, 300);
}

function kalibrasyonGuncelle() {
    var form = document.getElementById('kalibrasyonDuzenleForm');
    var formData = new FormData(form);
    fetch('kalibrasyon_guncelle.php', {
        method: 'POST',
        body: formData
    })
    .then(r => r.json())
    .then(res => {
        if (res.success) {
            alert('Güncelleme başarılı!');
            var modal = bootstrap.Modal.getInstance(document.getElementById('kalibrasyonDuzenleModal'));
            modal.hide();
            window.location.reload();
        } else {
            alert('Hata: ' + (res.message || 'Bilinmeyen hata'));
        }
    })
    .catch(() => alert('İşlem sırasında hata oluştu.'));
}
