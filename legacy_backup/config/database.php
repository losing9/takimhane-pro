<?php
$db_host = 'localhost';
$db_name = 'tts';
$db_user = 'root';  // Sunucu için root kullanıcısı
$db_pass = '';  // Root şifresi

try {
    // Debug: Bağlantı bilgilerini logla
    error_log("Veritabanı bağlantıs deneniyor...");
    error_log("Host: $db_host, DB: $db_name, User: $db_user");
    
    $db = new PDO("mysql:host=$db_host;dbname=$db_name;charset=utf8mb4", $db_user, $db_pass);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Debug: Bağlantı başarılı
    error_log("Veritabanı bağlantısı başarılı");
    
    // Test sorgusu
    $test = $db->query("SELECT COUNT(*) as count FROM personel");
    $result = $test->fetch(PDO::FETCH_ASSOC);
    error_log("Personel tablosunda " . $result['count'] . " kayıt var");
    
} catch(PDOException $e) {
    error_log("Veritabanı bağlantı hatası: " . $e->getMessage());
    die("Veritabanı bağlantı hatası: " . $e->getMessage());
}
?>
