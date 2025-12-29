<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Composer autoload ve Picqer Barcode kütüphanesi gerekli
require_once '../../vendor/autoload.php';
use Picqer\Barcode\BarcodeGeneratorPNG;

header('Content-Type: application/json');

try {
    $seri_no = cleanInput($_POST['seri_no']);
    
    // Barkod oluşturucu
    $generator = new BarcodeGeneratorPNG();
    
    // Code128 formatında barkod oluştur
    $barkod = $generator->getBarcode($seri_no, $generator::TYPE_CODE_128);
    
    // Barkodu dosya olarak kaydet
    $barkod_dizin = '../../assets/barkodlar/';
    if (!file_exists($barkod_dizin)) {
        mkdir($barkod_dizin, 0777, true);
    }
    
    $dosya_adi = $barkod_dizin . $seri_no . '.png';
    file_put_contents($dosya_adi, $barkod);
    
    echo json_encode([
        'success' => true,
        'barkod_url' => '/assets/barkodlar/' . $seri_no . '.png'
    ]);

} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Barkod oluşturma hatası: ' . $e->getMessage()
    ]);
}
