<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Oturum kontrolü
checkLogin();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'] ?? 0;

    if (empty($id)) {
        echo json_encode(['success' => false, 'message' => 'Geçersiz ID.']);
        exit();
    }

    try {
        // Soft delete - silindi kolonunu 1 yap
        $stmt = $db->prepare("UPDATE aletler SET silindi = 1 WHERE id = ?");
        $stmt->execute([$id]);

        if ($stmt->rowCount() > 0) {
            echo json_encode(['success' => true, 'message' => 'Alet başarıyla silindi.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Alet bulunamadı.']);
        }
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'message' => 'Veritabanı hatası: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Geçersiz istek.']);
}
