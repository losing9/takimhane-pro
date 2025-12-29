<?php
require_once __DIR__ . '/../vendor/autoload.php';

function generateQrCodeBase64($data) {
    if (empty($data) || !is_string($data) || strlen(trim($data)) === 0) {
        // Boş veya geçersiz veri ile QR üretme, hata döndür
        return '';
    }
    require_once __DIR__ . '/../vendor/tecnickcom/tcpdf/tcpdf_barcodes_2d.php';
    $qr = new TCPDF2DBarcode($data, 'QRCODE,H');
    $arr = $qr->getBarcodeArray();
    if (
        !isset($arr['num_cols']) || !isset($arr['num_rows']) ||
        $arr['num_cols'] <= 0 || $arr['num_rows'] <= 0
    ) {
        // Hatalı QR array, PNG üretme
        return '';
    }
    $png = $qr->getBarcodePngData(6, 6, array(0,0,0));
    return 'data:image/png;base64,' . base64_encode($png);
}
