<?php
// Saf JSON çıktısı ve debug log için tüm buffer'ı temizle
while (ob_get_level()) ob_end_clean();
require_once '../../config/database.php';
header('Content-Type: application/json; charset=utf-8');

$logFile = __DIR__ . '/alet_getir_debug.log';
function log_debug($msg) {
    global $logFile;
    file_put_contents($logFile, date('Y-m-d H:i:s') . ' ' . $msg . "\n", FILE_APPEND);
}

log_debug('--- Yeni istek ---');
log_debug('GET: ' . json_encode($_GET));

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id <= 0) {
    $out = json_encode(['success' => false, 'message' => 'Geçersiz ID']);
    log_debug('Yanıt: ' . $out);
    echo $out;
    exit;
}

$stmt = $db->prepare("SELECT * FROM aletler WHERE id = ?");
$stmt->execute([$id]);
$alet = $stmt->fetch(PDO::FETCH_ASSOC);

if ($alet) {
    $out = json_encode(['success' => true, 'data' => $alet], JSON_UNESCAPED_UNICODE);
    log_debug('Yanıt: ' . $out);
    echo $out;
} else {
    $out = json_encode(['success' => false, 'message' => 'Alet bulunamadı']);
    log_debug('Yanıt: ' . $out);
    echo $out;
}

// Fazladan çıktı var mı kontrolü
$extra = ob_get_contents();
if ($extra) {
    log_debug('Fazladan çıktı: ' . $extra);
}
log_debug('--- İstek sonu ---');
exit;
