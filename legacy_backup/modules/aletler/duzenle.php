<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'] ?? 0;
    $barkod = trim($_POST['barkod'] ?? '');
    $seri_no = trim($_POST['seri_no'] ?? '');
    $adi = trim($_POST['adi'] ?? '');
    $marka = trim($_POST['marka'] ?? '');
    $kategori = trim($_POST['kategori'] ?? '');
    $raf_no = trim($_POST['raf_no'] ?? '');
    $durum = trim($_POST['durum'] ?? 'aktif');
    $aciklama = trim($_POST['aciklama'] ?? '');

    // Zorunlu alanları kontrol et
    if (empty($id) || empty($seri_no) || empty($adi) || empty($marka)) {
        $_SESSION['hata'] = 'Lütfen zorunlu alanları doldurun.';
        header('Location: index.php');
        exit();
    }

    try {
        // Önce raf_id'yi bul veya oluştur
        $raf_id = null;
        if (!empty($raf_no)) {
            // Rafı ara
            $stmt = $db->prepare("SELECT id FROM raflar WHERE kod = ?");
            $stmt->execute([$raf_no]);
            $raf = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($raf) {
                $raf_id = $raf['id'];
            } else {
                // Yeni raf oluştur
                $stmt = $db->prepare("INSERT INTO raflar (kod) VALUES (?)");
                $stmt->execute([$raf_no]);
                $raf_id = $db->lastInsertId();
            }
        }

        // Aleti güncelle
        $sql = "UPDATE aletler SET 
                barkod = :barkod,
                seri_no = :seri_no,
                adi = :adi,
                marka = :marka,
                kategori = :kategori,
                raf_id = :raf_id,
                durum = :durum,
                aciklama = :aciklama
                WHERE id = :id";
        
        $stmt = $db->prepare($sql);
        $stmt->execute([
            'id' => $id,
            'barkod' => $barkod ?: null,
            'seri_no' => $seri_no,
            'adi' => $adi,
            'marka' => $marka,
            'kategori' => $kategori ?: null,
            'raf_id' => $raf_id,
            'durum' => $durum,
            'aciklama' => $aciklama ?: null
        ]);

        $_SESSION['basari'] = 'Alet başarıyla güncellendi.';
    } catch (PDOException $e) {
        $_SESSION['hata'] = 'Alet güncellenirken bir hata oluştu: ' . $e->getMessage();
    }

    header('Location: index.php');
    exit();
} 
// GET isteği ile alet bilgilerini getir
else {
    header('Content-Type: application/json');
    
    $id = $_GET['id'] ?? 0;
    if ($id) {
        try {
            $stmt = $db->prepare("
                SELECT a.*, r.kod as raf_no 
                FROM aletler a 
                LEFT JOIN raflar r ON a.raf_id = r.id 
                WHERE a.id = ?
            ");
            $stmt->execute([$id]);
            $alet = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($alet) {
                echo json_encode(['success' => true, 'data' => $alet]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Alet bulunamadı.']);
            }
        } catch (PDOException $e) {
            echo json_encode(['success' => false, 'message' => 'Veritabanı hatası: ' . $e->getMessage()]);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Geçersiz ID.']);
    }
    exit; // JSON döndürüldükten sonra dosya sonlandırılır
}

// Rafları çek
$rafStmt = $db->query("SELECT id, adi FROM raf_listesi ORDER BY adi ASC");
$raflar = $rafStmt->fetchAll(PDO::FETCH_ASSOC);
?>
