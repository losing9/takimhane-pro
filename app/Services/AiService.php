<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use App\Models\Tool;
use App\Models\Calibration;
use App\Models\Maintenance;
use App\Models\Loan;

class AiService
{
    protected $apiKey;
    protected $model;

    public function __construct()
    {
        $this->apiKey = env('OPENROUTER_API_KEY');
        $this->model = 'mistralai/devstral-2512:free';
    }

    public function ask(string $message, $contextData = null): string
    {
        $systemPrompt = $this->buildSystemPrompt($contextData);

        try {
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $this->apiKey,
                'HTTP-Referer' => config('app.url'),
                'X-Title' => config('app.name'),
                'Content-Type' => 'application/json',
            ])->post('https://openrouter.ai/api/v1/chat/completions', [
                'model' => $this->model,
                'messages' => [
                    ['role' => 'system', 'content' => $systemPrompt],
                    ['role' => 'user', 'content' => $message]
                ],
                'temperature' => 0.7,
                'max_tokens' => 1000,
            ]);

            if ($response->successful()) {
                return $response->json('choices.0.message.content');
            }

            Log::error('AI API Error: ' . $response->body());
            return 'Üzgünüm, şu anda servis yanıt vermiyor. Lütfen API anahtarınızı ve internet bağlantınızı kontrol edin.';

        } catch (\Exception $e) {
            Log::error('AI Service Exception: ' . $e->getMessage());
            return 'Bir hata oluştu: ' . $e->getMessage();
        }
    }

    protected function buildSystemPrompt($contextData)
    {
        $basePrompt = "Sen 'Takımhane Pro' asistanısın. Kullanıcının atölye/takımhane yönetimi ile ilgili sorularını yanıtlıyorsun. Türkçe konuşuyorsun. Kısa, net ve yardımsever ol.";
        
        // Add Global Database Awareness (The "Memory")
        $globalContext = $this->getDatabaseSummary();
        $basePrompt .= "\n\n**GENEL VERİTABANI ÖZETİ (Hafıza):**\n" . $globalContext;

        if ($contextData && count($contextData) > 0) {
            $basePrompt .= "\n\n**KULLANICI SORUSUYLA İLGİLİ BULUNAN DETAYLI KAYITLAR:**\n" . json_encode($contextData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n\nBu detaylı verileri öncelikli olarak kullan.";
        } else {
            $basePrompt .= "\n\nSoruyla doğrudan eşleşen spesifik bir kayıt bulunamadı, ancak genel özetten faydalanabilirsin.";
        }

        return $basePrompt;
    }

    protected function getDatabaseSummary()
    {
        try {
            $toolCount = Tool::count();
            $categories = \App\Models\Category::pluck('name')->implode(', ');
            $shelves = \App\Models\Shelf::pluck('name')->implode(', ');
            $maintenanceCount = \App\Models\Maintenance::where('status', '!=', 'completed')->count();
            
            return "- Toplam Alet Sayısı: $toolCount\n- Kategoriler: $categories\n- Raflar: $shelves\n- Devam Eden Bakımlar: $maintenanceCount";
        } catch (\Exception $e) {
            return "Veritabanı özeti alınamadı.";
        }
    }

    public function detectIntent(string $message)
    {
        $message = mb_strtolower($message);

        // Enhanced keyword detection
        if (preg_match('/(nerede|bul|ara|göster|listele|kimde|kaç tane|var mı)/u', $message)) return 'search_tool';
        if (preg_match('/(kalibrasyon|tarihi)/u', $message)) return 'calibration';
        if (preg_match('/(hasar|arızalı|bozuk|tamir|servis)/u', $message)) return 'maintenance';
        if (preg_match('/(zimmet|personel)/u', $message)) return 'loan';

        return 'general';
    }

    public function fetchContext(string $intent, string $message)
    {
        switch ($intent) {
            case 'search_tool':
                // Extract potential search terms (basic implementation)
                // In a real app, logic would be more complex or use AI to extract keywords.
                // Here we take the message and try to find matching tools.
                $terms = array_filter(explode(' ', $message), function($word) {
                    return mb_strlen($word) > 3 && !in_array(mb_strtolower($word), ['nerede', 'hangi', 'tane', 'var', 'mı', 'mi', 'mu', 'mü', 'bul', 'göster']);
                });
                
                if (empty($terms)) {
                    return Tool::with('shelf')->latest()->take(20)->get();
                }

                return Tool::with(['shelf', 'category', 'currentLoan.personnel'])
                    ->where(function($q) use ($terms) {
                        foreach ($terms as $term) {
                            $q->orWhere('name', 'like', "%{$term}%")
                              ->orWhere('description', 'like', "%{$term}%")
                              ->orWhere('serial_number', 'like', "%{$term}%")
                              ->orWhere('brand', 'like', "%{$term}%");
                        }
                    })
                    ->take(20)
                    ->get();

            case 'calibration':
                return Calibration::with('tool')->whereDate('next_calibration_date', '<=', now()->addDays(30))->get();
            case 'maintenance':
                return Maintenance::with(['tool'])->latest()->take(10)->get();
            case 'loan':
                return Loan::with(['tool', 'personnel'])->whereNull('returned_at')->latest()->take(10)->get();
            default:
                return null;
        }
    }
}
