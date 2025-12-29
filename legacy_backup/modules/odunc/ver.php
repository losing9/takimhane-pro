<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

// JSON yanıtı için header
header('Content-Type: application/json');

try {
    // POST verilerini al
    $personel_id = $_POST['personel_id'] ?? null;
    $alet_ids = $_POST['alet_ids'] ?? null;

    // Verileri kontrol et
    if (!$personel_id || !$alet_ids) {
        throw new Exception('Personel ve en az bir alet seçilmelidir.');
    }

    $aletIdArr = array_filter(array_map('intval', explode(',', $alet_ids)));

    if (empty($aletIdArr)) {
        throw new Exception('Geçerli alet seçimi yok.');
    }

    $successCount = 0;
    $failures = [];

    foreach ($aletIdArr as $alet_id) {
        // Aletin müsaitliği ve ödünçte olup olmadığı kontrolü
        $stmt = $db->prepare("
            SELECT durum 
            FROM aletler 
            WHERE id = ? AND silindi = 0
        ");
        $stmt->execute([$alet_id]);
        $alet = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$alet || $alet['durum'] !== 'aktif') {
            $failures[] = $alet_id;
            continue;
        }

        $stmt = $db->prepare("
            SELECT id 
            FROM odunc_kayitlari 
            WHERE alet_id = ? AND iade_tarihi IS NULL
        ");
        $stmt->execute([$alet_id]);
        if ($stmt->fetch()) {
            $failures[] = $alet_id;
            continue;
        }

        // Ödünç kaydı oluştur
        $stmt = $db->prepare("
            INSERT INTO odunc_kayitlari (alet_id, personel_id, verilis_tarihi)
            VALUES (?, ?, NOW())
        ");
        $stmt->execute([$alet_id, $personel_id]);
        $successCount++;
    }

    if ($successCount > 0) {
        // Başarılı yanıt
        echo json_encode([
            'success' => true,
            'message' => $successCount . ' alet başarıyla ödünç verildi.' . (count($failures) ? ' Bazı aletler verilemedi.' : '')
        ]);
    } else {
        throw new Exception('Hiçbir alet ödünç verilemedi.');
    }
} catch (Exception $e) {
    // Hata yanıtı
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
