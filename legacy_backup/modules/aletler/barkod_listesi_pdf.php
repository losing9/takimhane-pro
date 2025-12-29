<?php
require_once '../../vendor/autoload.php';
require_once '../../config/database.php';

// Aletler ve personel verilerini çek
$aletler = $db->query("SELECT adi, seri_no FROM aletler WHERE silindi=0 ORDER BY adi")->fetchAll(PDO::FETCH_ASSOC);
$personeller = $db->query("SELECT ad, soyad FROM personel ORDER BY ad, soyad")->fetchAll(PDO::FETCH_ASSOC);

$pdf = new \TCPDF('P', 'mm', 'A4', true, 'UTF-8', false);
$pdf->SetCreator('Takımhane Takip Sistemi');
$pdf->SetAuthor('Takımhane');
$pdf->SetTitle('Barkod Listesi');
$pdf->SetMargins(5, 5, 5);
$pdf->SetAutoPageBreak(true, 5);
$pdf->AddPage();
$pdf->SetFont('dejavusans', '', 8);

$maxCols = 6; // Bir satırda 6 barkod
$maxRows = 12; // Bir sayfada 12 satır (toplam 72 barkod)
$cellW = 32;
$cellH = 22;

function addBarcodeCell($pdf, $x, $y, $barcodeText, $label, $cellW) {
    $pdf->SetXY($x, $y);
    $pdf->write2DBarcode($barcodeText, 'DATAMATRIX', $x + 2, $y + 2, 18, 18);
    $pdf->SetXY($x + 20, $y + 2);
    $pdf->MultiCell(10, 5, '', 0, 'L', 0, 0, '', '', true); // boşluk
    $pdf->SetXY($x + 2, $y + 20);
    $pdf->SetFont('dejavusans', '', 7);
    $pdf->Cell($cellW - 4, 3, $label, 0, 0, 'C', 0, '', 0);
    $pdf->SetFont('dejavusans', '', 8);
}

// --- Aletler ---
$allBarcodes = [];
foreach ($aletler as $alet) {
    $allBarcodes[] = [
        'text' => $alet['seri_no'],
        'label' => $alet['adi'] . "\n" . $alet['seri_no']
    ];
}
// --- Personeller ---
foreach ($personeller as $p) {
    $adsoyad = $p['ad'] . ' ' . $p['soyad'];
    $allBarcodes[] = [
        'text' => $adsoyad,
        'label' => $adsoyad
    ];
}

$row = 0;
$col = 0;
$x0 = 5;
$y0 = 10;
foreach ($allBarcodes as $i => $b) {
    $x = $x0 + $col * $cellW;
    $y = $y0 + $row * $cellH;
    addBarcodeCell($pdf, $x, $y, $b['text'], $b['label'], $cellW);
    $col++;
    if ($col >= $maxCols) {
        $col = 0;
        $row++;
    }
    if ($row >= $maxRows) {
        $pdf->AddPage();
        $row = 0;
        $col = 0;
    }
}
$pdf->Output('barkod_listesi.pdf', 'I');
