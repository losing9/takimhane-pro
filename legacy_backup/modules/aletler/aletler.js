console.log('aletler.js yüklendi');

// Alet işlemleri için JavaScript fonksiyonları

function aletKaydet() {
    const formData = new FormData(document.getElementById('yeniAletForm'));
    
    $.ajax({
        url: 'alet_kaydet.php',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        dataType: 'json',
        success: function(response) {
            const result = response;
            if (result.success) {
                alert('Alet başarıyla kaydedildi.');
                $('#yeniAletModal').modal('hide');
                window.location.reload();
            } else {
                alert('Hata: ' + result.message);
            }
        },
        error: function() {
            alert('İşlem sırasında bir hata oluştu.');
        }
    });
}

function aletDetay(id) {
    $.ajax({
        url: 'alet_detay.php',
        method: 'GET',
        data: { id: id },
        success: function(response) {
            // Detay modalını göster
            $('#aletDetayModal .modal-body').html(response);
            $('#aletDetayModal').modal('show');
        }
    });
}

function aletDuzenle(id) {
    $.ajax({
        url: 'alet_getir.php',
        method: 'GET',
        data: { id: id },
        dataType: 'json',
        success: function(response) {
            const result = response;
            if (result.success && result.data) {
                const alet = result.data;
                document.getElementById('duzenle_id').value = alet.id;
                document.getElementById('duzenle_seri_no').value = alet.seri_no;
                document.getElementById('duzenle_adi').value = alet.adi;
                document.getElementById('duzenle_marka').value = alet.marka;
                document.getElementById('duzenle_kategori').value = alet.kategori;
                document.getElementById('duzenle_aciklama').value = alet.aciklama;
                // Raf select'i doldur ve seçili yap
                if (typeof window.raflarListesi !== 'undefined') {
                    const rafSelect = document.getElementById('duzenle_raf_id');
                    rafSelect.innerHTML = '<option value="">Seçiniz</option>';
                    window.raflarListesi.forEach(function(raf) {
                        const opt = document.createElement('option');
                        opt.value = raf.id;
                        opt.textContent = raf.adi;
                        if (alet.raf_id == raf.id) opt.selected = true;
                        rafSelect.appendChild(opt);
                    });
                }
                // Sadece Bootstrap 5 modal açma
                var modalEl = document.getElementById('duzenleModal');
                if (modalEl) {
                    var modal = new bootstrap.Modal(modalEl);
                    modal.show();
                    console.log('Düzenle modalı açıldı, id:', alet.id);
                } else {
                    console.error('duzenleModal bulunamadı!');
                }
            } else {
                alert(result.message || 'Alet bulunamadı!');
            }
        },
        error: function(xhr) {
            let msg = 'Alet bilgileri alınırken bir hata oluştu.';
            if (xhr && xhr.responseText) {
                msg += '\n\nSunucu cevabı:\n' + xhr.responseText;
            }
            alert(msg);
        }
    });
}

function aletGuncelle() {
    const formData = new FormData(document.getElementById('duzenleAletForm'));
    
    $.ajax({
        url: 'alet_guncelle.php',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        dataType: 'json',
        success: function(response) {
            const result = response;
            if (result.success) {
                alert('Alet başarıyla güncellendi.');
                $('#aletDuzenleModal').modal('hide');
                window.location.reload();
            } else {
                alert('Hata: ' + result.message);
            }
        },
        error: function() {
            alert('İşlem sırasında bir hata oluştu.');
        }
    });
}

function aletSil(id) {
    if (confirm('Bu aleti silmek istediğinizden emin misiniz?')) {
        $.ajax({
            url: 'alet_sil.php',
            method: 'POST',
            data: { id: id },
            dataType: 'json',
            success: function(response) {
                const result = response;
                if (result.success) {
                    alert('Alet başarıyla silindi.');
                    window.location.reload();
                } else {
                    alert('Hata: ' + result.message);
                }
            },
            error: function() {
                alert('İşlem sırasında bir hata oluştu.');
            }
        });
    }
}

// Barkod oluşturma fonksiyonu
function barkodOlustur(seriNo) {
    $.ajax({
        url: 'barkod_olustur.php',
        method: 'POST',
        data: { seri_no: seriNo },
        dataType: 'json',
        success: function(response) {
            const result = response;
            if (result.success) {
                document.getElementById('barkod_onizleme').src = result.barkod_url;
            } else {
                alert('Barkod oluşturulurken hata oluştu: ' + result.message);
            }
        }
    });
}

// Seri numarası değiştiğinde barkod oluştur
document.getElementById('seri_no').addEventListener('change', function() {
    barkodOlustur(this.value);
});

// duzenleAlet fonksiyonu, aletDuzenle fonksiyonuna yönlendirilerek global tanımlanıyor
window.duzenleAlet = aletDuzenle;
window.aletGuncelle = aletGuncelle;
console.log('duzenleAlet ve aletGuncelle global olarak tanımlandı');
