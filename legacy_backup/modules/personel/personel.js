// Personel işlemleri için JavaScript fonksiyonları

$(document).ready(function() {
    // Form submit edilirse sayfa yenilenmesin
    $('#yeniPersonelForm').on('submit', function(e) {
        e.preventDefault();
        personelKaydet();
    });
});

function personelKaydet() {
    const formData = new FormData(document.getElementById('yeniPersonelForm'));
    $.ajax({
        url: 'personel_kaydet.php',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            let result;
            try {
                if (typeof response === 'object') {
                    result = response;
                } else if (typeof response === 'string') {
                    if (response.trim().startsWith('{') || response.trim().startsWith('[')) {
                        result = JSON.parse(response);
                    } else if (response.trim().startsWith('[object Object]')) {
                        // [object Object] gibi bir çıktı varsa hata göster
                        alert('Sunucu beklenmeyen şekilde [object Object] döndürdü.');
                        return;
                    } else {
                        alert('Beklenmeyen sunucu yanıtı: ' + response);
                        return;
                    }
                } else {
                    alert('Beklenmeyen sunucu yanıtı: ' + response);
                    return;
                }
            } catch (e) {
                alert('Beklenmeyen sunucu yanıtı: ' + response);
                return;
            }
            if (result.success) {
                alert('Personel başarıyla kaydedildi.');
                $('#yeniPersonelModal').modal('hide');
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

function personelDetay(id) {
    $.ajax({
        url: 'personel_detay.php',
        method: 'GET',
        data: { id: id },
        success: function(response) {
            // Detay modalını göster
            $('#personelDetayModal .modal-body').html(response);
            $('#personelDetayModal').modal('show');
        }
    });
}

function personelDuzenle(id) {
    $.ajax({
        url: 'personel_getir.php',
        method: 'GET',
        data: { id: id },
        success: function(response) {
            const personel = JSON.parse(response);
            // Form alanlarını doldur
            document.getElementById('duzenle_id').value = personel.id;
            document.getElementById('duzenle_ad').value = personel.ad;
            document.getElementById('duzenle_soyad').value = personel.soyad;
            document.getElementById('duzenle_departman').value = personel.departman;
            document.getElementById('duzenle_email').value = personel.email;
            document.getElementById('duzenle_telefon').value = personel.telefon;
            
            // Düzenleme modalını göster
            $('#personelDuzenleModal').modal('show');
        }
    });
}

function personelGuncelle() {
    const formData = new FormData(document.getElementById('personelDuzenleForm'));
    
    $.ajax({
        url: 'personel_guncelle.php',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            const result = JSON.parse(response);
            if (result.success) {
                alert('Personel bilgileri başarıyla güncellendi.');
                $('#personelDuzenleModal').modal('hide');
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

function personelSil(id) {
    if (confirm('Bu personeli silmek istediğinizden emin misiniz?')) {
        $.ajax({
            url: 'personel_sil.php',
            method: 'POST',
            data: { id: id },
            success: function(response) {
                const result = JSON.parse(response);
                if (result.success) {
                    alert('Personel başarıyla silindi.');
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

function aletZimmetle(personelId) {
    // Personel ID'sini form'a set et
    document.getElementById('zimmet_personel_id').value = personelId;
    
    // Mevcut aletleri getir
    $.ajax({
        url: 'musait_aletler.php',
        method: 'GET',
        success: function(response) {
            const aletler = JSON.parse(response);
            const select = document.getElementById('alet_id');
            select.innerHTML = '<option value="">Alet seçin...</option>';
            
            aletler.forEach(alet => {
                select.innerHTML += `<option value="${alet.id}">${alet.adi} (${alet.seri_no})</option>`;
            });
            
            // Zimmetleme modalını göster
            $('#zimmetModal').modal('show');
        }
    });
}

function zimmetle() {
    const formData = new FormData(document.getElementById('zimmetForm'));
    
    $.ajax({
        url: 'zimmetle.php',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            const result = JSON.parse(response);
            if (result.success) {
                alert('Alet başarıyla zimmetlendi.');
                $('#zimmetModal').modal('hide');
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

// Tarih alanı için minimum tarihi bugün olarak ayarla
document.addEventListener('DOMContentLoaded', function() {
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('planlanan_iade_tarihi').min = today;
});
