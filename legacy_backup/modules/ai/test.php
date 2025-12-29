<?php
// AI API Test Sayfası
require_once '../../includes/ai_helper.php';

echo "<h1>OpenRouter API Test</h1>";

// 1. CURL kontrolü
echo "<h3>1. CURL Durumu:</h3>";
if (function_exists('curl_version')) {
    $curl_info = curl_version();
    echo "✅ CURL aktif - Versiyon: " . $curl_info['version'] . "<br>";
    echo "SSL Versiyonu: " . $curl_info['ssl_version'] . "<br>";
} else {
    echo "❌ CURL YOK - php.ini'de extension=curl açın!<br>";
}

// 2. .env dosyası kontrolü
echo "<h3>2. .env Dosyası:</h3>";
$env_file = __DIR__ . '/../../.env';
if (file_exists($env_file)) {
    echo "✅ .env dosyası bulundu<br>";
    $env_content = file_get_contents($env_file);
    if (preg_match('/OPENROUTER_API_KEY=(.+)/', $env_content, $matches)) {
        $api_key = trim($matches[1]);
        echo "✅ API Key bulundu: " . substr($api_key, 0, 15) . "...<br>";
        echo "API Key uzunluğu: " . strlen($api_key) . " karakter<br>";
    } else {
        echo "❌ API Key .env'de bulunamadı<br>";
    }
} else {
    echo "❌ .env dosyası bulunamadı<br>";
}

// 3. AI Helper testi
echo "<h3>3. AI Helper Test:</h3>";
try {
    $ai = new AIHelper();
    echo "✅ AIHelper sınıfı başlatıldı<br>";
    
    // Basit test sorusu
    echo "<h4>Test Sorusu: 'Merhaba, nasılsın?'</h4>";
    $response = $ai->ask("Merhaba, nasılsın? Kısa yanıt ver.");
    
    echo "<div style='background: #f0f0f0; padding: 15px; border-radius: 5px; margin: 10px 0;'>";
    echo "<strong>AI Yanıtı:</strong><br>";
    echo nl2br(htmlspecialchars($response));
    echo "</div>";
    
} catch (Exception $e) {
    echo "❌ Hata: " . $e->getMessage() . "<br>";
}

// 4. PHP log kontrolü
echo "<h3>4. Hata Logları:</h3>";
echo "<p>XAMPP/apache/logs/error.log dosyasını kontrol edin</p>";
?>
