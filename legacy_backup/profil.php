<?php
require_once 'config/database.php';
require_once 'includes/functions.php';
require_once 'includes/header.php';

if (!isset($_SESSION['user_id']) && !isset($_SESSION['kullanici_id'])) {
    header('Location: /login.php');
    exit;
}

$user_id = $_SESSION['user_id'] ?? $_SESSION['kullanici_id'];
$stmt = $db->prepare("SELECT * FROM users WHERE id = ?");
$stmt->execute([$user_id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    echo '<div class="alert alert-danger">Kullanıcı bulunamadı.</div>';
    require_once 'includes/footer.php';
    exit;
}

// Profil güncelleme işlemi (modal ile)
$hata = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['profil_guncelle'])) {
    $name = trim($_POST['name'] ?? '');
    $surname = trim($_POST['surname'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    if ($name === '' || $surname === '' || $email === '' || $username === '') {
        $hata = 'Tüm alanlar zorunludur.';
    } else {
        if ($password !== '') {
            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $db->prepare("UPDATE users SET name=?, surname=?, email=?, username=?, password=? WHERE id=?");
            $stmt->execute([$name, $surname, $email, $username, $password_hash, $user_id]);
        } else {
            $stmt = $db->prepare("UPDATE users SET name=?, surname=?, email=?, username=? WHERE id=?");
            $stmt->execute([$name, $surname, $email, $username, $user_id]);
        }
        $_SESSION['kullanici_adi'] = $username;
        header('Location: profil.php?guncellendi=1');
        exit;
    }
}
?>
<div class="container py-4" style="max-width:700px;">
    <div class="row g-4">
        <div class="col-12">
            <div class="card shadow-sm p-4 text-center">
                <div class="mb-3">
                    <img src="https://ui-avatars.com/api/?name=<?= urlencode(($user['name'] ?? '').' '.($user['surname'] ?? '')) ?>&background=0D8ABC&color=fff&size=120" class="rounded-circle shadow" width="120" height="120" alt="Profil Foto">
                </div>
                <h3 class="mb-0"><?= htmlspecialchars(($user['name'] ?? '').' '.($user['surname'] ?? '')) ?></h3>
                <div class="text-muted">@<?= htmlspecialchars($user['username'] ?? '') ?></div>
                <div class="mt-2 mb-3">
                    <span class="badge bg-primary"><i class="bi bi-envelope"></i> <?= htmlspecialchars($user['email'] ?? '') ?></span>
                </div>
                <div class="d-flex justify-content-center gap-2 mb-3">
                    <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#profilEditModal"><i class="bi bi-pencil"></i> Profili Düzenle</button>
                    <a href="logout.php" class="btn btn-outline-danger"><i class="bi bi-box-arrow-right"></i> Çıkış Yap</a>
                </div>
                <?php if (isset($_GET['guncellendi'])): ?>
                    <div class="alert alert-success">Profil başarıyla güncellendi.</div>
                <?php endif; ?>
                <?php if (!empty($hata)): ?>
                    <div class="alert alert-danger"> <?= $hata ?> </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
    <!-- Profil Düzenle Modal -->
    <div class="modal fade" id="profilEditModal" tabindex="-1" aria-labelledby="profilEditModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form method="post">
            <div class="modal-header">
              <h5 class="modal-title" id="profilEditModalLabel">Profili Düzenle</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="profil_guncelle" value="1">
                <div class="mb-3">
                    <label class="form-label">Ad</label>
                    <input type="text" name="name" class="form-control" value="<?= htmlspecialchars($user['name'] ?? '') ?>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Soyad</label>
                    <input type="text" name="surname" class="form-control" value="<?= htmlspecialchars($user['surname'] ?? '') ?>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">E-posta</label>
                    <input type="email" name="email" class="form-control" value="<?= htmlspecialchars($user['email'] ?? '') ?>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Kullanıcı Adı</label>
                    <input type="text" name="username" class="form-control" value="<?= htmlspecialchars($user['username'] ?? '') ?>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Yeni Şifre (değiştirmek için doldurun)</label>
                    <input type="password" name="password" class="form-control" autocomplete="new-password">
                </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
              <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Kaydet</button>
            </div>
          </form>
        </div>
      </div>
    </div>
</div>
<?php require_once 'includes/footer.php'; ?>
