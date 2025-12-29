<?php
require_once '../../config/database.php';
require_once '../../includes/functions.php';
require_once '../../includes/qr_functions.php';

// Tüm rafları çek
$stmt = $db->query("SELECT * FROM raf_listesi ORDER BY adi ASC");
$raflar = $stmt->fetchAll(PDO::FETCH_ASSOC);
?><!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Raf Etiketleri Yazdır</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/style.css" rel="stylesheet">
    <style>
        @media print {
            .no-print { display: none !important; }
            .etiket { page-break-inside: avoid; }
        }
        .etiket {
            width: 60mm;
            height: 40mm;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin: 8px;
            padding: 6px 4px 2px 4px;
            display: inline-block;
            vertical-align: top;
            background: #fff;
            text-align: center;
        }
        .etiket img { width: 120px; height: 120px; margin-bottom: 2px; }
        .etiket .adi { font-weight: bold; font-size: 1.1em; }
        .etiket .konum { font-size: 0.95em; color: #555; }
        .etiket .id { font-size: 0.85em; color: #888; }
    </style>
</head>
<body class="bg-light">
    <div class="container-fluid py-3">
        <div class="d-flex justify-content-between align-items-center mb-3 no-print">
            <h2 class="mb-0"><i class="bi bi-printer"></i> Raf Etiketleri Yazdır</h2>
            <button class="btn btn-success" onclick="window.print()"><i class="bi bi-printer"></i> Yazdır</button>
            <a href="barkod_listesi.php" class="btn btn-secondary">Geri</a>
        </div>
        <div class="d-flex flex-wrap justify-content-start">
        <?php foreach($raflar as $raf):
            $stmt2 = $db->prepare("SELECT * FROM aletler WHERE raf_id=?");
            $stmt2->execute([$raf['id']]);
            $aletler = $stmt2->fetchAll(PDO::FETCH_ASSOC);
            $qrData = 'Raf ID: ' . $raf['id'] . "\nRaf: " . $raf['adi'];
            if(count($aletler) > 0) {
                $qrData .= "\n--- İçerik ---";
                foreach($aletler as $a) {
                    $qrData .= "\n" . $a['adi'] . " (" . $a['seri_no'] . ")";
                }
            }
            $qrBase64 = generateQrCodeBase64($qrData);
        ?>
        <div class="etiket">
            <img src="<?= $qrBase64 ?>" alt="QR Kod">
            <div class="adi"><?= htmlspecialchars($raf['adi']) ?></div>
            <div class="konum">Konum: <?= htmlspecialchars($raf['konum']) ?></div>
            <div class="id">ID: <?= $raf['id'] ?></div>
        </div>
        <?php endforeach; ?>
        </div>
    </div>
</body>
</html>
