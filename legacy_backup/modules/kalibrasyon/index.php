<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);

// Sayfalama için değişkenler
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = 10;
$offset = ($page - 1) * $limit;

// Filtreleme
$filter = isset($_GET['filter']) ? cleanInput($_GET['filter']) : 'tumu';
$search = isset($_GET['search']) ? cleanInput($_GET['search']) : '';

// Filtre koşullarını oluştur
$where = [];
$params = [];

if (!empty($search)) {
    $where[] = "(a.adi LIKE :search OR a.seri_no LIKE :search OR k.sertifika_no LIKE :search)";
    $params[':search'] = "%$search%";
}

switch ($filter) {
    case 'yakinda':
        $where[] = "k.sonraki_kalibrasyon_tarihi <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)";
        break;
    case 'gecmis':
        $where[] = "k.sonraki_kalibrasyon_tarihi < CURDATE()";
        break;
    case 'gelecek':
        $where[] = "k.sonraki_kalibrasyon_tarihi > DATE_ADD(CURDATE(), INTERVAL 30 DAY)";
        break;
}

$whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Toplam kayıt sayısı
$countSql = "SELECT COUNT(*) as total 
             FROM kalibrasyon k 
             JOIN aletler a ON k.alet_id = a.id 
             $whereClause";
$countStmt = $db->prepare($countSql);
foreach ($params as $key => $value) {
    $countStmt->bindValue($key, $value);
}
$countStmt->execute();
$totalRecords = $countStmt->fetch(PDO::FETCH_ASSOC)['total'];
$totalPages = ceil($totalRecords / $limit);

// Kalibrasyon kayıtlarını getir
$sql = "SELECT k.*, a.adi as alet_adi, a.seri_no, 
        DATEDIFF(k.sonraki_kalibrasyon_tarihi, CURDATE()) as kalan_gun
        FROM kalibrasyon k 
        JOIN aletler a ON k.alet_id = a.id 
        $whereClause
        ORDER BY k.sonraki_kalibrasyon_tarihi ASC 
        LIMIT :limit OFFSET :offset";

