# Takımhane Takip Sistemi - AI Entegrasyonu

## Kurulum Adımları

### 1. OpenRouter API Key Alın
1. https://openrouter.ai/ adresine gidin
2. Kayıt olun (GitHub ile giriş yapabilirsiniz)
3. Dashboard'dan API key oluşturun
4. API key'i kopyalayın (sk-or-v1-xxxxxxxx formatında olacak)

### 2. API Key'i Sisteme Ekleyin

**Yöntem 1: .env Dosyası (Önerilen)**
```bash
# Proje kök dizininde .env dosyası oluşturun
OPENROUTER_API_KEY=sk-or-v1-xxxxxxxxxxxxxxxx
```

**Yöntem 2: Doğrudan Kod İçinde**
`includes/ai_helper.php` dosyasında 13. satırdaki:
```php
$this->api_key = getenv('OPENROUTER_API_KEY') ?: 'your-api-key-here';
```
Kısmını şu şekilde değiştirin:
```php
$this->api_key = 'sk-or-v1-xxxxxxxxxxxxxxxx'; // Kendi key'inizi buraya yazın
```

### 3. Sistemi Test Edin
1. Tarayıcınızda: http://localhost/tts/modules/ai/
2. Örnek sorular:
   - "Müsait tornavidaları göster"
   - "Bugün hangi aletler servise gönderildi?"
   - "Kalibrasyonu yaklaşan aletleri listele"

## Özellikler

### 1. Akıllı Sohbet Asistanı
- Doğal dil ile soru sorabilirsiniz
- AI veritabanından ilgili verileri bulup size sunar
- Türkçe yanıt verir

### 2. Otomatik Veri Getirme
Şu anahtar kelimeler algılanır:
- **Alet araması:** "nerede", "bul", "ara", "göster", "listele"
- **Kalibrasyon:** "kalibrasyon", "kalibrasyon tarihi"
- **Hasar:** "hasar", "hasarlı", "arızalı", "bozuk"
- **Servis:** "servis", "servise", "tamir"
- **Personel/Zimmet:** "personel", "zimmet", "kimin", "kimde"

### 3. Hızlı Sorular
Tek tıkla hazır sorular sorabilirsiniz:
- Bugünkü servis kayıtları
- Kalibrasyon takibi
- Hasar analizi
- Müsait aletler

## AI Model Seçimi

`includes/ai_helper.php` dosyasında 8. satırdaki model değiştirebilirsiniz:

```php
private $model = "openai/gpt-oss-20b:freet"; // Varsayılan
```

**Alternatif modeller:**
```php
// Hızlı ve ekonomik
private $model = "google/gemini-flash-1.5";

// Güçlü ve detaylı
private $model = "anthropic/claude-3.5-sonnet";
private $model = "openai/gpt-4-turbo";

// Ücretsiz (sınırlı)
private $model = "meta-llama/llama-3-8b-instruct:free";
```

Tüm modeller: https://openrouter.ai/models

## Maliyet Tahmini

OpenRouter kredili çalışır:
- Claude 3.5 Sonnet: ~$3 / 1M token (input), ~$15 / 1M token (output)
- Gemini Flash: ~$0.075 / 1M token (input), ~$0.30 / 1M token (output)
- Ortalama bir sohbet: 500-1000 token (~$0.01-0.05)

**İlk başta $5 kredi yeterli olur**, ayda 100-200 sohbet için.

## Gelişmiş Özellikler (Opsiyonel)

### 1. Sesli Komut
```javascript
// Speech Recognition API ile sesli soru
const recognition = new webkitSpeechRecognition();
recognition.lang = 'tr-TR';
recognition.onresult = (e) => {
    userInput.val(e.results[0][0].transcript);
    sendMessage();
};
```

### 2. Otomatik Öneriler
AI'nın önerdiği işlemleri tek tıkla uygulama (örn: servise gönder)

### 3. Rapor Özeti
PDF raporlarını AI ile özetletme

## Sorun Giderme

**"API Hatası: Unauthorized"**
- API key'inizi kontrol edin
- OpenRouter hesabınızda kredi olduğundan emin olun

**"Bağlantı hatası"**
- İnternet bağlantınızı kontrol edin
- XAMPP'de `php.ini` → `extension=curl` aktif mi kontrol edin

**"Yanıt çok yavaş"**
- Daha hızlı bir model seçin (Gemini Flash)
- `max_tokens` değerini azaltın (ai_helper.php, satır 46)

## Güvenlik Notları

⚠️ **ÖNEMLİ:**
- API key'i asla GitHub'a yüklemeyin
- `.env` dosyasını `.gitignore`'a ekleyin
- Production ortamında `.env` kullanın
- API key'i client-side'a göndermеyin

## Lisans & Kullanım
OpenRouter API kullanım şartları: https://openrouter.ai/terms
