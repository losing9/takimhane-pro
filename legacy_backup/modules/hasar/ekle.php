<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

// JSON yanıtı hazırla
header('Content-Type: application/json');
$response = ['success' => false, 'message' => ''];

try {
    // POST verilerini al
    $alet_id = $_POST['alet_id'] ?? null;
    $personel_id = $_POST['personel_id'] ?? null;
    $is_emri_no = $_POST['is_emri_no'] ?? null;
    $hasar_tarihi = $_POST['hasar_tarihi'] ?? null;
    $hasar_yeri = $_POST['hasar_yeri'] ?? null;
    $hasar_turu = $_POST['hasar_turu'] ?? null;
    $hasar_nedeni = $_POST['hasar_nedeni'] ?? null;
    $hasar_aciklamasi = $_POST['hasar_aciklamasi'] ?? null;
    $tahmini_maliyet = $_POST['tahmini_maliyet'] ?? null;

    // Gerekli alanları kontrol et
    if (!$alet_id || !$personel_id || !$hasar_tarihi) {
        throw new Exception('Lütfen tüm zorunlu alanları doldurun.');
    }

    // Tutanak numarası oluştur (Yıl-Ay-Sıra No)
    $yil = date('Y');
    $ay = date('m');
    
    // Bu ay için son tutanak numarasını bul
    $stmt = $db->prepare("
        SELECT MAX(CAST(SUBSTRING_INDEX(tutanak_no, '-', -1) AS UNSIGNED)) as son_no
        FROM hasar_tutanaklari
        WHERE tutanak_no LIKE :pattern
    ");
    $stmt->execute(['pattern' => "$yil-$ay-%"]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $sira_no = ($result['son_no'] ?? 0) + 1;
    
    // Tutanak numarası formatı: 2024-02-001
    $tutanak_no = sprintf("%s-%s-%03d", $yil, $ay, $sira_no);

    // Hasar tutanağını kaydet
    $stmt = $db->prepare("
        INSERT INTO hasar_tutanaklari (
            tutanak_no, alet_id, personel_id, is_emri_no, hasar_tarihi,
            hasar_yeri, hasar_turu, hasar_nedeni, hasar_aciklamasi,
            tahmini_maliyet, durum
        ) VALUES (
            :tutanak_no, :alet_id, :personel_id, :is_emri_no, :hasar_tarihi,
            :hasar_yeri, :hasar_turu, :hasar_nedeni, :hasar_aciklamasi,
            :tahmini_maliyet, 'beklemede'
        )
    ");

    $stmt->execute([
        'tutanak_no' => $tutanak_no,
        'alet_id' => $alet_id,
        'personel_id' => $personel_id,
        'is_emri_no' => $is_emri_no,
        'hasar_tarihi' => $hasar_tarihi,
        'hasar_yeri' => $hasar_yeri,
        'hasar_turu' => $hasar_turu,
        'hasar_nedeni' => $hasar_nedeni,
        'hasar_aciklamasi' => $hasar_aciklamasi,
        'tahmini_maliyet' => $tahmini_maliyet
    ]);

    // Aletin durumunu güncelle
    $stmt = $db->prepare("UPDATE aletler SET durum = 'hasarli' WHERE id = ?");
    $stmt->execute([$alet_id]);

    $response['success'] = true;
    $response['message'] = 'Hasar tutanağı başarıyla oluşturuldu.';
    $response['tutanak_no'] = $tutanak_no;

} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

echo json_encode($response);