$stmt = $db->prepare($sql);
$stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
$stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
foreach ($params as $key => $value) {
    $stmt->bindValue($key, $value);
}
$stmt->execute();
$kalibrasyonlar = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kalibrasyon Takibi - Takımhane Takip Sistemi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/style.css" rel="stylesheet">
    <!-- Select2 entegrasyonu için gerekli css -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
    <?php include '../../templates/header.php'; ?>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-6">
                <h2>Kalibrasyon Takibi</h2>
            </div>
            <div class="col-md-6 text-end">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#yeniKalibrasyonModal">
                    Yeni Kalibrasyon Kaydı
                </button>
            </div>
        </div>

        <!-- Filtreleme ve arama -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="GET" class="row g-3">
                    <div class="col-md-4">
                        <select name="filter" class="form-select">
                            <option value="tumu" <?php echo $filter == 'tumu' ? 'selected' : ''; ?>>Tümü</option>
                            <option value="yakinda" <?php echo $filter == 'yakinda' ? 'selected' : ''; ?>>Yaklaşanlar (30 gün)</option>
                            <option value="gecmis" <?php echo $filter == 'gecmis' ? 'selected' : ''; ?>>Geçmiş</option>
                            <option value="gelecek" <?php echo $filter == 'gelecek' ? 'selected' : ''; ?>>Gelecek</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <input type="text" name="search" class="form-control" 
                               placeholder="Alet adı, seri no veya sertifika no ile ara..." 
                               value="<?php echo htmlspecialchars($search); ?>">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Filtrele</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Kalibrasyon listesi -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Alet</th>
                                <th>Seri No</th>
                                <th>Son Kalibrasyon</th>
                                <th>Sonraki Kalibrasyon</th>
                                <th>Kalan Gün</th>
                                <th>Sertifika No</th>
                                <th>Firma</th>
                                <th>İşlemler</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($kalibrasyonlar as $kalibrasyon): ?>
                                <tr class="<?php echo getKalibrasyonRowClass($kalibrasyon['kalan_gun']); ?>">
                                    <td><?php echo htmlspecialchars($kalibrasyon['alet_adi']); ?></td>
                                    <td><?php echo htmlspecialchars($kalibrasyon['seri_no']); ?></td>
                                    <td><?php echo formatDate($kalibrasyon['kalibrasyon_tarihi']); ?></td>
                                    <td><?php echo formatDate($kalibrasyon['sonraki_kalibrasyon_tarihi']); ?></td>
                                    <td>
                                        <span class="badge <?php echo getKalibrasyonBadgeClass($kalibrasyon['kalan_gun']); ?>">
                                            <?php echo $kalibrasyon['kalan_gun']; ?> gün
                                        </span>
                                    </td>
                                    <td><?php echo htmlspecialchars($kalibrasyon['sertifika_no']); ?></td>
                                    <td><?php echo htmlspecialchars($kalibrasyon['firma']); ?></td>
                                    <td>
                                        <button class="btn btn-sm btn-info" onclick="kalibrasyonDetay(<?php echo $kalibrasyon['id']; ?>)">
                                            Detay
                                        </button>
                                        <button class="btn btn-sm btn-warning" onclick="kalibrasyonDuzenle(<?php echo $kalibrasyon['id']; ?>)">
                                            Düzenle
                                        </button>
                                        <button class="btn btn-sm btn-success" onclick="yeniKalibrasyon(<?php echo $kalibrasyon['alet_id']; ?>)">
                                            Yeni Kalibrasyon
                                        </button>
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
                                <li class="page-item <?php echo $i === $page ? 'active' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $i; ?>&filter=<?php echo $filter; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?>">
                                        <?php echo $i; ?>
                                    </a>
                                </li>
                            <?php endfor; ?>
                        </ul>
                    </nav>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <!-- Yeni Kalibrasyon Modal -->
    <div class="modal fade" id="yeniKalibrasyonModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Yeni Kalibrasyon Kaydı</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="yeniKalibrasyonForm">
                        <div class="mb-3">
                            <label for="alet_id" class="form-label">Alet</label>
                            <select class="form-select" id="alet_id" name="alet_id" required>
                                <!-- Aletler AJAX ile doldurulacak -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="kalibrasyon_tarihi" class="form-label">Kalibrasyon Tarihi</label>
                            <input type="date" class="form-control" id="kalibrasyon_tarihi" name="kalibrasyon_tarihi" required>
                        </div>
                        <div class="mb-3">
                            <label for="gecerlilik_suresi" class="form-label">Geçerlilik Süresi (Ay)</label>
                            <input type="number" class="form-control" id="gecerlilik_suresi" name="gecerlilik_suresi" required>
                        </div>
                        <div class="mb-3">
                            <label for="sertifika_no" class="form-label">Sertifika No</label>
                            <input type="text" class="form-control" id="sertifika_no" name="sertifika_no" required>
                        </div>
                        <div class="mb-3">
                            <label for="firma" class="form-label">Firma</label>
                            <input type="text" class="form-control" id="firma" name="firma" required>
                        </div>
                        <div class="mb-3">
                            <label for="aciklama" class="form-label">Açıklama</label>
                            <textarea class="form-control" id="aciklama" name="aciklama" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-primary" onclick="kalibrasyonKaydet()">Kaydet</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Kalibrasyon Detay Modal -->
    <div class="modal fade" id="kalibrasyonDetayModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Kalibrasyon Detay</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- İçerik ajax ile yüklenecek -->
                </div>
            </div>
        </div>
    </div>
    <!-- Kalibrasyon Düzenle Modal -->
    <div class="modal fade" id="kalibrasyonDuzenleModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Kalibrasyon Düzenle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- İçerik ajax ile yüklenecek -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-primary" onclick="kalibrasyonGuncelle()">Kaydet</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="../../assets/js/main.js"></script>
    <script src="kalibrasyon.js"></script>
    <script src="kalibrasyonKaydet.js"></script>
</body>
</html>

<?php
function getKalibrasyonRowClass($kalanGun) {
    if ($kalanGun < 0) {
        return 'table-danger';
    } elseif ($kalanGun <= 30) {
        return 'table-warning';
    }
    return '';
}

function getKalibrasyonBadgeClass($kalanGun) {
    if ($kalanGun < 0) {
        return 'bg-danger';
    } elseif ($kalanGun <= 30) {
        return 'bg-warning';
    }
    return 'bg-success';
}
?>
