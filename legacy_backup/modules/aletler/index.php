<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Hata ayıklama için PHP hata gösterimi ve tüm hata raporlaması açıldı.
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Oturum kontrolü
checkLogin();

// Sayfalama için değişkenler
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = 100;
$offset = ($page - 1) * $limit;

// Arama filtresi
$search = isset($_GET['search']) ? cleanInput($_GET['search']) : '';
$searchExact = trim($search);
$where = 'WHERE a.silindi = 0';
if (!empty($search)) {
    $where .= " AND (a.adi LIKE :search OR a.seri_no LIKE :search OR a.seri_no = :searchExact)";
}

// Raf filtrelemesi
$rafId = isset($_GET['raf_id']) ? (int)$_GET['raf_id'] : 0;
if ($rafId > 0) {
    $where .= " AND a.raf_id = :rafId";
}

// Toplam kayıt sayısı
$countSql = "SELECT COUNT(*) as total FROM aletler a LEFT JOIN raflar r ON a.raf_id = r.id $where";
$countStmt = $db->prepare($countSql);
if (!empty($search)) {
    $countStmt->bindValue(':search', "%$search%", PDO::PARAM_STR);
    $countStmt->bindValue(':searchExact', $searchExact, PDO::PARAM_STR);
}
if ($rafId > 0) {
    $countStmt->bindValue(':rafId', $rafId, PDO::PARAM_INT);
}
$countStmt->execute();
$totalRecords = $countStmt->fetch(PDO::FETCH_ASSOC)['total'];
$totalPages = ceil($totalRecords / $limit);

// Aletleri getir
$sql = "SELECT a.*, r.kod as raf_kodu, 
               DATE_FORMAT(a.eklenme_tarihi, '%d.%m.%Y %H:%i') as eklenme_tarihi_format,
               a.aciklama
        FROM aletler a 
        LEFT JOIN raflar r ON a.raf_id = r.id 
        $where 
        ORDER BY a.id DESC 
        LIMIT :limit OFFSET :offset";
$stmt = $db->prepare($sql);
$stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
$stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
if (!empty($search)) {
    $stmt->bindValue(':search', "%$search%", PDO::PARAM_STR);
    $stmt->bindValue(':searchExact', $searchExact, PDO::PARAM_STR);
}
if ($rafId > 0) {
    $stmt->bindValue(':rafId', $rafId, PDO::PARAM_INT);
}
$stmt->execute();
$aletler = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Rafları çek
$rafStmt = $db->query("SELECT id, adi FROM raf_listesi ORDER BY adi ASC");
$raflar = $rafStmt->fetchAll(PDO::FETCH_ASSOC);
$raflarMap = [];
foreach($raflar as $r) $raflarMap[$r['id']] = $r['adi'];
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alet Yönetimi - Takımhane Takip Sistemi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/style.css" rel="stylesheet">
    <style>
        .barkod-img {
            height: 30px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        .barkod-img:hover {
            transform: scale(1.1);
        }
        .barkod-img-modal {
            height: 80px;
            cursor: pointer;
            transition: transform 0.3s ease;
            margin: 10px 0;
        }
        .barkod-img-modal:hover {
            transform: scale(1.1);
        }
        .barkod-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.9);
        }
        .barkod-modal-content {
            margin: auto;
            display: block;
            max-width: 500px;
            max-height: 200px;
        }
        .barkod-modal.show {
            display: block;
        }
        .table tbody tr {
            cursor: pointer;
        }
        .table tbody tr:hover {
            background-color: rgba(0,0,0,.075) !important;
        }
        .detail-row {
            margin-bottom: 10px;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
        }
    </style>
