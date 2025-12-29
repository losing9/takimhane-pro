$(document).ready(function() {
    // Hızlı arama fonksiyonu
    $('#quickSearch').on('keyup', function() {
        let searchTerm = $(this).val();
        if (searchTerm.length >= 3) {
            $.ajax({
                url: 'modules/search/quick_search.php',
                method: 'POST',
                data: { term: searchTerm },
                success: function(response) {
                    // Arama sonuçlarını göster
                    $('#searchResults').html(response);
                }
            });
        }
    });

    // Dashboard verilerini güncelleme
    function updateDashboard() {
        $.ajax({
            url: '/modules/dashboard/get_stats.php',
            method: 'GET',
            success: function(response) {
                let stats;
                try {
                    if (typeof response === 'string') {
                        stats = JSON.parse(response);
                    } else {
                        stats = response;
                    }
                } catch (e) {
                    console.error('Dashboard JSON parse hatası:', response);
                    return;
                }
                $('#totalTools').text(stats.totalTools);
                $('#borrowedTools').text(stats.borrowedTools);
                $('#calibrationDue').text(stats.calibrationDue);
                $('#inService').text(stats.inService);
            }
        });
    }

    // Sayfa yüklendiğinde dashboard verilerini güncelle
    updateDashboard();
    
    // Her 5 dakikada bir dashboard verilerini güncelle
    setInterval(updateDashboard, 300000);
});
