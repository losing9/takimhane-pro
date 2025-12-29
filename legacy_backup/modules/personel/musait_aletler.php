<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

header('Content-Type: application/json');

try {
    // Sadece aktif ve müsait aletleri getir
    $sql = "SELECT id, seri_no, adi, marka 
            FROM aletler 
            WHERE durum = 'aktif' 
            ORDER BY adi";
    
    $stmt = $db->prepare($sql);
    $stmt->execute();
    $aletler = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($aletler);

} catch (Exception $e) {
    echo json_encode([
        'error' => 'Aletler getirilirken hata oluştu: ' . $e->getMessage()
    ]);
}
