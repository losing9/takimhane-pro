// Sadece kalibrasyon kaydet fonksiyonu (global)
function kalibrasyonKaydet() {
    const formData = new FormData(document.getElementById('yeniKalibrasyonForm'));
    $.ajax({
        url: 'kalibrasyon_kaydet.php',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            let result = response;
            if (typeof response === 'string') {
                try {
                    result = JSON.parse(response);
                } catch (e) {
                    alert('Beklenmeyen sunucu yanıtı: ' + response);
                    return;
                }
            }
            if (result.success) {
                alert('Kalibrasyon kaydı başarıyla oluşturuldu.');
                $('#yeniKalibrasyonModal').modal('hide');
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
