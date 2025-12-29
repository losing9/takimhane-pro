<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

// Rafları çek
$rafStmt = $db->query("SELECT id, adi FROM raf_listesi ORDER BY adi ASC");
$raflar = $rafStmt->fetchAll(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $barkod = trim($_POST['barkod'] ?? '');
    $seri_no = trim($_POST['seri_no'] ?? '');
    $adi = trim($_POST['adi'] ?? '');
    $marka = trim($_POST['marka'] ?? '');
    $kategori = trim($_POST['kategori'] ?? '');
    $raf_id = trim($_POST['raf_id'] ?? '');
    $durum = trim($_POST['durum'] ?? 'aktif');

    // Zorunlu alanları kontrol et
    if (empty($seri_no) || empty($adi) || empty($marka)) {
        $_SESSION['hata'] = 'Lütfen zorunlu alanları doldurun.';
        header('Location: index.php');
        exit();
    }

    try {
        $sql = "INSERT INTO aletler (barkod, seri_no, adi, marka, kategori, raf_id, durum) 
                VALUES (:barkod, :seri_no, :adi, :marka, :kategori, :raf_id, :durum)";
        
        $stmt = $db->prepare($sql);
        $stmt->execute([
            'barkod' => $barkod ?: null,
            'seri_no' => $seri_no,
            'adi' => $adi,
            'marka' => $marka,
            'kategori' => $kategori ?: null,
            'raf_id' => $raf_id ?: null,
            'durum' => $durum
        ]);

        $_SESSION['basari'] = 'Alet başarıyla eklendi.';
    } catch (PDOException $e) {
        $_SESSION['hata'] = 'Alet eklenirken bir hata oluştu: ' . $e->getMessage();
    }

    header('Location: index.php');
    exit();
} else {
    header('Location: index.php');
    exit();
}
?>

<form method="post" action="alet_kaydet.php">
    <!-- Diğer alanlar -->
    <label>Raf:</label>
    <select name="raf_id">
        <option value="">Seçiniz</option>
        <?php foreach($raflar as $raf): ?>
            <option value="<?= $raf['id'] ?>"><?= htmlspecialchars($raf['adi']) ?></option>
        <?php endforeach; ?>
    </select>
    <!-- Diğer alanlar -->
</form>
