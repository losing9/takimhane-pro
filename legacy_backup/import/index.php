<?php
session_start();
require_once '../config/database.php';
require_once '../includes/functions.php';

// Oturum kontrolü
checkLogin();
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excel İçe Aktar - Takımhane Takip</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); }
    </style>
</head>
<body>
    <div class="container mt-4 mb-4">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="fas fa-file-excel me-2"></i>Excel Dosyası İçe Aktar</h4>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            <h5 class="alert-heading"><i class="fas fa-info-circle me-2"></i>Excel Dosya Formatı</h5>
                            <p>Excel dosyanız aşağıdaki sütunları içermelidir:</p>
                            <ol>
                                <li>A Sütunu: Seri Numarası (zorunlu)</li>
                                <li>B Sütunu: Alet Adı (zorunlu)</li>
                                <li>C Sütunu: Raf Kodu</li>
                                <li>D Sütunu: Açıklama</li>
                                <li>F Sütunu: Stok Giriş Tarihi</li>
                            </ol>
                            <hr>
                            <p class="mb-0"><strong>Not:</strong></p>
                            <ul class="mb-0">
                                <li>İlk satır başlık satırı olarak kabul edilecek ve atlanacaktır</li>
                                <li>Seri numarası aynı zamanda barkod olarak kullanılacaktır</li>
                                <li>Seri numarası ve alet adı zorunludur, diğer alanlar boş bırakılabilir</li>
                                <li>Raf kodu girilirse, yoksa otomatik oluşturulacak, varsa mevcut rafa bağlanacaktır</li>
                                <li>Kategori daha sonra manuel olarak düzenlenebilir</li>
                                <li>Tüm aletler varsayılan olarak "aktif" durumda eklenecektir</li>
                                <li>Kalibrasyon bilgileri daha sonra güncellenebilir</li>
                                <li>Boş satırlar otomatik olarak atlanacaktır</li>
                                <li>Stok giriş tarihi boş ise eklenme tarihi kullanılacaktır</li>
                            </ul>
                        </div>

                        <div class="mt-4">
                            <h5><i class="fas fa-file me-2"></i>Mevcut Excel Dosyası</h5>
                            <?php
                            $excelFile = __DIR__ . '/liste.xlsx';
                            if (file_exists($excelFile)) {
                                echo '<div class="alert alert-success d-flex justify-content-between align-items-center">
                                    <div><i class="fas fa-check-circle me-2"></i>liste.xlsx dosyası hazır</div>
                                    <a href="import.php" class="btn btn-success">
                                        <i class="fas fa-file-import me-2"></i>İçe Aktar
                                    </a>
                                </div>';
                            } else {
                                echo '<div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>liste.xlsx dosyası bulunamadı
                                </div>';
                            }
                            ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
