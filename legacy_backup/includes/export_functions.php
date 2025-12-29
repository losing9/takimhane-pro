<?php
require_once __DIR__ . '/../vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use TCPDF;

/**
 * Excel dosyası oluşturur ve indirir
 * @param array $data Tablo verileri
 * @param array $headers Tablo başlıkları
 * @param string $filename Dosya adı
 */
function exportToExcel($data, $headers, $filename) {
    // Yeni bir Spreadsheet nesnesi oluştur
    $spreadsheet = new Spreadsheet();
    $sheet = $spreadsheet->getActiveSheet();

    // Başlıkları ekle
    $col = 'A';
    foreach ($headers as $header) {
        $sheet->setCellValue($col . '1', $header);
        $sheet->getColumnDimension($col)->setAutoSize(true);
        $col++;
    }

    // Verileri ekle
    $row = 2;
    foreach ($data as $rowData) {
        $col = 'A';
        foreach ($rowData as $value) {
            $sheet->setCellValue($col . $row, $value);
            $col++;
        }
        $row++;
    }

    // Başlık stilini ayarla
    $headerStyle = [
        'font' => [
            'bold' => true,
            'color' => ['rgb' => 'FFFFFF'],
        ],
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'startColor' => ['rgb' => '4F81BD']
        ]
    ];
    $sheet->getStyle('A1:' . $col . '1')->applyFromArray($headerStyle);

    // Excel dosyasını oluştur ve indir
    header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    header('Content-Disposition: attachment;filename="' . $filename . '.xlsx"');
    header('Cache-Control: max-age=0');

    $writer = new Xlsx($spreadsheet);
    $writer->save('php://output');
    exit;
}

/**
 * PDF dosyası oluşturur ve indirir
 * @param array $data Tablo verileri
 * @param array $headers Tablo başlıkları
 * @param string $title Rapor başlığı
 * @param string $filename Dosya adı
 */
function exportToPDF($data, $headers, $title, $filename) {
    // Yeni bir TCPDF nesnesi oluştur
    $pdf = new TCPDF('L', 'mm', 'A4', true, 'UTF-8');

    // Döküman bilgilerini ayarla
    $pdf->SetCreator('Takımhane Takip Sistemi');
    $pdf->SetAuthor('Takımhane Takip');
    $pdf->SetTitle($title);

    // Varsayılan başlık ve altbilgiyi kaldır
    $pdf->setPrintHeader(false);
    $pdf->setPrintFooter(false);

    // Yeni sayfa ekle
    $pdf->AddPage();

    // Başlığı ekle
    $pdf->SetFont('dejavusans', 'B', 16);
    $pdf->Cell(0, 10, $title, 0, 1, 'C');
    $pdf->Ln(5);

    // Tablo başlıklarını ekle
    $pdf->SetFont('dejavusans', 'B', 10);
    $pdf->SetFillColor(79, 129, 189);
    $pdf->SetTextColor(255, 255, 255);

    // Sütun genişliklerini hesapla
    $columnWidth = 270 / count($headers);
    foreach ($headers as $header) {
        $pdf->Cell($columnWidth, 7, $header, 1, 0, 'C', true);
    }
    $pdf->Ln();

    // Tablo verilerini ekle
    $pdf->SetFont('dejavusans', '', 9);
    $pdf->SetTextColor(0, 0, 0);
    $pdf->SetFillColor(240, 240, 240);
    $fill = false;

    foreach ($data as $row) {
        foreach ($row as $value) {
            $pdf->Cell($columnWidth, 6, $value, 1, 0, 'L', $fill);
        }
        $pdf->Ln();
        $fill = !$fill;
    }

    // PDF dosyasını indir
    $pdf->Output($filename . '.pdf', 'D');
    exit;
}

/**
 * Veriyi dışa aktarır (Excel veya PDF)
 * @param string $type Dışa aktarma türü ('excel' veya 'pdf')
 * @param array $data Tablo verileri
 * @param array $headers Tablo başlıkları
 * @param string $title Rapor başlığı
 * @param string $filename Dosya adı
 */
function exportData($type, $data, $headers, $title, $filename) {
    if ($type === 'excel') {
        exportToExcel($data, $headers, $filename);
    } else if ($type === 'pdf') {
        exportToPDF($data, $headers, $title, $filename);
    }
}
