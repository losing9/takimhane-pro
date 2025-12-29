function showRafEkleModal() {
    const html = `<div class='modal show' style='display:block;background:rgba(0,0,0,0.3);position:fixed;top:0;left:0;width:100vw;height:100vh;z-index:9999;'>
        <div class='modal-dialog' style='margin:10vh auto;max-width:400px;'>
            <div class='modal-content'>
                <div class='modal-header'><h5 class='modal-title'>Yeni Raf Ekle</h5>
                    <button type='button' class='close' onclick='closeRafModal()'>&times;</button>
                </div>
                <div class='modal-body'>
                    <input type='text' id='rafAdi' class='form-control mb-2' placeholder='Raf Adı'>
                    <input type='text' id='rafKonum' class='form-control mb-2' placeholder='Konum'>
                </div>
                <div class='modal-footer'>
                    <button class='btn btn-primary' onclick='rafKaydet()'>Kaydet</button>
                    <button class='btn btn-secondary' onclick='closeRafModal()'>İptal</button>
                </div>
            </div>
        </div>
    </div>`;
    document.getElementById('rafModal').innerHTML = html;
    document.getElementById('rafModal').style.display = 'block';
}

function showRafDuzenleModal(id, adi, konum) {
    const html = `<div class='modal show' style='display:block;background:rgba(0,0,0,0.3);position:fixed;top:0;left:0;width:100vw;height:100vh;z-index:9999;'>
        <div class='modal-dialog' style='margin:10vh auto;max-width:400px;'>
            <div class='modal-content'>
                <div class='modal-header'><h5 class='modal-title'>Raf Düzenle</h5>
                    <button type='button' class='close' onclick='closeRafModal()'>&times;</button>
                </div>
                <div class='modal-body'>
                    <input type='hidden' id='rafId' value='${id}'>
                    <input type='text' id='rafAdi' class='form-control mb-2' value='${adi}'>
                    <input type='text' id='rafKonum' class='form-control mb-2' value='${konum}'>
                </div>
                <div class='modal-footer'>
                    <button class='btn btn-primary' onclick='rafKaydet()'>Kaydet</button>
                    <button class='btn btn-secondary' onclick='closeRafModal()'>İptal</button>
                </div>
            </div>
        </div>
    </div>`;
    document.getElementById('rafModal').innerHTML = html;
    document.getElementById('rafModal').style.display = 'block';
}

function closeRafModal() {
    document.getElementById('rafModal').style.display = 'none';
}

function rafKaydet() {
    const id = document.getElementById('rafId') ? document.getElementById('rafId').value : '';
    const adi = document.getElementById('rafAdi').value;
    const konum = document.getElementById('rafKonum').value;
    fetch('raf_kaydet.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `id=${id}&adi=${encodeURIComponent(adi)}&konum=${encodeURIComponent(konum)}`
    })
    .then(r => r.json())
    .then(j => { alert(j.message); if(j.success) location.reload(); })
    .catch(() => alert('Hata oluştu.'));
}

function rafSil(id) {
    if (!confirm('Raf silinsin mi?')) return;
    fetch('raf_sil.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `id=${id}`
    })
    .then(r => r.json())
    .then(j => { alert(j.message); if(j.success) location.reload(); })
    .catch(() => alert('Hata oluştu.'));
}
