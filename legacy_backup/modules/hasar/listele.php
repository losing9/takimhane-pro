<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

// JSON yanıtı hazırla
header('Content-Type: application/json');
$response = ['success' => false, 'tutanaklar' => []];

try {
    // Durum filtresi
    $durum = $_GET['durum'] ?? null;
    $where = $durum ? 'WHERE ht.durum = :durum' : '';

    // Hasar tutanaklarını getir
    $sql = "
        SELECT 
            ht.*,
            a.seri_no as alet_seri_no,
            a.adi as alet_adi,
            CONCAT(p.ad, ' ', p.soyad) as personel_ad_soyad,
            p.sicil_no as personel_sicil_no
        FROM hasar_tutanaklari ht
        JOIN aletler a ON ht.alet_id = a.id
        JOIN personel p ON ht.personel_id = p.id
        $where
        ORDER BY ht.hasar_tarihi DESC
    ";

    $stmt = $db->prepare($sql);
    if ($durum) {
        $stmt->bindParam(':durum', $durum);
    }
    $stmt->execute();

    $response['tutanaklar'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $response['success'] = true;

} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

echo json_encode($response);
