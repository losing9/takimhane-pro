<?php
require_once '../../vendor/autoload.php';
require_once '../../config/database.php';

// Aletler ve personel verilerini çek
$aletler = $db->query("SELECT adi, seri_no FROM aletler WHERE silindi=0 ORDER BY adi")->fetchAll(PDO::FETCH_ASSOC);
$personeller = $db->query("SELECT ad, soyad FROM personel ORDER BY ad, soyad")->fetchAll(PDO::FETCH_ASSOC);

$pdf = new \TCPDF('L', 'mm', array(62, 25), true, 'UTF-8', false); // 62x25mm (örnek Zebra/etiket)
$pdf->SetCreator('Takımhane Takip Sistemi');
$pdf->SetAuthor('Takımhane');
$pdf->SetTitle('Barkod Etiketleri');
$pdf->SetMargins(2, 2, 2);
$pdf->SetAutoPageBreak(false, 0);
$pdf->SetFont('dejavusans', '', 8, '', true); // UTF-8 desteği için true

// --- Aletler ---
foreach ($aletler as $alet) {
    $adi = mb_convert_encoding($alet['adi'], 'UTF-8', 'auto');
    $seri = mb_convert_encoding($alet['seri_no'], 'UTF-8', 'auto');
    $pdf->AddPage();
    $pdf->write2DBarcode($seri, 'DATAMATRIX', 2, 2, 20, 20);
    $pdf->SetXY(24, 2);
    $pdf->SetFont('dejavusans', '', 8, '', true);
    $pdf->MultiCell(36, 6, $adi, 0, 'L', 0, 1, '', '', true);
    $pdf->SetXY(24, 10);
    $pdf->SetFont('dejavusans', '', 7, '', true);
    $pdf->Cell(36, 6, $seri, 0, 1, 'L', 0, '', 0);
}
// --- Personeller ---
foreach ($personeller as $p) {
    $adsoyad = mb_convert_encoding($p['ad'] . ' ' . $p['soyad'], 'UTF-8', 'auto');
    $pdf->AddPage();
    $pdf->write2DBarcode($adsoyad, 'DATAMATRIX', 2, 2, 20, 20);
    $pdf->SetXY(24, 8);
    $pdf->SetFont('dejavusans', '', 8, '', true);
    $pdf->Cell(36, 6, $adsoyad, 0, 1, 'L', 0, '', 0);
}
$pdf->Output('barkod_etiketleri.pdf', 'I');
