<?php
// Hata raporlamayı kapat
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../../config/database.php';
require_once '../../includes/functions.php';
require_once '../../vendor/tecnickcom/tcpdf/tcpdf.php';
require_once '../../includes/qr_functions.php';

// Tutanak ID'sini al
$tutanak_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Tutanak bilgilerini getir
$stmt = $db->prepare("
    SELECT ht.*, a.adi as alet_adi, a.seri_no,
           CONCAT(p.ad, ' ', p.soyad) as zimmetli_personel,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
           a.durum as alet_durumu
    FROM hasar_tutanaklari ht
    JOIN aletler a ON ht.alet_id = a.id
    LEFT JOIN personel p ON a.zimmetli_personel_id = p.id
    WHERE ht.id = ?
");

try {
    $stmt->execute([$tutanak_id]);
    $tutanak = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$tutanak) {
        throw new Exception('Tutanak bulunamadı.');
    }

    // QR Kod verisi
    $qrData = 'Tutanak No: ' . $tutanak['tutanak_no'] . "\nAlet: " . $tutanak['alet_adi'] . "\nSeri No: " . $tutanak['seri_no'];
    $qrBase64 = generateQrCodeBase64($qrData);

    // PDF oluştur
    class MYPDF extends TCPDF {
        public function Header() {
            // Logo ve başlık
           
            $this->SetFont('dejavusans', '', 11);
            $this->SetXY(0, 10);
            
            $this->SetFont('dejavusans', 'B', 13);
            $this->Cell(0, 8, 'KOLUMAN MOTORLU ARAÇLAR', 0, 1, 'C');
            $this->SetFont('dejavusans', '', 11);
            $this->Cell(0, 6, 'Tarsus Takımhane', 0, 1, 'C');
            $this->Ln(2);
        }
        public function Footer() {
            $this->SetY(-30);
            $this->SetFont('dejavusans', '', 8);
            
            $this->Cell(0, 5, 'Bu belge sistem tarafından elektronik olarak üretilmiştir.', 0, 0, 'L');
        }
    }

    $pdf = new MYPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
    $pdf->SetMargins(20, 45, 20);
    $pdf->SetAutoPageBreak(TRUE, 35);
    $pdf->SetFont('dejavusans', '', 11);
    $pdf->AddPage();

    $tarih = date('d.m.Y', strtotime($tutanak['hasar_tarihi']));
    $pdf->SetFont('dejavusans', '', 11);
    $pdf->SetXY(20, 40);
    
    $pdf->SetXY(-80, 40);
    $pdf->Cell(0, 6, 'Tarih : ' . $tarih, 0, 1, 'R');
    $pdf->SetXY(20, 48);

    $pdf->Ln(10);
    $pdf->SetFont('dejavusans', 'B', 12);
    $pdf->Cell(0, 8, 'HASAR TUTANAĞI', 0, 1, 'C');
    $pdf->Ln(4);
    $pdf->SetFont('dejavusans', '', 11);
    $metin = "Aşağıda bilgileri verilen aletin hasar tespiti yapılmıştır.\n\n" .
        "Alet Adı: " . $tutanak['alet_adi'] . "\n" .
        "Seri No: " . $tutanak['seri_no'] . "\n" .
       
        "Durum: " . $tutanak['alet_durumu'] . "\n" .
        "Hasar Türü: " . $tutanak['hasar_turu'] . "\n" .
        "Hasar Yeri: " . $tutanak['hasar_yeri'] . "\n" .
        "Hasar Nedeni: " . $tutanak['hasar_nedeni'] . "\n" .
        "Açıklama: " . ($tutanak['hasar_aciklamasi'] ?: '-');
    $pdf->MultiCell(0, 7, $metin, 0, 'L');
    $pdf->Ln(10);
    $pdf->SetFont('dejavusans', '', 11);
    $pdf->Cell(0, 7, 'Gereğini bilgilerinize arz ederim.', 0, 1, 'L');
    $pdf->Ln(18);
    $pdf->SetFont('dejavusans', '', 11);
    // 3 imza alanı: Personel, Takımhane Sorumlusu, Atölye Şefi
    $pdf->Cell(60, 7, '_________________________', 0, 0, 'C');
    $pdf->Cell(60, 7, '_________________________', 0, 0, 'C');
    $pdf->Cell(60, 7, '_________________________', 0, 1, 'C');
    $pdf->Cell(60, 7, 'Personel', 0, 0, 'C');
    $pdf->Cell(60, 7, 'Takımhane Sorumlusu', 0, 0, 'C');
    $pdf->Cell(60, 7, 'Atölye Şefi', 0, 1, 'C');
    $pdf->Ln(10);
    $pdf->SetFont('dejavusans', '', 9);
    
    
    $pdf->Output('hasar_tutanak_' . $tutanak_id . '.pdf', 'D');
    exit;

} catch (Exception $e) {
    // Hata durumunda ana sayfaya yönlendir
    header('Location: index.php');
    exit;
}