</head>
<body>
    <?php include '../../includes/header.php'; ?>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-6">
                <h2>Alet Listesi</h2>
            </div>
            <div class="col-md-6 text-end">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#yeniAletModal">
                    Yeni Alet Ekle
                </button>
            </div>
        </div>

        <!-- Arama formu -->
        <div class="row mb-4">
            <div class="col-md-12">
                <form method="get" class="d-flex">
                    <input type="text" name="search" class="form-control me-2" placeholder="Alet ara..." value="<?php echo htmlspecialchars($search); ?>">
                    <button type="submit" class="btn btn-outline-primary">Ara</button>
                </form>
            </div>
        </div>

        <!-- Raf filtreleme formu -->
        <div class="row mb-4">
            <div class="col-md-12">
                <form method="get">
                    <div class="input-group">
                        <select name="raf_id" class="form-select">
                            <option value="">Tüm Raflar</option>
                            <?php foreach($raflar as $raf): ?>
                                <option value="<?= $raf['id'] ?>" <?= (isset($_GET['raf_id']) && $_GET['raf_id']==$raf['id']?'selected':'') ?>><?= htmlspecialchars($raf['adi']) ?></option>
                            <?php endforeach; ?>
                        </select>
                        <button type="submit" class="btn btn-primary">Filtrele</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Alet listesi -->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Barkod</th>
                        <th>Seri No</th>
                        <th>Adı</th>
                        <th>Marka</th>
                        <th>Kategori</th>
                        <th>Raf</th>
                        <th>Durum</th>
                        <th>İşlemler</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($aletler as $alet): ?>
                    <tr onclick="showAletDetay(<?php echo htmlspecialchars(json_encode($alet)); ?>)">
                        <td>
                            <?php if (!empty($alet['seri_no'])): ?>
                                <img src="barkod.php?code=<?php echo urlencode($alet['seri_no'] ?? ''); ?>"
                                     alt="<?php echo htmlspecialchars($alet['seri_no'] ?? ''); ?>"
                                     title="<?php echo htmlspecialchars($alet['seri_no'] ?? ''); ?>"
                                     class="barkod-img"
                                     onclick="showBarkod(this.src, this.alt)">
                            <?php endif; ?>
                        </td>
                        <td><?php echo htmlspecialchars($alet['seri_no'] ?? ''); ?></td>
                        <td><?php echo htmlspecialchars($alet['adi'] ?? ''); ?></td>
                        <td><?php echo htmlspecialchars($alet['marka'] ?? ''); ?></td>
                        <td><?php echo htmlspecialchars($alet['kategori'] ?? '-'); ?></td>
                        <td><?php 
                            $rafAdi = isset($alet['raf_id']) && isset($raflarMap[$alet['raf_id']]) ? $raflarMap[$alet['raf_id']] : '-';
                            echo htmlspecialchars($rafAdi);
                        ?></td>
                        <td>
                            <span class="badge <?php echo getDurumClass($alet['durum']); ?>">
                                <?php echo getDurumText($alet['durum']); ?>
                            </span>
                        </td>
                        <td>
                            <div class="btn-group" onclick="event.stopPropagation();">
                                <button type="button" class="btn btn-sm btn-primary" onclick="duzenleAlet(<?php echo $alet['id']; ?>)">
                                    <i class="bi bi-pencil"></i> Düzenle
                                </button>
                                <button type="button" class="btn btn-sm btn-danger" onclick="silAlet(<?php echo $alet['id']; ?>)">
                                    <i class="bi bi-trash"></i> Sil
                                </button>
                            </div>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <!-- Sayfalama -->
        <?php if ($totalPages > 1): ?>
        <nav aria-label="Sayfalama">
            <ul class="pagination justify-content-center">
                <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?php echo $i == $page ? 'active' : ''; ?>">
                    <a class="page-link" href="?page=<?php echo $i; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?>">
                        <?php echo $i; ?>
                    </a>
                </li>
                <?php endfor; ?>
            </ul>
        </nav>
        <?php endif; ?>
    </div>

    <!-- Yeni Alet Modal -->
    <div class="modal fade" id="yeniAletModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Yeni Alet Ekle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="yeniAletForm" method="post" action="ekle.php">
                        <div class="mb-3">
                            <label for="barkod" class="form-label">Barkod</label>
                            <input type="text" class="form-control" id="barkod" name="barkod">
                        </div>
                        <div class="mb-3">
                            <label for="seri_no" class="form-label">Seri No</label>
                            <input type="text" class="form-control" id="seri_no" name="seri_no" required>
                        </div>
                        <div class="mb-3">
                            <label for="adi" class="form-label">Adı</label>
                            <input type="text" class="form-control" id="adi" name="adi" required>
                        </div>
                        <div class="mb-3">
                            <label for="marka" class="form-label">Marka</label>
                            <input type="text" class="form-control" id="marka" name="marka" required>
                        </div>
                        <div class="mb-3">
                            <label for="kategori" class="form-label">Kategori</label>
                            <input type="text" class="form-control" id="kategori" name="kategori">
                        </div>
                        <div class="mb-3">
                            <label for="raf_no" class="form-label">Raf Kodu</label>
                            <input type="text" class="form-control" id="raf_no" name="raf_no">
                        </div>
                        <div class="mb-3">
                            <label for="durum" class="form-label">Durum</label>
                            <select class="form-select" id="durum" name="durum" required>
                                <option value="aktif">Aktif</option>
                                <option value="pasif">Pasif</option>
                                <option value="servis">Serviste</option>
                                <option value="kalibrasyon">Kalibrasyonda</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Kaydet</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Barkod Modal -->
    <div id="barkodModal" class="barkod-modal" onclick="this.classList.remove('show')">
        <img class="barkod-modal-content" id="barkodModalImg">
    </div>

    <!-- Alet Detay Modal -->
    <div class="modal fade" id="aletDetayModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Alet Detayları</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Barkod:</div>
                            <div class="col-8" id="detay-barkod"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Seri No:</div>
                            <div class="col-8" id="detay-seri-no"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Adı:</div>
                            <div class="col-8" id="detay-adi"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Marka:</div>
                            <div class="col-8" id="detay-marka"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Kategori:</div>
                            <div class="col-8" id="detay-kategori"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Raf Kodu:</div>
                            <div class="col-8" id="detay-raf-kodu"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Durum:</div>
                            <div class="col-8" id="detay-durum"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Eklenme Tarihi:</div>
                            <div class="col-8" id="detay-eklenme-tarihi"></div>
                        </div>
                        <div class="row detail-row">
                            <div class="col-4 detail-label">Açıklama:</div>
                            <div class="col-8" id="detay-aciklama"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                </div>
            </div>
        </div>
    </div>

    <!-- DÜZENLE MODAL -->
    <div class="modal fade" id="duzenleModal" tabindex="-1" aria-labelledby="duzenleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="duzenleModalLabel">Alet Düzenle</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
          </div>
          <div class="modal-body">
            <form id="duzenleAletForm">
              <input type="hidden" id="duzenle_id" name="id">
              <div class="mb-3">
                <label for="duzenle_barkod" class="form-label">Barkod</label>
                <input type="text" class="form-control" id="duzenle_barkod" name="barkod" readonly>
              </div>
              <div class="mb-3">
                <label for="duzenle_seri_no" class="form-label">Seri No</label>
                <input type="text" class="form-control" id="duzenle_seri_no" name="seri_no" required>
              </div>
              <div class="mb-3">
                <label for="duzenle_adi" class="form-label">Adı</label>
                <input type="text" class="form-control" id="duzenle_adi" name="adi" required>
              </div>
              <div class="mb-3">
                <label for="duzenle_marka" class="form-label">Marka</label>
                <input type="text" class="form-control" id="duzenle_marka" name="marka" required>
              </div>
              <div class="mb-3">
                <label for="duzenle_kategori" class="form-label">Kategori</label>
                <input type="text" class="form-control" id="duzenle_kategori" name="kategori">
              </div>
              <div class="mb-3">
                <label for="duzenle_raf_id" class="form-label">Raf</label>
                <select class="form-select" id="duzenle_raf_id" name="raf_id">
                  <option value="">Seçiniz</option>
                  <?php foreach($raflar as $raf): ?>
                    <option value="<?= $raf['id'] ?>"><?= htmlspecialchars($raf['adi']) ?></option>
                  <?php endforeach; ?>
                </select>
              </div>
              <div class="mb-3">
                <label for="duzenle_durum" class="form-label">Durum</label>
                <select class="form-select" id="duzenle_durum" name="durum">
                  <option value="aktif">Aktif</option>
                  <option value="pasif">Pasif</option>
                  <option value="servis">Serviste</option>
                  <option value="kalibrasyon">Kalibrasyonda</option>
                </select>
              </div>
              <div class="mb-3">
                <label for="duzenle_aciklama" class="form-label">Açıklama</label>
                <textarea class="form-control" id="duzenle_aciklama" name="aciklama"></textarea>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
            <button type="button" class="btn btn-primary" onclick="aletGuncelle()">Kaydet</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="aletler.js?v=2"></script>
    <script>
        // Raflar listesi global olarak JS'e aktarılıyor
        window.raflarListesi = <?php echo json_encode($raflar); ?>;
        // duzenleAlet ve aletGuncelle fonksiyonlarını window üzerinden global olarak tanımla
        window.duzenleAlet = window.duzenleAlet || function(){};
        window.aletGuncelle = window.aletGuncelle || function(){};
        if (typeof duzenleAlet === 'function') window.duzenleAlet = duzenleAlet;
        if (typeof aletGuncelle === 'function') window.aletGuncelle = aletGuncelle;
    </script>
    <script>
        // Barkod Modal
        function showBarkod(src, code) {
            const modal = document.getElementById('barkodModal');
            const modalImg = document.getElementById('barkodModalImg');
            modalImg.src = src;
            modalImg.alt = code;
            modal.classList.add('show');
        }

        // ESC tuşu ile modalı kapatma
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                document.getElementById('barkodModal').classList.remove('show');
            }
        });

        // Alet detay modalını göster
        function showAletDetay(alet) {
            // Barkod varsa barkod resmini göster
            if (alet.barkod) {
                document.getElementById('detay-barkod').innerHTML = 
                    `<img src="barkod.php?code=${encodeURIComponent(alet.barkod)}" 
                          alt="${alet.barkod}" 
                          class="barkod-img-modal" 
                          onclick="showBarkod(this.src, this.alt)">
                     <div class="text-muted small">${alet.barkod}</div>`;
            } else {
                document.getElementById('detay-barkod').textContent = '-';
            }
            
            // Diğer detayları doldur
            document.getElementById('detay-seri-no').textContent = alet.seri_no || '-';
            document.getElementById('detay-adi').textContent = alet.adi || '-';
            document.getElementById('detay-marka').textContent = alet.marka || '-';
            document.getElementById('detay-kategori').textContent = alet.kategori || '-';
            document.getElementById('detay-raf-kodu').textContent = alet.raf_kodu || '-';
            document.getElementById('detay-durum').innerHTML = 
                `<span class="badge ${getDurumClass(alet.durum)}">${getDurumText(alet.durum)}</span>`;
            document.getElementById('detay-eklenme-tarihi').textContent = alet.eklenme_tarihi_format || '-';
            document.getElementById('detay-aciklama').textContent = alet.aciklama || '-';
            
            // Modalı göster
            new bootstrap.Modal(document.getElementById('aletDetayModal')).show();
        }
        
        // Durum badge class'ını belirle
        function getDurumClass(durum) {
            switch(durum) {
                case 'aktif': return 'bg-success';
                case 'pasif': return 'bg-danger';
                case 'servis': return 'bg-warning';
                case 'kalibrasyon': return 'bg-info';
                default: return 'bg-secondary';
            }
        }
        
        // Durum metnini belirle
        function getDurumText(durum) {
            switch(durum) {
                case 'aktif': return 'Aktif';
                case 'pasif': return 'Pasif';
                case 'servis': return 'Serviste';
                case 'kalibrasyon': return 'Kalibrasyonda';
                default: return 'Bilinmiyor';
            }
        }
    </script>
</body>
</html>

<?php
function getDurumClass($durum) {
    switch ($durum) {
        case 'aktif':
            return 'bg-success';
        case 'pasif':
            return 'bg-danger';
        case 'servis':
            return 'bg-warning';
        case 'kalibrasyon':
            return 'bg-info';
        default:
            return 'bg-secondary';
    }
}

function getDurumText($durum) {
    switch ($durum) {
        case 'aktif':
            return 'Aktif';
        case 'pasif':
            return 'Pasif';
        case 'servis':
            return 'Serviste';
        case 'kalibrasyon':
            return 'Kalibrasyonda';
        default:
            return 'Bilinmiyor';
    }
}
?>
