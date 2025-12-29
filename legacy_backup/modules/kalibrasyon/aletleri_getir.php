<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
require_once '../../config/database.php';
require_once '../../includes/functions.php';

header('Content-Type: application/json');

try {
    $q = isset($_GET['q']) ? cleanInput($_GET['q']) : '';
    $sql = "SELECT a.id, a.seri_no, a.adi, a.marka,
            (SELECT MAX(k.sonraki_kalibrasyon_tarihi) 
             FROM kalibrasyon k 
             WHERE k.alet_id = a.id) as son_kalibrasyon
            FROM aletler a
            WHERE a.durum != 'hasarli' AND a.silindi = 0";
    $params = [];
    if ($q) {
        $sql .= " AND (a.adi LIKE :q OR a.seri_no LIKE :q)";
        $params[':q'] = "%$q%";
    }
    $sql .= " ORDER BY a.adi LIMIT 50";
    $stmt = $db->prepare($sql);
    $stmt->execute($params);
    $aletler = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($aletler as &$alet) {
        if ($alet['son_kalibrasyon']) {
            $kalanGun = floor((strtotime($alet['son_kalibrasyon']) - time()) / (60 * 60 * 24));
            $alet['kalibrasyon_durumu'] = $kalanGun < 0 ? 'Süresi Geçmiş' : 
                                         ($kalanGun <= 30 ? 'Yaklaşıyor' : 'Güncel');
        } else {
            $alet['kalibrasyon_durumu'] = 'Kalibrasyon Gerekli';
        }
    }
    // Eğer sonuç boşsa debug için örnek kayıt ekle
    if (empty($aletler)) {
        $aletler[] = [
            'id' => 0,
            'seri_no' => 'DEBUG',
            'adi' => 'Örnek Alet (DEBUG)',
            'marka' => 'YOK',
            'son_kalibrasyon' => null,
            'kalibrasyon_durumu' => 'YOK'
        ];
    }
    // DEBUG: Sonuçları logla
    file_put_contents(__DIR__ . '/aletleri_getir_debug.log', print_r([
        'q' => $q,
        'sql' => $sql,
        'params' => $params,
        'result_count' => count($aletler),
        'result_sample' => $aletler ? $aletler[0] : null
    ], true));
    echo json_encode($aletler);
} catch (Exception $e) {
    echo json_encode([
        'error' => 'Aletler getirilirken hata oluştu: ' . $e->getMessage()
    ]);
}
