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

// Arama filtresi
$search = isset($_GET['search']) ? cleanInput($_GET['search']) : '';
$where = '';
if (!empty($search)) {
    $where = "WHERE ad LIKE :search OR soyad LIKE :search OR departman LIKE :search";
}

// Toplam kayıt sayısı
$countSql = "SELECT COUNT(*) as total FROM personel $where";
$countStmt = $db->prepare($countSql);
if (!empty($search)) {
    $countStmt->bindValue(':search', "%$search%", PDO::PARAM_STR);
}
$countStmt->execute();
$totalRecords = $countStmt->fetch(PDO::FETCH_ASSOC)['total'];
$totalPages = ceil($totalRecords / $limit);

// Personel listesini getir
$sql = "SELECT p.*, 
        (SELECT COUNT(*) FROM odunc_islemler o 
         WHERE o.personel_id = p.id AND o.durum = 'devam_ediyor') as aktif_odunc 
        FROM personel p 
        $where 
        ORDER BY p.ad, p.soyad 
        LIMIT :limit OFFSET :offset";

$stmt = $db->prepare($sql);
$stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
$stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
if (!empty($search)) {
    $stmt->bindValue(':search', "%$search%", PDO::PARAM_STR);
}
$stmt->execute();
$personeller = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personel Yönetimi - Takımhane Takip Sistemi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/style.css" rel="stylesheet">
</head>
<body>
    <?php include '../../templates/header.php'; ?>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-6">
                <h2>Personel Yönetimi</h2>
            </div>
            <div class="col-md-6 text-end">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#yeniPersonelModal">
                    Yeni Personel Ekle
                </button>
            </div>
        </div>

        <!-- Arama formu -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="GET" class="row g-3">
                    <div class="col-md-8">
                        <input type="text" name="search" class="form-control" 
                               placeholder="Ad, soyad veya departman ile ara..." 
                               value="<?php echo htmlspecialchars($search); ?>">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary">Ara</button>
                        <?php if (!empty($search)): ?>
                            <a href="index.php" class="btn btn-secondary">Temizle</a>
                        <?php endif; ?>
                    </div>
                </form>
            </div>
        </div>

        <!-- Personel listesi -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Ad Soyad</th>
                                <th>Departman</th>
                                <th>Email</th>
                                <th>Telefon</th>
                                <th>Zimmetli Alet</th>
                                <th>İşlemler</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($personeller as $personel): ?>
                                <tr>
                                    <td>
                                        <?php echo htmlspecialchars(($personel['ad'] ?? '') . ' ' . ($personel['soyad'] ?? '')); ?>
                                        <br>
                                        <img src="../../modules/aletler/barkod.php?code=<?php echo urlencode(($personel['ad'] ?? '') . ' ' . ($personel['soyad'] ?? '')); ?>" alt="Barkod" style="height:40px;vertical-align:middle;display:inline-block;">
                                    </td>
                                    <td><?php echo htmlspecialchars($personel['departman'] ?? ''); ?></td>
                                    <td><?php echo htmlspecialchars($personel['email'] ?? ''); ?></td>
                                    <td><?php echo htmlspecialchars($personel['telefon'] ?? ''); ?></td>
                                    <td>
                                        <span class="badge bg-<?php echo $personel['aktif_odunc'] > 0 ? 'warning' : 'success'; ?>">
                                            <?php echo $personel['aktif_odunc']; ?> adet
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-info" onclick="personelDetay(<?php echo $personel['id']; ?>)">
                                            Detay
                                        </button>
                                        <button class="btn btn-sm btn-warning" onclick="personelDuzenle(<?php echo $personel['id']; ?>)">
                                            Düzenle
                                        </button>
                                        <button class="btn btn-sm btn-success" onclick="aletZimmetle(<?php echo $personel['id']; ?>)">
                                            Alet Zimmetle
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="personelSil(<?php echo $personel['id']; ?>)">
                                            Sil
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
                                    <a class="page-link" href="?page=<?php echo $i; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?>">
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

    <!-- Yeni Personel Modal -->
    <div class="modal fade" id="yeniPersonelModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Yeni Personel Ekle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="yeniPersonelForm">
                        <div class="mb-3">
                            <label for="ad" class="form-label">Ad</label>
                            <input type="text" class="form-control" id="ad" name="ad" required>
                        </div>
                        <div class="mb-3">
                            <label for="soyad" class="form-label">Soyad</label>
                            <input type="text" class="form-control" id="soyad" name="soyad" required>
                        </div>
                        <div class="mb-3">
                            <label for="departman" class="form-label">Departman</label>
                            <input type="text" class="form-control" id="departman" name="departman">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="mb-3">
                            <label for="telefon" class="form-label">Telefon</label>
                            <input type="tel" class="form-control" id="telefon" name="telefon">
                        </div>
                        <!-- Sicil No alanı kaldırıldı, otomatik atanacak -->
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-primary" onclick="personelKaydet()">Kaydet</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Alet Zimmetleme Modal -->
    <div class="modal fade" id="zimmetModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Alet Zimmetle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="zimmetForm">
                        <input type="hidden" id="zimmet_personel_id" name="personel_id">
                        <div class="mb-3">
                            <label for="alet_id" class="form-label">Alet Seçin</label>
                            <select class="form-control" id="alet_id" name="alet_id" required>
                                <!-- Aletler AJAX ile doldurulacak -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="planlanan_iade_tarihi" class="form-label">Planlanan İade Tarihi</label>
                            <input type="date" class="form-control" id="planlanan_iade_tarihi" name="planlanan_iade_tarihi" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-primary" onclick="zimmetle()">Zimmetle</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Personel Detay Modal -->
    <div class="modal fade" id="personelDetayModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Personel Detay</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- AJAX ile doldurulacak -->
                </div>
            </div>
        </div>
    </div>

    <!-- Personel Düzenle Modal -->
    <div class="modal fade" id="personelDuzenleModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Personel Düzenle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="personelDuzenleForm">
                        <input type="hidden" id="duzenle_id" name="duzenle_id">
                        <div class="mb-3">
                            <label for="duzenle_ad" class="form-label">Ad</label>
                            <input type="text" class="form-control" id="duzenle_ad" name="duzenle_ad" required>
                        </div>
                        <div class="mb-3">
                            <label for="duzenle_soyad" class="form-label">Soyad</label>
                            <input type="text" class="form-control" id="duzenle_soyad" name="duzenle_soyad" required>
                        </div>
                        <div class="mb-3">
                            <label for="duzenle_departman" class="form-label">Departman</label>
                            <input type="text" class="form-control" id="duzenle_departman" name="duzenle_departman">
                        </div>
                        <div class="mb-3">
                            <label for="duzenle_email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="duzenle_email" name="duzenle_email">
                        </div>
                        <div class="mb-3">
                            <label for="duzenle_telefon" class="form-label">Telefon</label>
                            <input type="tel" class="form-control" id="duzenle_telefon" name="duzenle_telefon">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-primary" onclick="personelGuncelle()">Kaydet</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/assets/js/main.js"></script>
    <script src="personel.js"></script>
</body>
</html>
