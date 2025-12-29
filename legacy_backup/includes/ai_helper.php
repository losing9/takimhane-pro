<?php
/**
 * Mistral AI API Yardımcı Sınıfı
 * Yapay Zeka entegrasyonu için
 */

class AIHelper {
    private $api_key;
    private $api_url = "https://api.mistral.ai/v1/chat/completions";
    private $model = "open-mistral-7b"; // Daha hafif ücretsiz model
    
    public function __construct() {
        // .env dosyasından API key'i oku
        $env_file = __DIR__ . '/../.env';
        if (file_exists($env_file)) {
            $env_content = file_get_contents($env_file);
            if (preg_match('/MISTRAL_API_KEY=(.+)/', $env_content, $matches)) {
                $this->api_key = trim($matches[1]);
            }
        }
        
        // Eğer .env'den alınamadıysa, getenv dene
        if (empty($this->api_key)) {
            $this->api_key = getenv('MISTRAL_API_KEY') ?: 'your-api-key-here';
        }
    }
    
    /**
     * Kullanıcı sorusunu AI'ya gönder
     * 
     * @param string $user_question Kullanıcının sorduğu soru
     * @param array $context_data Opsiyonel: Veritabanı verisi
     * @return string AI yanıtı
     */
    public function ask($user_question, $context_data = null) {
        // Sistem promptu: TTS sisteminin asistanı olduğunu tanımla
        $system_prompt = "Sen bir takımhane yönetim sisteminin yapay zeka asistanısın. 

ÖNEMLİ KURALLAR:
1. ASLA SQL sorgusu yazma veya öneri yapma
2. SADECE sana verilen gerçek verileri analiz et ve yorumla
3. Veritabanı yapısı hakkında bilgi verme
4. Eğer veri verilmediyse, 'Bu soruyu yanıtlamak için ilgili verilere ihtiyacım var' de

Görevlerin:
- Verilen verileri analiz et ve özetle
- Trend ve pattern'leri belirt
- Sayısal istatistikler çıkar
- Profesyonel ve anlaşılır Türkçe ile yanıt ver
- Önerilerde bulun (sadece veriye dayalı)

Türkçe yanıt ver, kısa ve net ol.";

        $messages = [
            [
                'role' => 'system',
                'content' => $system_prompt
            ]
        ];
        
        // Context data varsa önce göster
        if ($context_data && !empty($context_data)) {
            $messages[] = [
                'role' => 'user',
                'content' => "İşte sistemdeki ilgili veriler:\n\n" . json_encode($context_data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT)
            ];
        }
        
        // Kullanıcı sorusunu ekle
        $messages[] = [
            'role' => 'user',
            'content' => $user_question
        ];
        
        return $this->callAPI($messages);
    }
    
    /**
     * Hasar raporunu özetle
     */
    public function summarizeReport($report_data) {
        $prompt = "Aşağıdaki hasar raporunu özetle ve önemli noktaları belirt:\n\n";
        $prompt .= json_encode($report_data, JSON_UNESCAPED_UNICODE);
        
        return $this->ask($prompt);
    }
    
    /**
     * Kalibrasyon önerisi üret
     */
    public function suggestCalibration($alet_data) {
        $prompt = "Bu alet için kalibrasyon önerisi yap:\n";
        $prompt .= "Alet: {$alet_data['adi']}\n";
        $prompt .= "Son kalibrasyon: {$alet_data['son_kalibrasyon']}\n";
        $prompt .= "Kullanım sıklığı: {$alet_data['kullanim_siklik']}\n";
        
        return $this->ask($prompt);
    }
    
    /**
     * Doğal dil sorgusunu SQL'e çevir (yardımcı)
     */
    public function queryToSQL($natural_query) {
        $prompt = "Bu doğal dil sorgusunu SQL'e çevir (sadece SELECT sorgusu):\n\n";
        $prompt .= $natural_query . "\n\n";
        $prompt .= "Sadece SQL kodunu döndür, açıklama yapma.";
        
        return $this->ask($prompt);
    }
    
    /**
     * Mistral AI API'ye istek gönder
     */
    private function callAPI($messages) {
        $payload = [
            'model' => $this->model,
            'messages' => $messages,
            'temperature' => 0.7,
            'max_tokens' => 1000
        ];
        
        $ch = curl_init($this->api_url);
        
        $headers = [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $this->api_key
        ];
        
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        
        $response = curl_exec($ch);
        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        
        if (curl_errno($ch)) {
            $error = curl_error($ch);
            curl_close($ch);
            error_log("Mistral API CURL Hatası: " . $error);
            return "API Bağlantı Hatası: " . $error;
        }
        
        curl_close($ch);
        
        if ($http_code !== 200) {
            error_log("Mistral API HTTP Hatası ($http_code): " . $response);
            return "API Hatası (HTTP $http_code): " . $response;
        }
        
        $result = json_decode($response, true);
        
        if (isset($result['choices'][0]['message']['content'])) {
            return $result['choices'][0]['message']['content'];
        }
        
        error_log("Mistral API Yanıt Hatası: " . json_encode($result));
        return "Yanıt alınamadı. Detay: " . json_encode($result);
    }
    
    /**
     * Akıllı arama: Kullanıcı girdisini analiz et, ilgili aletleri bul
     */
    public function smartSearch($search_query, $db) {
        // Önce veritabanından basit arama yap
        $stmt = $db->prepare("SELECT * FROM aletler WHERE 
            adi LIKE ? OR 
            marka LIKE ? OR 
            model LIKE ? OR 
            seri_no LIKE ? 
            LIMIT 10");
        
        $like_query = "%{$search_query}%";
        $stmt->bind_param("ssss", $like_query, $like_query, $like_query, $like_query);
        $stmt->execute();
        $result = $stmt->get_result();
        $aletler = $result->fetch_all(MYSQLI_ASSOC);
        
        if (empty($aletler)) {
            return [
                'found' => false,
                'message' => 'Sonuç bulunamadı.',
                'ai_suggestion' => $this->ask("Kullanıcı '$search_query' arıyor ama bulunamadı. Alternatif önerilerde bulun.")
            ];
        }
        
        // AI ile zenginleştirilmiş yanıt
        $ai_summary = $this->ask(
            "Bu arama sonuçlarını özetle: '$search_query'", 
            $aletler
        );
        
        return [
            'found' => true,
            'results' => $aletler,
            'ai_summary' => $ai_summary
        ];
    }
}
