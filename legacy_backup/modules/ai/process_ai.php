<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';
require_once '../../includes/ai_helper.php';

// Hata raporlamayı aç (geliştirme için)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Giriş kontrolü
if (!isset($_SESSION['kullanici_id'])) {
    echo json_encode(['success' => false, 'error' => 'Oturum bulunamadı']);
    exit();
}

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'error' => 'Geçersiz istek metodu']);
    exit();
}

$user_message = trim($_POST['message'] ?? '');

if (empty($user_message)) {
    echo json_encode(['success' => false, 'error' => 'Mesaj boş olamaz']);
    exit();
}

try {
    $ai = new AIHelper();
    
    // Veritabanı bağlantısı için değişkenleri kullan
    $db = new mysqli($db_host ?? 'localhost', $db_user ?? 'root', $db_pass ?? '', $db_name ?? 'tts');
    
    if ($db->connect_error) {
        throw new Exception("Veritabanı bağlantı hatası: " . $db->connect_error);
    }
    
    $db->set_charset("utf8mb4");
    
    // Mesajı analiz et ve ilgili verileri çek
    $context_data = null;
    $result_data = null;
    
    // Anahtar kelimelere göre veritabanı sorgusu
    $message_lower = mb_strtolower($user_message, 'UTF-8');
    
    // Alet arama
    if (preg_match('/(nerede|bul|ara|göster|listele|var mı|alet|aletler)/u', $message_lower)) {
        $stmt = $db->prepare("SELECT a.id, a.seri_no, a.adi, a.marka, a.model, a.durum, a.kategori,
                              r.kod as raf_kodu, r.aciklama as raf_aciklama,
                              p.ad as personel_ad, p.soyad as personel_soyad
                              FROM aletler a 
                              LEFT JOIN raflar r ON a.raf_id = r.id 
                              LEFT JOIN personel p ON a.zimmetli_personel_id = p.id
                              WHERE a.silindi = 0
                              LIMIT 50");
        $stmt->execute();
        $result = $stmt->get_result();
        $context_data = $result->fetch_all(MYSQLI_ASSOC);
        $result_data = $context_data;
    }
    
    // Kalibrasyon sorgusu
    if (preg_match('/(kalibrasyon|kalibrasyon tarihi|kalibrasyon yaklaş)/u', $message_lower)) {
        $stmt = $db->prepare("SELECT a.adi, a.seri_no, a.kategori, a.marka, 
                              k.kalibrasyon_tarihi, k.sonraki_kalibrasyon_tarihi, 
                              k.firma, k.sertifika_no,
                              DATEDIFF(k.sonraki_kalibrasyon_tarihi, NOW()) as kalan_gun
                              FROM kalibrasyon k
                              JOIN aletler a ON k.alet_id = a.id
                              WHERE k.aktif = 1
                              ORDER BY k.sonraki_kalibrasyon_tarihi ASC
                              LIMIT 30");
        $stmt->execute();
        $result = $stmt->get_result();
        $context_data = $result->fetch_all(MYSQLI_ASSOC);
        $result_data = $context_data;
    }
    
    // Hasar sorgusu
    if (preg_match('/(hasar|hasarlı|arızalı|bozuk|kategori.*hasar|hasar.*kategori)/u', $message_lower)) {
        $stmt = $db->prepare("SELECT a.adi, a.seri_no, a.kategori, a.marka, a.model,
                              h.hasar_turu, h.aciklama, h.hasar_tarihi, h.maliyet, h.durum,
                              p.ad as personel_ad, p.soyad as personel_soyad
                              FROM hasar_kayitlari h
                              JOIN aletler a ON h.alet_id = a.id
                              LEFT JOIN personel p ON h.personel_id = p.id
                              ORDER BY h.hasar_tarihi DESC
                              LIMIT 50");
        $stmt->execute();
        $result = $stmt->get_result();
        $context_data = $result->fetch_all(MYSQLI_ASSOC);
        $result_data = $context_data;
    }
    
    // Servis sorgusu
    if (preg_match('/(servis|servise|tamir)/u', $message_lower)) {
        $stmt = $db->prepare("SELECT a.adi, a.seri_no, a.kategori, s.durum, s.gonderim_tarihi, 
                              s.tahmini_donus_tarihi, s.gercek_donus_tarihi, s.firma, s.maliyet,
                              ht.hasar_turu, ht.aciklama as hasar_aciklama
                              FROM servis_islemler s
                              JOIN hasar_tutanaklari ht ON s.tutanak_id = ht.id
                              JOIN aletler a ON ht.alet_id = a.id
                              ORDER BY s.gonderim_tarihi DESC
                              LIMIT 30");
        $stmt->execute();
        $result = $stmt->get_result();
        $context_data = $result->fetch_all(MYSQLI_ASSOC);
        $result_data = $context_data;
    }
    
    // Personel sorgusu (ödünç/zimmet)
    if (preg_match('/(personel|zimmet|kimin|kimde|ödünç)/u', $message_lower)) {
        $stmt = $db->prepare("SELECT p.ad, p.soyad, p.departman, p.sicil_no,
                              a.adi as alet_adi, a.seri_no, a.kategori, a.marka,
                              o.verilis_tarihi, o.notlar,
                              DATEDIFF(NOW(), o.verilis_tarihi) as gun_sayisi
                              FROM odunc_kayitlari o
                              JOIN personel p ON o.personel_id = p.id
                              JOIN aletler a ON o.alet_id = a.id
                              WHERE o.iade_tarihi IS NULL
                              ORDER BY o.verilis_tarihi DESC
                              LIMIT 30");
        $stmt->execute();
        $result = $stmt->get_result();
        $context_data = $result->fetch_all(MYSQLI_ASSOC);
        $result_data = $context_data;
    }
    
    // AI'ya sor
    $ai_response = $ai->ask($user_message, $context_data);
    
    $db->close();
    
    echo json_encode([
        'success' => true,
        'reply' => $ai_response,
        'data' => $result_data
    ], JSON_UNESCAPED_UNICODE);
    
} catch (Exception $e) {
    error_log("AI Process Hatası: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
        'file' => $e->getFile(),
        'line' => $e->getLine()
    ], JSON_UNESCAPED_UNICODE);
}
