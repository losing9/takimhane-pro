<?php
// Composer autoload'u eklemeden sadece TCPDF 2D Barcode dosyasını dahil et
require_once __DIR__ . '/../../vendor/tecnickcom/tcpdf/tcpdf_barcodes_2d.php';

$barkod = $_GET['code'] ?? '';
if (empty($barkod)) {
    header("HTTP/1.0 404 Not Found");
    echo 'Barkod verisi eksik.';
    exit;
}

// Türkçe karakter desteği için UTF-8 encode ve normalizasyon
if (!mb_check_encoding($barkod, 'UTF-8')) {
    $barkod = mb_convert_encoding($barkod, 'UTF-8', 'auto');
}
// Unicode Normalization (NFC)
if (class_exists('Normalizer')) {
    $barkod = Normalizer::normalize($barkod, Normalizer::FORM_C);
}

// DataMatrix barkodunu PNG olarak üret
try {
    $barcode = new TCPDF2DBarcode($barkod, 'DATAMATRIX');
    $barcodeArray = $barcode->getBarcodeArray();
    $w = 4; // piksel başına kutu genişliği
    $h = 4; // piksel başına kutu yüksekliği
    $cols = $barcodeArray['num_cols'];
    $rows = $barcodeArray['num_rows'];
    $imgW = $cols * $w;
    $imgH = $rows * $h;
    $im = imagecreatetruecolor($imgW, $imgH);
    $white = imagecolorallocate($im, 255, 255, 255);
    $black = imagecolorallocate($im, 0, 0, 0);
    imagefill($im, 0, 0, $white);
    for ($r = 0; $r < $rows; $r++) {
        for ($c = 0; $c < $cols; $c++) {
            if ($barcodeArray['bcode'][$r][$c]) {
                imagefilledrectangle($im, $c * $w, $r * $h, ($c + 1) * $w - 1, ($r + 1) * $h - 1, $black);
            }
        }
    }
    header('Content-Type: image/png');
    imagepng($im);
    imagedestroy($im);
} catch (Exception $e) {
    header('Content-Type: text/plain');
    echo 'Barkod oluşturulamadı: ' . $e->getMessage();
}
