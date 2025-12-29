<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
require_once '../../config/database.php';
header('Content-Type: application/json');

// Toplam alet sayısı
$totalTools = $db->query("SELECT COUNT(*) FROM aletler WHERE silindi = 0")->fetchColumn();
// Ödünçteki alet sayısı
$borrowedTools = $db->query("SELECT COUNT(*) FROM odunc_kayitlari WHERE iade_tarihi IS NULL")->fetchColumn();
// Kalibrasyonu yaklaşan alet sayısı (30 gün içinde)
$calibrationDue = $db->query("SELECT COUNT(*) FROM kalibrasyon WHERE sonraki_kalibrasyon_tarihi <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) AND sonraki_kalibrasyon_tarihi >= CURDATE()")->fetchColumn();
// Servisteki alet sayısı (varsa)
$inService = $db->query("SELECT COUNT(*) FROM aletler WHERE durum = 'serviste'")->fetchColumn();

echo json_encode([
    'totalTools' => (int)$totalTools,
    'borrowedTools' => (int)$borrowedTools,
    'calibrationDue' => (int)$calibrationDue,
    'inService' => (int)$inService
]);
