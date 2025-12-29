-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost
-- Üretim Zamanı: 03 Tem 2025, 20:12:38
-- Sunucu sürümü: 10.3.38-MariaDB-0ubuntu0.20.04.1
-- PHP Sürümü: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `trac_trac`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `aletler`
--

CREATE TABLE `aletler` (
  `id` int(11) NOT NULL,
  `seri_no` varchar(50) NOT NULL,
  `adi` varchar(100) NOT NULL,
  `marka` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `durum` enum('aktif','serviste','hasarli','kalibrasyon_bekliyor') DEFAULT 'aktif',
  `aciklama` text DEFAULT NULL,
  `olusturma_tarihi` timestamp NULL DEFAULT current_timestamp(),
  `guncelleme_tarihi` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `barkod` varchar(50) DEFAULT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `raf_no` varchar(50) DEFAULT NULL,
  `silindi` tinyint(1) DEFAULT 0,
  `raf_id` int(11) DEFAULT NULL,
  `eklenme_tarihi` datetime DEFAULT current_timestamp(),
  `zimmetli_personel_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `aletler`
--

INSERT INTO `aletler` (`id`, `seri_no`, `adi`, `marka`, `model`, `durum`, `aciklama`, `olusturma_tarihi`, `guncelleme_tarihi`, `created_at`, `barkod`, `kategori`, `raf_no`, `silindi`, `raf_id`, `eklenme_tarihi`, `zimmetli_personel_id`) VALUES
(1, 'TM001', 'Dijital Multimetre', 'Fluke', '87V', 'hasarli', NULL, '2025-01-09 20:26:22', '2025-01-17 15:15:43', '2025-01-14 08:19:17', NULL, NULL, NULL, 0, NULL, '2025-01-14 22:36:13', NULL),
(2, 'TM002', 'Osiloskop', 'Tektronix', 'TDS2024C', 'aktif', NULL, '2025-01-09 20:26:22', '2025-01-10 08:48:03', '2025-01-14 08:19:17', NULL, NULL, NULL, 0, NULL, '2025-01-14 22:36:13', NULL),
(3, 'TM003', 'Termometre', 'Fluke', '52-2', 'aktif', NULL, '2025-01-09 20:26:22', '2025-01-09 20:26:22', '2025-01-14 08:19:17', NULL, NULL, NULL, 0, NULL, '2025-01-14 22:36:13', NULL),
(4, 'TM004', 'Güç Kaynağı', 'Keysight', 'E3631A', 'hasarli', NULL, '2025-01-09 20:26:22', '2025-01-14 08:52:36', '2025-01-14 08:19:17', NULL, NULL, NULL, 1, NULL, '2025-01-14 22:36:13', NULL),
(5, 'TM005', 'LCR Metre', 'BK Precision', '879B', 'kalibrasyon_bekliyor', NULL, '2025-01-09 20:26:22', '2025-01-09 20:26:22', '2025-01-14 08:19:17', NULL, NULL, NULL, 0, NULL, '2025-01-14 22:36:13', NULL),
(11, 'W210580340012', '12 Yıldız Lokma', 'Ricah', NULL, 'aktif', 'Yıldız Lokma', '2025-01-14 08:23:45', '2025-01-14 08:23:45', '2025-01-14 08:23:45', 'W210580340012', 'Lokma', 'Küçük Raf', 0, NULL, '2025-01-14 22:36:13', NULL),
(12, 'W210580340013', '13 Yıldız Lokma', 'Ricoh', NULL, 'hasarli', NULL, '2025-01-14 08:27:22', '2025-01-17 15:11:34', '2025-01-14 08:27:22', 'W210580340013', 'Lokma', 'Küçük Raf', 0, NULL, '2025-01-14 22:36:13', NULL),
(13, 'W415589009100', 'Kontrol Bağlantısı', NULL, NULL, 'hasarli', 'Soğutma sisteminin genleşme kabının kaçak testi için kontrol bağlantısı ve soğutma sisteminin radyatör vakumlama doldurma cihazı doldurulması için. Hatırlatma: Basınç pompası 124 589 24 21 00 ile ve soğutma sisteminin radyatör vakumlama doldurma cihazı 285 589 00 21 00 bağlantılı olarak.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W415589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(15, 'W654589000900', 'Lokma anahtarı', NULL, NULL, 'aktif', 'Motor bloğunda hidrolik yollu valfın sökülmesi ve takılması için lokma anahtarı', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589000900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(16, 'W607589044300', 'Takma el aleti', NULL, NULL, 'aktif', 'Radyal mil keçesinin volan tarafın takılması için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589044300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(17, 'W607589014300', 'Çektirme', NULL, NULL, 'hasarli', 'Volan tarafında ve krank milinde radyal mil keçesinin sökülmesi için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589014300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(18, 'W7000589003100', 'Çektirme', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W7000589003100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(19, 'W470589010700', 'Tırnaklı Anahtar', NULL, NULL, 'hasarli', 'Depo modülündeki ve AdBlue® pompa modülünde rakor somununun takılması ve sökülmesi için kıskaç anahtar.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589010700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(20, 'W259589001502', 'Malafa', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W259589001502', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(21, 'W700589011400', 'Kovan', NULL, NULL, 'aktif', 'Primer mili contasının takılması için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589011400', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(22, 'W607589011500', 'Malafa', NULL, NULL, 'aktif', 'Eksantrik milinin kilitlenmesi.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589011500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(23, 'W415589006300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W415589006300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(24, 'W626589034000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W626589034000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(25, 'Bilgi Yok', 'Çektirme', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'Bilgi Yok', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(26, 'W415589003300', 'Çektirme', NULL, NULL, 'aktif', 'Enine bugi kolundaki taşıma mafsalının çektirilmesi için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W415589003300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(27, 'W470589051500', 'Malafa', NULL, NULL, 'hasarli', 'Ön şanzıman dişli kutusundaki radyal mil keçesinin yenilenmesi için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589051500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(28, 'W607589054300', 'Takma el aleti', NULL, NULL, 'aktif', 'Kam mili radyal mil keçesinin montajı için içeri çektirme tertibatı. Teknik açıklama : Adaptör 607   589   06   43   00 ile bağlantılı olarak.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589054300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(29, 'W654589003201', 'Plaka', NULL, NULL, 'aktif', 'Kumanda zincirinin perçinlerinde silindir başı ayırma yüzeyinin koruma plakası. Hatırlatma: Sadece W   654   589   00   33   00 perçin presleme aleti ile bağlantılı olarak. Tahrik düşlüsü üzerinde kumanda zincirinin atmasının engellenmesi için plaka. 02 numaralı parça BİNEK 1/3 RAFINDA', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589003201', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(30, 'W700589081500', 'Malafa', NULL, NULL, 'aktif', 'Şanzımandaki sol contanın montajı için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589081500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(31, 'W607589024000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Eksantrik mili dişlisinin bloke edilmesi için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589024000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(32, 'W626589004000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Eksantrik mili dişlisinin emme eksantrik milinde kilitlenmesi için kontra tutucu', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W626589004000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(33, 'W203589014301 -02', 'Çektirerek sökme ve takma el aleti', NULL, NULL, 'aktif', ' Uzun rot kolu lastik yatakları için dışarı ve içeri presleme aleti Malafa 126 589 03 15 00 ile bağlantılı olarak mafsallı ara yatağın vites çatalı üzerine çakılarak takılması için dışarı ve içeri presleme aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W203589014301 -02', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(34, 'W700589021500', 'Malafa', NULL, NULL, 'aktif', ' Planet dişliye emniyet segmanının takılması için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589021500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(36, 'W240589009100', 'EHB- ADAPTÖR', NULL, NULL, 'aktif', 'Elektro-hidrolik fren tertibatının havasını tahliye etmek için EHB adaptörüdür. Hatırlatma: EHB adaptörünü kullanmak için, yanında gelen mandal kelepçesiyle havalandırma kabının hortumuna bağlayın.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W240589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(37, 'W700589011500', 'Malafa', NULL, NULL, 'aktif', 'Radyal mil keçelerinin içeri çakılması için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589011500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(39, 'W700589091500', 'Malafa', NULL, NULL, 'aktif', 'Şanzımandaki sağ contanın montajı için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589091500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(40, 'W700589001500', 'Malafa', NULL, NULL, 'aktif', ' Radyal mil yağ keçelerinin içeri çakılması için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589001500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(41, 'W700589001400', 'Lokma anahtarı', NULL, NULL, 'aktif', ' Geri vites şalterinin sökülmesi ve takılmasına ilişkin', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589001400', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(42, 'W626589014000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Şanzıman sökülmüş durumda marş motoru dişli çemberinin kilitlenmesi için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W626589014000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(43, 'W1105890000100', 'Rekor anahtarı', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W1105890000100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(45, 'W642589003100', 'Aşağıda tutma aleti seti', NULL, NULL, 'aktif', 'Supap başlığı açıkken eksantrik millerini sabitlemek için yatak köprüleri (2 adet). ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W642589003100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(46, 'W270589016100', 'Tutma Tertibatı', NULL, NULL, 'aktif', ' ÜÖN\'de eksantrik milin aşağıda tutulması ve sabitlenmesi için tutma tertibatı Hatırlatma Özel el aleti W270589 00 61 00, tutucu tertibatı modifiye edilmiş bir özel el aleti versiyonu W270589 01 61 00, tutucu tertibatı ile değiştirilir. Değişiklikler, özel el aletinin işlevselliğinin daha yeni motor-jenerasyonlarında da sağlanması için uygulanmıştır. Mevcut özel el aleti W270589 00 61 00, tutucu tertibatı tekli aleti W270589 01 61 15, takozu ile güncel duruma getirilebilir. Temin etme bilgisi: W270 589 00 61 00 tutma tertibatı için yedek.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W270589016100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(47, 'W220589044301', 'Takma el aleti', NULL, NULL, 'aktif', 'Arka aks taşıyıcısındaki arka elastomer yatağı için içeri çekme tertibatıdır.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W220589044301', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(48, 'W164589004300', 'Çektirerek sökme ve takma el aleti', NULL, NULL, 'aktif', 'Süspansiyon ünitesinin enine bağlantı kolunda bulanan elastomer yataklarının sökülmesi ve çakılması için sökme ve içeri çekme tertibatı. Teknik hatırlatma: Yalnızca W 652 589 00 33 21 el pompası, W 652 589 00 33 22 oluklu silindir, W 001 589 10 91 00 hortum ve W 652 589 00 33 11 dişli mil ile bağlantılı olarak.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W164589004300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(49, 'W700589161500', 'Malafa / Prizdirek', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589161500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(50, 'W607589003102', 'Adapsyon', NULL, NULL, 'aktif', 'Motorun sökülmesi ve takıması sırasında desteklenmesi ve bunlarla çalışma sırasında motor kaldırma tertibatının W246 589 00 62 00 uyumu için üst motor yatağı sökülmek zorundadır. Hatırlatma : Sadece motor kaldırma tertibatı W246 589 00 62 00 ile bağlantılı olarak kullanılmalıdır.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589003102', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(51, 'W166589004300', 'Çektirerek sökme ve takma el aleti', NULL, NULL, 'aktif', 'Ön aks enine bağlantı kolundaki yatağın sökülmesi ve takılması için sökme ve içeri çekme tertibatı. Teknik hatırlatma: W 001 589 51 33 00 hidrolik pres, W 652 589 00 33 21 el pompası ve W 001 589 00 33 23 00 elastomer yatağı ve konfor yatak için hidrolik hortum ile bağlantılı olarak.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W166589004300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(52, 'W163589004300 /04', 'Presleyerek sökme ve takma aleti', NULL, NULL, 'aktif', 'Elastomer yatağını ön ve arka aksın üst ve alt enine bağlantı kolundan çekerek çıkartmak ve takmak için çıkartma ve içeri bastırma aleti TİP 420: Elastomer yatağını arka akstan çekerek çıkartmak ve takmak için çıkartma ve içeri bastırma aleti Temin etme bilgisi: Bu atölye donanımının satışı durduruldu. Atölye donanımı artık temin edilebilir değil. Mümkünse lütfen kendiniz hazırlayın veya temin edin veya mevcut atölye donanımını onarın.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W163589004300 /04', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(53, 'W607589034300', 'Takma el aleti', NULL, NULL, 'aktif', 'Radyal mil keçesinin montajı için kumanda gövdesinde. Hatırlatma: Adaptör 607 589 00 43 00 ile bağlantılı olarak.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589034300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(54, 'W270589029100', 'Bağlantı Adaptörü', NULL, NULL, 'aktif', 'Hava yolunun arıza teşhisi için bağlantı adaptörü.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W270589029100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(55, 'W129589010900', 'Geçmeli kovan', NULL, NULL, 'aktif', 'Gösterge grubundaki soket lambalarını gösterge grubunu tamamen sökmek zorunda kalmadan sökmek ve takmak için dişi faston', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W129589010900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(56, 'W607058929100', 'Vidalanabilir parça', NULL, NULL, 'aktif', ': Kompresyon basıncı veya basınç kaybı ölçümü için kızdırma bujisindeki (M10x1) vidalanabilir parça.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607058929100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(57, 'W607589019100', 'ADAPTÖR', NULL, NULL, 'aktif', 'Yağ basıncı ölçümünde kontrol cihazının 103 589 00 21 00 bağlantısı için adaptör.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589019100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(58, 'W654589003202', 'PLAKA', NULL, NULL, 'aktif', 'Kumanda zincirinin perçinlerinde silindir başı ayırma yüzeyinin koruma plakası. Hatırlatma: Sadece W   654   589   00   33   00 perçin presleme aleti ile bağlantılı olarak. Tahrik düşlüsü üzerinde kumanda zincirinin atmasının engellenmesi için plaka. 01 NUMARALI PARÇA BİNEK 1/3 RAFINDA', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589003202', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(60, 'W646589022100', '1240 bar test adaptörü', NULL, NULL, 'aktif', 'Yakıt yüksek basınç devresinin akış kontrolü için test adaptörü. Miktar kısma kumandası 1240 bar\'da gerçekleşir. Kontrol cihazı kategorisi CAT_B.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W646589022100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(61, 'W642589026309', 'ADAPTÖR', NULL, NULL, 'aktif', 'Kompresyon ölçümü veya basınç kaybı ölçümü için NW 7,2\'den NW 5,0 nominal çapa redüksiyonlu basınçlı hava adaptörü. Hatırlatma : Vidalı adaptör W 270 589 01 91 00 ile bağlantılı olarak hortum A\'daki W 450 589 17 21 00 basınç kaybı test cihazına veya W 642 589 02 63 00 vidalı parçadaki W 001 589 76 21 00 kompresyon basıncı kayıt cihazına.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W642589026309', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(62, 'W642589020302', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W642589020302', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(63, 'W215589010311', 'Bilgi Yok', NULL, NULL, 'aktif', 'Somunlu metal çubuk', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W215589010311', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(64, 'W674589019000', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W674589019000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(65, 'W166589005300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Ahşap el aleti', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W166589005300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(66, 'W129589106300', 'Baskı parçası', NULL, NULL, 'aktif', ' Baskı parçası M12x1,5, tutucunun altı köşesi için korunma TİP 211.08/28/09/29, 220 W 124 589 02 33 00 çektirme TİP 140, 211, 215, 219, 220, 230, 240 W 140 589 00 33 00 çektirme TİP 203, 209, 216, 221 W 201 589 01 33 00 çektirme TİP 124, 129, 169, 170, 171, 201, 202, 203, 208, 210, 209, 211, 230, 245 W 203 589 00 33 00 çektirme TİP 164, 169, 190, 197, 204, 216, 221, 245, 251, 906 W 221 589 00 33 00 çektirme', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W129589106300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(67, 'W209589072300', 'Aralık mastarı', NULL, NULL, 'aktif', ' Kapı yan camı monte edilirken belli X konumda sabitlemek için sentil.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W209589072300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(68, 'W221589014300', 'Çektirme ve takma el aleti', NULL, NULL, 'aktif', 'Arka aks dişli kutusu yataklarının ön enine köprüden ve arka aks taşıyıcısından çektirilmesi ve takılması için dışarı ve içeri çektirme aleti. Hatırlatma: Sadece el pompası 652 589 00 33 21, hidrolik hortumu 652 589 00 33 23 ve delikli piston silindiri 001 589 51 33 00 ile birlikte kullanın.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W221589014300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(69, 'W725589005900', 'Sökme ve takma el aleti', NULL, NULL, 'aktif', ' Yağ pompasının konvertör gövdesinden sökülmesi ve takılması için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W725589005900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(70, 'W470589091500', 'Malafa', NULL, NULL, 'aktif', 'Radyal mil keçesinin otomatik şanzımanın güç çıkış miline takılması için malafa. Teknik bilgilendirme: Sadece 001   589   00   40   00 tutamak parçası ile birlikte.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589091500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(71, 'W470589061500', 'Malafa', NULL, NULL, 'aktif', 'Malafa', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589061500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(72, 'W654589032100', 'Ayar aleti', NULL, NULL, 'aktif', 'Üst ölü noktası pozisyonun (OT) tespit edilmesi için ayar aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589032100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(73, 'W001589004000', 'Tutma parçası', NULL, NULL, 'aktif', 'Çeşitli malafaların yuvası için kavrama parçası.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W001589004000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(74, 'W470589101500', 'Malafa', NULL, NULL, 'aktif', 'Otomatik şanzımanın tahrik flanşında radyal mil contasının yenilenmesi için malafa', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589101500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(76, 'W470589041400', 'Kaide', NULL, NULL, 'aktif', 'Turboşarjın kontrolünde komparatörü sabitleme altlığı. ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589041400', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(77, 'W654589001400/01/02/03', 'Kovan', NULL, NULL, 'aktif', ' Yakıt yüksek basınç pompasının sökülmesi ve takılmasında zincir dişlisinin yuvasının kovanı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589001400/01/02/03', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(78, 'W699589000501', 'El aleti', NULL, NULL, 'aktif', 'El Aleti', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W699589000501', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(79, 'W000589569800', 'Koruyucu soket', NULL, NULL, 'aktif', 'HV kontak noktalarını kapatmak ve HV kontaklarındaki ilgili ölçüm noktalarına yönlendirmek için koruyucu soket.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589569800', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(80, 'W119589004300', 'Malafa', NULL, NULL, 'aktif', 'Valf sapı contalarının silindir kapağına çakılması', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W119589004300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(81, 'W626589044000', 'Ayar aleti', NULL, NULL, 'aktif', 'Eksantrik milinin bloke edilmesi için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W626589044000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(82, 'W699589024000', 'Ayar aleti', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W699589024000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(83, 'W654589014300', 'Takma el aleti', NULL, NULL, 'aktif', 'Arka radyal mili keçesinin montajı için çekme tertibatı krank miline', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589014300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(84, 'W470589111500', 'Malafa', NULL, NULL, 'aktif', 'Otomatik şanzımanın tahrik flanşında radyal mil contasının yenilenmesi için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589111500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(85, 'W220589049938', 'NanoMQS kilit açma aleti', NULL, NULL, 'aktif', 'NanoMQS2‑temaslarının kilidinin çözülmesi için kilit açma el aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W220589049938', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(86, 'W654589004000 02', 'Karşı tutucu', NULL, NULL, 'aktif', 'Kayış tahrikinde ayırıcının demonte edilmesi ve monte edilmesi ayrıca krank milin döndürülmesi için karşı tutucu.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589004000 02', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(87, 'W725589029000 01/02', 'Montaj aleti', NULL, NULL, 'aktif', 'Şanzıman yağ durumunun kontrol edilmesi ve düzeltilmesi için. ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W725589029000 01/02', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(88, 'W256589023100', 'Montaj aleti', NULL, NULL, 'aktif', ' Eksantrik mili ayarlayıcısını döndürmek ve belirlemek için montaj aleti ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W256589023100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(89, 'W246589004000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Akü klemensinde (Plus) artı hattın montajı veya demontajı için kontra tutucu.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W246589004000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(90, 'W541589000100', 'Anahtar', NULL, NULL, 'aktif', 'El Aleti', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W541589000100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(91, 'W000589016800', 'Temizlik seti', NULL, NULL, 'aktif', 'SRS kumadna cihazındaki PIN\'lerin temizlenmesi için temizleme seti', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589016800', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(92, 'W626589024003', 'Karşı tutucu', NULL, NULL, 'aktif', 'Titreşim gidericisini karşı tutmak için. Krank milinin kayış kasnağından döndürülmesi için', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W626589024003', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(93, 'W699589034000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Yüksek basınç pompası çarkının blokajı için tutma kilidi.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W699589034000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(94, 'W470589081500 01/02/03', 'Malafa seti', NULL, NULL, 'aktif', ' Radyal mil keçesinin tahrik flanşına ve ön aks dişli kutusunun (VA şanzımanı) sağ ve sol güç çıkış tarafına monte edilmesi için malafa seti. Arka aks tekerlek rulmanının sökülmesi ve takılması için malafa seti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589081500 01/02/03', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(95, 'W470589121500 01 /02/03', 'Malafa seti', NULL, NULL, 'aktif', ' Tahrik ve durdurma taraflı dağıtıcı dişli kutusunda radyal mil keçesinin montajı için malafa seti. Arka aks tekerlek rulmanının sökülmesi ve takılması için malafa seti. ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589121500 01 /02/03', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(96, 'W904589036300', 'Bloke tertibatı', NULL, NULL, 'aktif', 'Kompresör çarkı için blokaj tertibatı, kompresör çarkı somununun çözülmesi ve sıkılması için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W904589036300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(97, 'W607589056300', 'Ana plaka', NULL, NULL, 'aktif', 'Volan tarafındaki radyal mil keçesinin krank miline takılması için ana plaka.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589056300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(99, 'W699589004000', 'Volan kilidi', NULL, NULL, 'aktif', 'Volan kilidi', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W699589004000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(100, 'w699589001500', 'krank mili sabitleme mandreni', NULL, NULL, 'aktif', 'krank mili sabitleme mandreni', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'w699589001500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(101, 'W210589004300', 'Çekme ve takma el aleti', NULL, NULL, 'aktif', 'Alt enine bağlantı kolu elastomer yatağı için çektirme ve takma aleti', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W210589004300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(102, 'W102589011400', 'Kovan', NULL, NULL, 'aktif', ' Radyal mil keçesinin bastırılıp takılması için kovan (tek ve iki kat makaralı zincir)', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W102589011400', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(103, 'W129589009100', 'Tıpa seti', NULL, NULL, 'aktif', 'Hidrolik elemanlarının ve hatlarının kapatılması için tıpa seti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W129589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(104, 'W450589001000', 'Lokma anahtarı', NULL, NULL, 'aktif', 'Silindir başı vidalarını sıkmak için lokma anahtarı', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W450589001000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(105, 'W256589002300', 'Sabitleme tertibatı', NULL, NULL, 'aktif', ' Eksantrik milinin temel konumunun ayarlanması için ve eksantrik mili ayarlayıcısının demontajında ve montajında kontralama yapmak için sabitleme tertibatı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W256589002300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(106, 'W254589002300', 'Sabitleme tertibatı', NULL, NULL, 'aktif', ' Eksantrik milinin temel konumunun ayarlanması için ve eksantrik mili ayarlayıcısının demontajında ve montajında kontralama yapmak için sabitleme tertibatı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W254589002300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(107, 'W211589061500', 'MALAFA', NULL, NULL, 'aktif', 'Koruyucu halkayı arka aks millerine çakmaya yarayan malafadır.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W211589061500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(108, 'W102589003300', 'Çektirme', NULL, NULL, 'aktif', 'Krank mili üzerindeki mesafe pulu için çektirme', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W102589003300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(109, 'W111589084300', 'Montaj aleti', NULL, NULL, 'aktif', 'Arka radyal mil keçesinin normal konuma bastırılması için montaj aleti ve çalıştırılmış krank milinde 3 nolu parça ile 3 mm lik içeri alınmış konumla.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W111589084300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(110, 'W220589023100', 'Germe balataları', NULL, NULL, 'aktif', 'Arka aks mili tutucu yanakları ∅ 34 mm, halka mafsalın takılmasında', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W220589023100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(111, 'W724589013300', 'Çektirme', NULL, NULL, 'aktif', 'Verici çarkı bastırarak yağ pompasından çıkarmaya yarayan çektirme aletidir', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W724589013300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(112, 'W177589000900', 'Lokma anahtarı elemanı', NULL, NULL, 'aktif', ' Kam mili ayarlayıcısı kumanda valfini çözmek ve vidalamak için delikli altıgen T100 lokma anahtar takımı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W177589000900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(113, 'W639589009100', 'Kontrol kapağı', NULL, NULL, 'aktif', 'W   124   589   24   21   00 basınç pompası ile bağlantılı olarak motor soğutma sisteminin sızdırmazlık kontrolü için dengeleme kabı kontrol bağlantısı. W   285   589   00   21   00 radyatör vakumlu dolum cihazıyla motor soğutma sisteminin dolumu için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W639589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(114, 'W163589019100', 'Kontrol kapağı', NULL, NULL, 'aktif', 'Soğutma tertibatını sızdırmazlık açısından kontrol etmek için soğutma maddesi genleşme kabı ile W   124   589   24   21   00 kontrol cihazı arasına takılan kontrol kapağı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W163589019100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(115, 'W210589009100', 'Kontrol kapağı', NULL, NULL, 'aktif', ' W   124   589   24   21   00 basınç pompası ve W   285   589   00   21   00 soğutucu vakumlu dolum cihazına ilişkin soğutma maddesi dengeleme kabı için vidalı kontrol kapağı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W210589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(116, 'W640589009100', 'ADAPTÖR', NULL, NULL, 'aktif', 'Turboşarj hava sisteminin sızdırmazlık kontrolü için adaptör.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W640589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(117, 'W210589036300', 'ADAPTÖR', NULL, NULL, 'aktif', 'Dişlilere sahip kapağın kontrol adaptörü.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W210589036300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(118, 'W607589039100', 'Bağlantı adaptörü', NULL, NULL, 'aktif', 'Hava emişinin sızdırmazlık kontrolü (hava yolunun arıza teşhisi) için bağlantı adaptörü', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W607589039100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(119, 'W651589029100', 'Adaptör', NULL, NULL, 'aktif', 'Sızdırmazlık kontrol cihazı W 611 589 02 21 00 ile bağlantılı olarak turboşarj havası sisteminin sızdırmazlık kontrolü için adaptör.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W651589029100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(120, 'W001589732100', 'El vakum pompası', NULL, NULL, 'aktif', 'Yan kanal pompasının, stator ve rotor gövdesinin sızdırmazlık kontrolü için el vakum pompası (0 ... 1000 mbar, bölünme 20 mbar)', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W001589732100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(121, 'HSD0000000004', 'FR BAĞLANTI KABLOSU', NULL, NULL, 'aktif', 'FR KABLOSU YENİ ARAÇ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'HSD0000000004', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(122, 'W102589014000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Şanzıman sökülü iken volanı bloke etmek için', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W102589014000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(123, 'W202589023300', 'Çektirme', NULL, NULL, 'aktif', 'Aks başındaki taşıyıcı mafsal için çektirme aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W202589023300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(124, 'W460589111500', 'Malafa', NULL, NULL, 'aktif', 'Dengelemenin zor hareket etme kontrolü ve sürtünme torku kontrolü için 1/2\" dört köşeli malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W460589111500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(125, 'W355589016300', 'Darbeli çektirme', NULL, NULL, 'aktif', 'Diferansiyel dişli grubu kilidi kavrama pistonunun, millerin, bağlantı parçalarının ve kapakların sökülmesi için darbeli çektirme.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W355589016300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(126, 'W906589026300', 'Çektirme el aleti', NULL, NULL, 'aktif', 'Koruyucu kovanının silindir kapağından çektirilmesi için W   355   589   01   63   00   darbeli çektirme ile birlikte kullanılan çektirme el aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W906589026300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(127, 'W254589001500', 'MİL', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W254589001500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(128, 'W169589009100', 'Kontrol kapağı', NULL, NULL, 'aktif', 'Soğutma sisteminin sızdırmazlık kontrolü için soğutma maddesi dengeleme kabı kontrol kapağı ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W169589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(129, 'W001589800900', 'Lokma anahtar elemanı', NULL, NULL, 'aktif', 'Lokma anahtar elemanı 8 mm, altı köşe, derin delinmiş, mafsalla ve uzatmayla sıkı sıkıya bağlıdır. Dört köşe tahrikli elemanı 3/8\"̋ ile. Çubuk kızdırma bujilerini takmak ve sökmek için', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W001589800900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(130, 'W203589031000', 'Valf anahtarı', NULL, NULL, 'aktif', ' Yüksek basınç ve düşük basınç servis valflerindeki valf elemanının takılması ve sökülmesi için valf anahtarı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W203589031000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(131, 'W001589790900', 'Lokma', NULL, NULL, 'aktif', 'Yakıt ve yağ sıcaklık sensörlerinin sökülmesi ve takılması için lokma anahtar takımı, ağız genişliği 22   mm çift altı köşeli, tahrik 1/2\" içten dört köşeli.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W001589790900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(132, 'W211589010300', 'Yıldız anahtar lokması', NULL, NULL, 'aktif', 'Arka aks dişli kutusu yatağını arkaya vidalamak için 14x18mm dört köşeli tak çıkar anahtarı bulunan E   18 yıldız anahtar takımıdır.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W211589010300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(133, 'W611589000300', 'Lokma anahtarı', NULL, NULL, 'aktif', 'Açık ağızlı lokma püskürtme boruları içindir.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W611589000300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(134, 'W470589269100', 'Kontrol bağlantısı', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589269100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(135, 'W639589019100', 'Kontrol kapağı', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W639589019100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(136, 'W124589009100', 'Kontrol bağlantısı', NULL, NULL, 'aktif', ' Soğutma maddesi dengeleme kabın 57 mm\'lik kontrol kapağı (bayonet sistemi) kontrol cihazı 124 589 24 21 00 ve doldurma cihazı ile bağlantılı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W124589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(137, 'W112589010300', 'Takma aleti', NULL, NULL, 'aktif', 'Altı köşe yıldız anahtar E18 ve dörtgen lokma 14X18 mm takma aleti, sol sabitleme cıvatasını kam mili dişlisinden çektirmek için W   001   589   66   21   00 tork anahtarına.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W112589010300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(138, 'W642589013300', 'Vidalı adaptör', NULL, NULL, 'aktif', 'Piezo enjektörlerin vurarak çıkarılması için dişli adaptörü. Hatırlatma : 602   589   00   33   00 darbeli çektirme ile bağlantılı olarak.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W642589013300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(139, 'W210589011600', 'Dört kenar tahrikli', NULL, NULL, 'aktif', ' Dört köşeli tahrik zincir gerdiricisinin sökülmesi ve ayrıca genel kullanılabilir dört köşeli tahrik 1/2\" 14 x 18 mm geçme bağlantıları için', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W210589011600', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(140, 'W272589009100', 'Dişli adaptörü', NULL, NULL, 'aktif', ' M10×1 dişli bağlantısına sahip dişli adaptörün iç kısmı M12×1,25 dış kısma, Bosch şirketinin basınç kaybı kontrol cihazı için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W272589009100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(141, 'W221589013300', 'Ayırma / Gevşetme el aleti', NULL, NULL, 'aktif', ' Şanzımandan ve şanzıman yağı radyatöründen yağ radyatörü hortumlarının çözülmesi için gevşetme aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W221589013300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(142, 'W904589006300', 'Vidalı ara parça', NULL, NULL, 'aktif', 'Meme tutucusu kombinasyonunu çektirmek için vidalı ara parça (M14x1,5 ve M8) W   355   589   01   63   00   darbeli çektirme ile birlikte.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W904589006300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(143, 'W102589053300', 'ÇEKTİRME', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W102589053300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(144, 'W124589033300', 'ÇEKTİRME', NULL, NULL, 'aktif', 'Rot kolu kürsel mafsalı için çektirme aletidir.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W124589033300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(145, 'W220589019920', 'RK 1,5 çıkartma elemanı olan kilit açıcısı', NULL, NULL, 'aktif', 'd = 1,5 mm yuvarlak kontakların kilidini açmak ve sökmek için ∅ 1,5 dışarı çıkartma elemanı olan kilit açma elemanı', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W220589019920', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(146, 'W111589015914', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W111589015914', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(147, 'W636589020300', 'Bilgi yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W636589020300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(148, 'W211589000900', 'Lokma anahtarı elemanı', NULL, NULL, 'aktif', 'Havalı süspansiyonun hat bağlantısının sıkılması ve çözülmesi için lokma anahtar elemanı 10mm (yarıklı).', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W211589000900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(149, 'W111589015910', 'MİL', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W111589015910', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(150, 'W140589003300', 'ÇEKTİRME', NULL, NULL, 'aktif', 'Aks zincirindeki üst enine bağlantı kolunun kılavuz mafsalı için çektirme aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W140589003300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(151, 'W668589003400', 'Sıkma pensesi', NULL, NULL, 'aktif', ' Enjektör için gerdirme pensesi.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W668589003400', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(152, 'W206589002100', 'ADAPTÖR', NULL, NULL, 'aktif', ' Üreticiye özel silecek kolu bağlantısına sahip silecek kolların konumlandırılma açısının kontrol edilmesine ve ayarlanmasına yarayan adaptör.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W206589002100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(153, 'W282589004300', 'Montaj aleti', NULL, NULL, 'aktif', 'Enjektörde conta halkasının açılması ve kalibrasyonu için montaj el aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W282589004300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(154, 'W282589002100', 'Kontrol adaptörü', NULL, NULL, 'aktif', ' Üst ölü noktasının (OT) belirlenmesi için kontrol adaptörü.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W282589002100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(155, 'W254589003300', 'Çektirme aleti', NULL, NULL, 'aktif', 'Kombine pompasının silindir bloğundan çekip çıkarmak için dışarı çektirme aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W254589003300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(156, 'W654589003100', 'Montaj plakası', NULL, NULL, 'aktif', ' Eksantrik mili dişlisini sökerken ve takarken gerdirme dişlisinin çevrilmesi ve sabitleme pimleri ile emniyete almak için montaj plakası. ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589003100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(157, 'W282589004000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Merkezi cıvatanın çözülmesinde veya sıkılmasında krank milinin kontralanması için tutma kilidi.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W282589004000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(158, 'W700589131500', 'MİL', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589131500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(159, 'W715589221500', 'MALAFA', NULL, NULL, 'aktif', 'Yüksek voltajlı akünün takılması için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W715589221500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(160, 'W654589024300', 'Montaj aleti', NULL, NULL, 'aktif', 'Motor bloğunda yatak kapağının montajı için montaj el aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589024300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(161, 'W700589151500', 'DRIFT', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589151500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(162, 'W725589034000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Silindir flanşının cıvatalarını çözmek için karşı tutucusu (merkezleme adaptörü). ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W725589034000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(163, 'W129589009112', 'Kapama tapası', NULL, NULL, 'aktif', ' Otomatik şanzımandaki ve yağ soğutucusundaki yağ hatlarının kapatılması için kapatma tapaları.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W129589009112', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(164, 'W254589003900', 'Uyarlama', NULL, NULL, 'aktif', 'Takılı durumdaki eksantrik zincirini ayırmaya ve perçinlemeye yönelik adaptasyon. ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W254589003900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(165, 'W907589021500', 'MALAFA', NULL, NULL, 'aktif', 'Dağıtıcı dişli kutusunun tahrik flanşındaki radyal mil keçesinin arka aksa tahrik edilmesi için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W907589021500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(166, 'W000589513100', 'ADAPTÖR', NULL, NULL, 'aktif', 'Motor kaputunun desteklenmesi için adaptör.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589513100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(167, 'W656589001500', 'MALAFA', NULL, NULL, 'aktif', 'Egzoz turboşarjın ve egzoz turboşarjın döküm korumasının birbirine ortada hizalanması için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W656589001500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(168, 'W654589034000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Titreşim azaltıcısındaki cıvataları gevşetmek ve sıkmak için karşı tutucu. Krank milinin çevirilmesi ve tutulması için karşı tutucu', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589034000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(169, 'W254589006300', 'Çatal parça', NULL, NULL, 'aktif', 'Dengeleme millerini dengeleme mili gövdesine sabitlemek için çatal parçası ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W254589006300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(170, 'W907589000900', 'Lokma anahtarı', NULL, NULL, 'aktif', 'Süspansiyon ünitesi başlığındaki süspansiyon ünitesi somununun kumanda edilmesi için lokma anahtar.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W907589000900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(171, 'W651589146300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W651589146300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(172, 'W177589033200', 'Amortisör çektirmesi', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W177589033200', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(174, 'W724589010900', 'Lokma anahtarı', NULL, NULL, 'aktif', 'Yağ karteri tapasını açıp kapatmak için lokma anahtarı Teknik açıklama: Tekli parça W 725 589 02 90 01 lokma anahtar için yedek parça W 725 589 02 90 00 montaj aletinden.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W724589010900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(175, 'W608589014000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Takılı şanzımanda volan dişlisinin kilitlenmesi için tutma kilidi.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W608589014000', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(176, 'W000589403700', 'Kıskaç', NULL, NULL, 'aktif', '∅ 20   mm\'ye kadar olan hortumların ve hortum hatlarının ayrılması için kıskaç.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589403700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(177, 'W654589004300', 'Takma tertibatı', NULL, NULL, 'aktif', ' Ön radyal mil keçesinin takılması için takma tertibatı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W654589004300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(178, 'W211589003100', 'Fren pedallı kriko için adaptör', NULL, NULL, 'aktif', 'Fren pedallı kriko için adaptör.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W211589003100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(179, 'W454589000300', 'Açık ağızlı yıldız anahtar', NULL, NULL, 'aktif', '18   mm\'lik anahtar boyutlu yıldız anahtar lokması püskürtme hatlarının cıvata bağlantısı için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W454589000300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(180, 'W254589013300', 'Çektirme aleti', NULL, NULL, 'aktif', 'Enjekörleri çekip çıkartmak için dışarı çektirme aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W254589013300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(181, 'W000589956300', 'Sökme aleti', NULL, NULL, 'aktif', 'Plastik klipslerin sökülmesi için demontaj aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589956300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(182, 'W000589543700', 'Uç', NULL, NULL, 'aktif', '30   mm\'ye kadar olan hortum hatları için kelepçedir. ', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589543700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(183, 'W447589013100', 'Adaptör seti', NULL, NULL, 'aktif', ' Lift platformu ve araç iskeleti arasında yeterli yerin sağlanması için adaptör seti. Taban altı kaplamasının veya indirgeme maddesi kabı püskürtme korumasının veya park kaloriferi püskürtme korumasının sökülmesi ve takılması esnasında kullanım.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W447589013100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL);
INSERT INTO `aletler` (`id`, `seri_no`, `adi`, `marka`, `model`, `durum`, `aciklama`, `olusturma_tarihi`, `guncelleme_tarihi`, `created_at`, `barkod`, `kategori`, `raf_no`, `silindi`, `raf_id`, `eklenme_tarihi`, `zimmetli_personel_id`) VALUES
(184, 'W724589020900', 'Lokma anahtarı', NULL, NULL, 'aktif', ' Şanzıman yağı seviyesinin kontrolü ve düzeltmesi için lokma anahtarı.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W724589020900', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(185, 'W000589770300', 'Yıldız anahtar lokması', NULL, NULL, 'aktif', '14   mm, 1/4” 4-köşe tahrikli açık ağızlı yıldız lokma anahtar elemanı. Fren hatlarının, fren hortumlarının ayrıca hidrolik hatların (örn.   SBC hidrolik ünitesinin) sökülmesi, takılması için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589770300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(186, 'W000589513700', 'PENSE', NULL, NULL, 'aktif', 'Piston segmanlarının ayrılması için pense', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W000589513700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(187, 'W454589003700', 'Hortum kıskacı pensesi', NULL, NULL, 'aktif', 'Kendiliğinden sıkışan hortum kıskaçlarının ayrılması ve tespit edilmesi için hortum kıskacı pensesi.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W454589003700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(188, 'W606589003700', 'Pense', NULL, NULL, 'aktif', ' Manyetik valfleri çekerek vites değiştirme plakasından çıkarmaya yarayan pensedi', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W606589003700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(189, 'W470589020700', 'Kanallı somun anahtarı', NULL, NULL, 'aktif', 'Tahrik milindeki kanallı somunu sökmeye yarayan kanallı somun anahtarıdır.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589020700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(190, 'W470589093300', 'Çektirme', NULL, NULL, 'aktif', 'Arka aksın sökülü tahrik millerinden (yan miller) tekerlek rulmanlarını çektirerek çıkarmak için dışarı çektirme aleti.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W470589093300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(191, 'W471589021500', 'MALAFA', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W471589021500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(192, 'W700589181500', 'MALAFA', NULL, NULL, 'aktif', 'Tip 910: Radyal mil keçesinin şanzımanın tahrik miline çakılarak takılması için malafa. Tip 907 Motor 780.6 ile: Arka aks tahriki modülünün radyal mil keçelerinin takılması için malafa.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W700589181500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(193, 'W116589001500', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W116589001500', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(194, 'W450589000700', 'Depo modülü el aleti', NULL, NULL, 'aktif', ' Depo modülündeki rakor somununun takılması ve sökülmesi için.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W450589000700', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(195, 'W203589033100', 'Tutucu', NULL, NULL, 'aktif', 'Kremayerli direksiyonda kremayer boşluğunu ölçmeye yarayan komparatör tutucusudur', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W203589033100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(196, 'W210589072100', 'Tutucu', NULL, NULL, 'aktif', 'Kremayerli direksiyonda kremayer boşluğunu ölçmeye yarayan komparatör tutucusudur', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W210589072100', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(197, 'W724589003300', 'ÇEKTİRME', NULL, NULL, 'aktif', ' 4-Delikli yağ pompası dişlisinin yağ pompasından çekip çıkarılması ve kontralanması için çektirme', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W724589003300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(198, 'W904589056300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W904589056300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(199, 'W730589023300', 'Çektirme', NULL, NULL, 'aktif', 'Taşıyıcı mafsalı aks başından çekerek çıkartın.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W730589023300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(200, 'W230589003300', 'Çektirme', NULL, NULL, 'aktif', 'Yay bağlantı kolu için çektirme aletidir. Teknik hatırlatma: Sadece W   140   589   00   63   00 basınç aktarım parçası ile birlikte kullanılmalıdır.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W230589003300', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(201, 'W202589044307', 'Plaka', NULL, NULL, 'aktif', 'Plaka, W 202 589 04 43 00 için yedek parça çektirme el aleti. Tip 205, 213, 238, 253, 257, 290 olduğunda çekme desteği elastomer yatağının dışarı preslenmesinde altına yerleştirilecek plaka.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W202589044307', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(202, 'W202589044306', 'Plaka', NULL, NULL, 'aktif', 'Ön aks tekerlek rulmanının dışarı preslenmesi için plaka', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W202589044306', NULL, NULL, 0, NULL, '2025-01-14 22:36:20', NULL),
(203, 'W222589056300', 'Kontrol adaptörü', NULL, NULL, 'aktif', 'Gerilimsizlik kontrolü için manüel serbest bırakma işlemi.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W222589056300', NULL, NULL, 0, NULL, '2024-09-04 00:00:00', NULL),
(204, 'W222589066300', 'Kontrol adaptörü', NULL, NULL, 'aktif', 'Manuel onay süreci sırasındaki gerilimsizliğin tespit edilebilmesi için kontrol adaptörü. Kullanım amacı Tip 222: Taşıyıcı plakadaki gerilimsizliğin kontrolü için kontrol adaptörü.', '2025-01-14 22:36:20', '2025-07-02 14:17:26', '2025-01-14 22:36:20', 'W222589066300', NULL, NULL, 0, NULL, '2024-09-04 00:00:00', NULL),
(397, 'W711589053100', 'Yerleştirme tertibatı', NULL, NULL, 'aktif', 'Şanzımanda ara parçayı vidalarken bilya yatağını konumlandırmak için. Ana ve grup mili arasında bağlantı parçasının sabitlenmes', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W711589053100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(399, 'W230589003402', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W230589003402', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(400, 'W611589001400', 'Takma el aleti', NULL, NULL, 'aktif', ' Ön radyal mil keçesi için içeri çekme tertibatı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589001400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(401, 'W906589036300', 'Montaj aleti', NULL, NULL, 'aktif', 'Isıdan koruma kovanının enjektörün üzerine bastırılarak geçirilmesi için montaj el aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W906589036300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(403, 'W271589009100', 'Bağlantı parçası', NULL, NULL, 'aktif', 'Sızdırmazlık kontrol cihazı W611 589 02 21 00 ile bağlantılı kullanım için bağlantı parçası', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W271589009100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(404, 'W129589000900', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W129589000900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(405, 'W117589032300', 'Malafa', NULL, NULL, 'aktif', 'Ventil kılavuzunun kontrolü için malafa 9   mm. Kontrol cihazı ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W117589032300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(406, 'W906589036301', 'Kovan', NULL, NULL, 'aktif', ' Isı koruyucu kovanların enjeksiyon memesi üzerine bastırılması için olan W   906   589   00   63   00   monatj aleti ile bağlantılı kovan', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W906589036301', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(407, 'W352589002100', 'Bağlantı parçası', NULL, NULL, 'aktif', 'Enjektör delikleri üzerinden kompresyon basıncı kontrolü için bağlantı parçası', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W352589002100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(408, 'W611589006300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589006300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(409, 'W611589056300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589056300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(410, 'W611589014000', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589014000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(411, 'W663589013400', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W663589013400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(412, 'W140589103300', 'Mesafe Parçası', NULL, NULL, 'aktif', 'W   140   589   06   63   00 kontaklama kutusunda kumanda kutularının kontaklarını W   140   589   01   33   00 montaj levyesi ile ayırmak için aralık parçası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W140589103300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(413, 'W273589009100', 'Adaptör', NULL, NULL, 'aktif', ' Turboşarj hava sisteminin sızdırmazlık kontrolü için adaptör.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W273589009100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(414, 'W639589004000', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W639589004000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(415, 'W169589003700', 'PENSE', NULL, NULL, 'aktif', '12-V-Prizlerin veya çakmakların sökülmesi için pense.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W169589003700', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(416, 'W642589019100', 'Adaptör', NULL, NULL, 'aktif', ' Turboşarj hava sisteminin sızdırmazlık kontrolü için adaptör.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W642589019100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(417, 'W654589009100', 'Adaptör', NULL, NULL, 'aktif', ' Turboşarj hava sisteminin sızdırmazlık kontrolü için adaptör', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W654589009100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(418, 'W611589023300', 'Çektirme aleti', NULL, NULL, 'aktif', 'Sıkışan enjektörleri çözmek için çekip çıkartma aleti (temel cihaz)', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589023300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(419, 'W211589006300', 'Gevşetme el aleti', NULL, NULL, 'aktif', 'Klima hatlarının sökülmesi için sökme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W211589006300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(420, 'W639589000900', 'Lokma anahtarı', NULL, NULL, 'aktif', 'Öndeki süspansiyon ünitesinin cıvatalarını çözmek ve sıkmak için lokma anahtarı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W639589000900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(421, 'W000589584300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W000589584300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(422, 'W202589044301', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W202589044301', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(423, 'W271589014000', 'Tutma tertibatı', NULL, NULL, 'aktif', ' Kumanda zincirini içeri çekmek için tutma tertibatı. Kam mili dişlileri olan kumanda zincirini girişte tutar.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W271589014000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(424, 'W202589044302', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W202589044302', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(425, 'W715589056300', 'Adaptör', NULL, NULL, 'aktif', 'Darbeli çektirme 715   589   04   63   00 ile bağlantılı olarak valf elemanını sökmek için adaptör', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589056300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(426, 'W001589692100', 'Ölçme cihazı', NULL, NULL, 'aktif', ' V-kayışı gerginliği için ölçüm cihazı (krikit).', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W001589692100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(427, 'W950589001500', 'Malafa', NULL, NULL, 'aktif', 'Süspansiyon elemanının fren hattı geçme bağlantısını monte etmek için', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W950589001500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(428, 'W000589021000', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W000589021000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(429, 'W613589003300', 'Çektirme', NULL, NULL, 'aktif', ' Titreşim sönümleyici için çektirme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W613589003300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(430, 'W638589033300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W638589033300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(431, 'W124589023400', 'Baskı parçası', NULL, NULL, 'aktif', 'Diferansiyel dişli kutusunun yatağının çekilmesi için basınç aktarım parçası. Dağıtıcı dişli kutusunun yatağının çekilmesi için basınç aktarım parçası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W124589023400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(432, 'W442589056300', 'Yağ tablası bastırıcısı', NULL, NULL, 'aktif', 'Motor frenindeki valf yayını sökmek ve takmak için yay tablası bastırıcısı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W442589056300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(433, 'W901589003100', 'Yay gerdirici', NULL, NULL, 'aktif', 'Debriyaj pedalı ölü nokta yayının ön gerdirme işlemi', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W901589003100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(434, 'W201589013300', 'Çektirme', NULL, NULL, 'aktif', 'Bağlantı rotu (uzun rot) ve direksiyon çekme kolu (kısa rot) küresel mafsalları için çektirme. ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W201589013300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(435, 'W601589043300', 'Çektirme', NULL, NULL, 'aktif', 'Bağlantı rotu (uzun rot) ve direksiyon çekme kolu (kısa rot) küresel mafsalları için çektirme.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W601589043300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(436, 'W601589024000', 'Tutma kilidi', NULL, NULL, 'aktif', 'Başlatma dişli çemberi taşıyıcısındaki krank mili için durdurma kilidi. ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W601589024000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(437, 'W711589006300', 'Senkronize bilezik tutucusu', NULL, NULL, 'aktif', ' Ana mil için senkron tutucuyu monte et.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W711589006300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(438, 'W447589006200', 'Tutma tertibatı', NULL, NULL, 'aktif', 'Motorun alttan sabitlenmesi için tutma tertibatı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W447589006200', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(439, 'W140589114300', 'Çektirerek sökme ve takma el aleti', NULL, NULL, 'aktif', 'Lastik yatak için çektirme ve takma el aleti - alt enine bugi kolu.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W140589114300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(440, 'W129589034305', 'Kovan', NULL, NULL, 'aktif', 'Arka aks yay bağlantı kolu için iç elastomer yatağını içeri bastırmaya yarayan kovandır', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W129589034305', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(441, 'W212589004300', 'Çektirerek sökme ve takma el aleti', NULL, NULL, 'aktif', 'Çekici kol yataklarını çekmek ve içeri itmek için', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W212589004300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(442, 'W220589064300', 'Presleyerek sökme ve takma aleti', NULL, NULL, 'aktif', ' TİP 171, 172, 203, 204, 205, 206, 207, 209, 211, 213, 214, 215, 216, 219, 220, 221, 222, 223, 230, 231, 236, 238, 253, 254, 257, 295, 296, 297 Enine bağlantı kolu, çekme çubuğu ve süspansiyon bağlantı kolunun elastomer yatağının dışarı- ve içeri preslenmesi için presleyerek sökme ve takma aleti. Tip 164, 166, 169, 245, 251 Ön akstan ve arka akstan tekerlek rulmanın dışarı ve içeri preslenmesi için dışarı presleme ve içeri presleme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W220589064300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(443, 'W730589004300', 'İçeri ve dışarı presleme aleti', NULL, NULL, 'aktif', 'Tekerlek taşıyıcısında tekerlek poyrası ve tekerlek yatağı için içeri ve dışarı presleme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W730589004300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(444, 'W230589003400', 'Çektirme, takma el aleti tamamlama seti', NULL, NULL, 'aktif', ' Tip 211, 219 ve 230\'da: Arka aks dişli kutusundaki elastomer yatağının dışarı ve içeri çekilmesine yarayan dışarı ve içeri çekme tertibatı tamamlayıcı setidir. Tip 169 ve 245\'te: Ön aks tekerlek rulmanının dışarı ve içeri çekilmesine yarayan dışarı ve içeri çekme tertibatı tamamlayıcı setidir. ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W230589003400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(445, 'W203589004300', 'Çektirerek sökme ve takma el aleti', NULL, NULL, 'aktif', 'Arka aks taşıyıcısındaki ön ve arka lastik yataklar için çektirerek sökme ve takma aleti', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W203589004300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(446, 'adblue ÇANTA', 'ADBLUE ölçüm kabı', NULL, NULL, 'aktif', 'Adblue ölçüm kabı çantası', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'adblue ÇANTA', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(447, 'Motometer Çanta', 'Motometer', NULL, NULL, 'aktif', 'MOTOMETER', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'Motometer Çanta', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(448, 'Klima Gaz Kaçağı Çanta', 'Klima Gaz Kaçağı', NULL, NULL, 'aktif', 'Klima Gaz Kaçağı', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'Klima Gaz Kaçağı Çanta', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(449, 'Mitutoyo Bore Gage Çanta', 'İç çap ölçüm cihazları', NULL, NULL, 'aktif', 'İç çap ölçüm cihazları', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'Mitutoyo Bore Gage Çanta', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(450, 'W124589062100', 'Kontrol cihazı çanta', NULL, NULL, 'aktif', ' Direksiyon basınç ölçme saati (Otobüs)', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W124589062100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(451, 'W457589013300', 'Keçe çakacağı', NULL, NULL, 'aktif', 'Radyal mil keçesinin sökülmesi için veya ön krank milindeki kaset conta halkalarının sökülmesi ve takılması için çektirme tertibatı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W457589013300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(452, 'W470589056100', 'supap alet çantası', NULL, NULL, 'aktif', 'Valf yayının takılması ve sökülmesi için, valf sapı contasının takılması için çektirme aleti ve malafa dahil.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589056100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(453, 'W470589053300', 'sökme ve takma el aleti ÇANTASI', NULL, NULL, 'aktif', 'Silindir gömleğinin takılması ve sökülmesi için ve kovan taşmalarının ölçülmesi için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589053300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(454, 'W203589016302', 'Germe plakası', NULL, NULL, 'aktif', ' Ön aks makasının sökülmesi ve takılması için sabitleme plakası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W203589016302', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(455, 'W168589026300', 'Germe plakası', NULL, NULL, 'aktif', 'Gerdirme cihazı 210   589   00   31   00 ve gerdirme cihazı 203   589   01   31   00 için gerdirme plakası (2 adet)', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W168589026300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(456, 'W639589006300', 'Germe plakası', NULL, NULL, 'aktif', 'Germe plakaları (2 adet) germe cihazı ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W639589006300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(457, 'W204589006300 01 02 03', 'Germe plakası', NULL, NULL, 'aktif', 'Ön aks süspansiyon ünitelerin baş yatağı altlığı için tespit plakası', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W204589006300 01 02 03', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(458, 'W212589006300', 'Adaptör plakası', NULL, NULL, 'aktif', ' Ön aks yaylarını gerdirmek için adaptör plakası', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W212589006300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(459, 'W203589016301', 'Germe plakaları', NULL, NULL, 'aktif', 'Ön akstaki yay bacağı için germe cihazı 203 589 01 31 00 ile bağlantılı germe plakaları (2 adet)', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W203589016301', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(460, 'W211589016300', 'Germe plakası', NULL, NULL, 'aktif', 'Ön aksta süspansiyon ünitesi için germe cihazına 203   589   01   31   00 germe plakası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W211589016300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(461, 'W169589026300', 'Germe plakaları', NULL, NULL, 'aktif', ' Arka aks yaylarının takılması-/sökülmesi için germe plakaları.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W169589026300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(462, 'W230589116300', 'Germe plakası', NULL, NULL, 'aktif', 'Ön ve arka akstaki süspansiyon ünitesinin yaylarının gerilmesi için gerdirme plakası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W230589116300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(463, 'HAZET 4900-35', 'Amortisör çektirmesi', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'HAZET 4900-35', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(464, 'W164589016301 02', 'Germe plakaları', NULL, NULL, 'aktif', ' Arka yaylar için 202   589   02   31   00 gerdirme cihazına ait germe plakaları (2 adet).', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W164589016301 02', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(465, 'W211589036301 02', 'Germe plakaları', NULL, NULL, 'aktif', 'Germe plakaları Ø   120   mm (2 adet) arka aks yaylarına ilişkin germe cihazı ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W211589036301 02', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(466, 'W202589136301 02', 'Germe plakaları', NULL, NULL, 'aktif', ' Gerdirme plakaları Ø 120 mm (2 adet) şunlarla ilgilidir: W 202 589 01 31 00 gerdirme cihazı ön aks süspansiyon yayı için Tip 116, 123, 124, 129, 170, 201, 202, 208, 210\'de (210.08/28 hariç) ve arka aks süspansiyon yayları için Tip 220\'de Code 979 ile, Tip 221, 222 Code Z07. ile. Şunlarla ilgili: W 202 589 02 31 00 Gerdirme cihazı arka aks süspansiyon yayları için', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W202589136301 02', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(467, 'W202589146301 02', 'Germe plakaları', NULL, NULL, 'aktif', 'Ön aks makası için W 202 589 01 31 00 gerdirme cihazına ve arka aks makası için W 202 589 02 31 00 gerdirme cihazına gerdirme plakaları ∅ 140   mm (2 adet). Teknik hatırlatma: Ön aks makası için W 202 589 01 31 00 gerdirme cihazı - tip 126, 140. Arka aks makası için W 202 589 02 31 00 gerdirme cihazı - tip 107, 114, 116, 123, 126, 140.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W202589146301 02', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(468, 'W639589022300', 'Süspansiyon seviyesini belirlemek için referans,', NULL, NULL, 'aktif', 'Süspansiyon seviyesini belirlemek için referans,', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W639589022300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(469, 'W001589762100', 'Kompresyon basıncı kayıt cihazı', NULL, NULL, 'aktif', 'Otto motorlar için 3,5...17,5 bar ve dizel motorlar için 10...40 bar komple kompresyon basıncı yazıcısı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W001589762100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(470, 'W177589003100', 'Germe aleti', NULL, NULL, 'aktif', 'Aks mafsalının sökülmesi için gerdirme el aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W177589003100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(471, 'W611589042100', 'Yakıt fazlası-kontrol cihazı 2 ÇANTA', NULL, NULL, 'aktif', ' Enjektörlerin yakıt fazlası miktarını ölçmek için yakıt fazlası kontrol cihazı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589042100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(472, 'W256589013300', 'Çektirme ÇANTA', NULL, NULL, 'aktif', ' Yağ pompası birimini çekmek ve yağ pompasındaki veya yakıt yüksek basınç pompasındaki zincir dişlisini kontralamak için çektirme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W256589013300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(474, 'W001589902100', 'Kayış Ölçüm cihazı ÇANTA', NULL, NULL, 'aktif', 'Kayış Ölçüm cihazı ÇANTA', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W001589902100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(475, 'W646589012100', 'Kontrol cihazı', NULL, NULL, 'aktif', 'Yakıt düşük basınç devridaim hattını kontrol etmek için kontrol cihazı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W646589012100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(476, 'W001589832100', 'RADYATÖR BAS. KONT CHZ.', NULL, NULL, 'aktif', 'Soğutma sistemi ve radyatör bağlantısı için çantalı kontrol cihazı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W001589832100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(477, 'W211589022100', 'Ayar el aleti seti', NULL, NULL, 'aktif', 'Silecek kollarının ön ve arka cama dayanma açısının kontrolü ve ayarı için ayarlama el aleti ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W211589022100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(478, 'W654589003300', 'Perçin presleme aleti', NULL, NULL, 'aktif', ' Kumanda zincirinin yenilenmesi için baskı ve kılavuz parçalı perçin presleme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W654589003300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(479, 'W000589002100', 'Kontrol kutusu', NULL, NULL, 'aktif', 'Elektrik sistemlerinin tipe özgü adaptör kablo demetlerine kontaklanması için 189 kutuplu kontrol kutusu (soket kutusu).', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W000589002100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(480, 'W201589009900', 'Elektro bağlantı seti', NULL, NULL, 'aktif', 'KABLO SETİ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W201589009900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(481, 'W220589009900', 'Elektro bağlantı seti', NULL, NULL, 'hasarli', 'KABLO SETİ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W220589009900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(482, 'HAZET 4812-10/4S', ' Hazet Çift Kameralı Video Endoskop Seti ', NULL, NULL, 'aktif', ' Hazet Çift Kameralı Video Endoskop Seti ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'HAZET 4812-10/4S', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(483, 'W611589022100', 'Sızdırmazlık kontrol cihazı', NULL, NULL, 'aktif', 'Sızdırmazlığın kontrol edilmesi ve turboşarj havası sisteminin emiş tarafında kaçak araması. ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589022100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(484, 'W451589004000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Su pompasının kayış kasnağını sabit tutmak için karşı tutucu.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W451589004000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(485, 'W651589054000', 'Karşı tutucu', NULL, NULL, 'aktif', '', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W651589054000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(486, 'W651589064000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Viskoz fan kavramasının takılmasında ve sökülmesinde soğutma maddesi pompasının kayış kasnağından kontra yapılması için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W651589064000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(487, 'W906589004000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Fan kayış kasnağı veya soğutma maddesi pompasının kontra tutulması için', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W906589004000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(488, 'W611589004000', 'Karşı tutucu', NULL, NULL, 'aktif', 'Viskoz fan kavramasının takılması, sökülmesi sırasında soğutma maddesi pompası kayış kasnağı için karşı tutucu.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589004000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(489, 'W651589006100', 'Takma el aleti', NULL, NULL, 'aktif', 'Krank mili ön radyal keçesi için çektirme el aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W651589006100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(490, 'W651589016100', 'Takma el aleti', NULL, NULL, 'aktif', 'Radyal mil keçesi arka krank milinin monte edilmesi için çekme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W651589016100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(491, 'W602589023300', 'Zincir ayırma aleti', NULL, NULL, 'aktif', 'Yenilemede kumanda zincirin ayrılması için zincir ayırma aleti', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W602589023300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(492, 'W642589003300', 'Zincir ayırma aleti', NULL, NULL, 'aktif', '', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W642589003300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(495, 'W312589075300', 'ÇOLAK ÇEKTİRME', NULL, NULL, 'aktif', 'ÇOLAK ÇEKTİRME', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W312589075300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(496, 'W655589003533', 'ÇEKTİRME', NULL, NULL, 'aktif', 'ÇEKTİRME', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W655589003533', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(497, 'W447589011500', 'Malafa', NULL, NULL, 'aktif', 'Ön krank mili üzerindeki çalışma halkası için malafa.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W447589011500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(498, 'YEŞİL KAPAK', 'YEŞİL KAPAK', NULL, NULL, 'aktif', '2 ADET', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'YEŞİL KAPAK', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(499, 'W400589049100', 'Su kaçağı bulma aparatı', NULL, NULL, 'aktif', 'Su kaçağı bulma aparatı', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W400589049100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(500, 'W950589006100', 'Merkezleme malafası', NULL, NULL, 'aktif', 'Ø 430 mm\'li debriyaj diskinin merkezlenmesinde kullanılan Ø 44 ve kılavuz yatak için Ø 25 mm çaplı merkezleme malafalar', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W950589006100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(501, 'W906589006100', 'Merkezleme malafası', NULL, NULL, 'aktif', 'Debriyaj diski için 36 mm çaplı debriyaj diskinin ve kılavuz yatak için 25 mm çaplı debriyaj diskinin montajı için merkezleme malafası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W906589006100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(502, 'W766589006300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W766589006300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(503, 'W602589001500', 'Malafa', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W602589001500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(504, 'W541589013400', 'Mesafe pulu', NULL, NULL, 'aktif', 'Ön radyal mil keçesinin montajı için. Hatırlatma: Çektirme tertibat 541 589 02 33 00 ile bağlantılı olarak.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W541589013400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(505, 'W541589003400', 'Mesafe pulu', NULL, NULL, 'aktif', ' Ön radyal keçelerinin sökülmesine yarar. Hatırlatma: 541 589 02 33 00 sökme ve takma el aleti ile birlikte.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W541589003400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(507, 'W111589030900', 'NOX SENSÖRÜ REKOR', NULL, NULL, 'aktif', ' Altıköşe lokma, açık (ağız genişliği 22   mm) ½\"-dört köşe tahrik ile, lambda sondasının takılması ve sökülmesi için. Aynı şekilde egzoz gazını sonradan işleme ünitesindeki NOx sensörlerin takılması ve sökülmesi için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W111589030900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(508, 'W001589000300', '10MM YILDIZ LOKMA', NULL, NULL, 'aktif', '12x9 mm dört köşe lokma ile birlikte 10 mm açık yıldız anahtar lokması', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W001589000300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(509, 'W403589026300', 'Malafa', NULL, NULL, 'aktif', 'Malafa (M16x1,5), volanın veya titreşim amortisörün çıkarılıp alınmasında ve yerleştirilmesinde kılavuz olarak kullanılır. Diğer kullanımı: Krank milinin sökülmesi ve takılması için tespit yardımcısı olarak kullanılır.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W403589026300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(510, 'W904589026300', 'Merkezleme malafası', NULL, NULL, 'aktif', 'Volanı çıkarmak ve yerine oturtmak için merkezleme malafası ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W904589026300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(511, 'W936589021505', 'Kılavuz zımbası', NULL, NULL, 'aktif', 'Volanı krank milinin üzerine yerleştirmek için. 2 ADET', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589021505', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(512, 'W400589009100', 'Adaptör', NULL, NULL, 'aktif', ' Direksiyonun hidrolik basıncını belirlemek için adaptör. Hatırlatma: Sadece 437 589 00 21 00 manometre ve 400 589 01 91 00 hortum ile bağlantılı olarak.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W400589009100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(513, 'W400589071500', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W400589071500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(514, 'W715589143300', 'Çekip çıkarma cıvataları', NULL, NULL, 'aktif', 'Alan grubunu sökmek için çektirme cıvataları.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589143300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(515, 'W963589086300', 'EL freni kilit açma aparatı', NULL, NULL, 'aktif', 'Gösterge tablosunda elektronik el freninin kumanda kolunun sökülmesi için kilit açma aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W963589086300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(516, 'W936589029100', 'sızdırmazlık kontrol cihazı', NULL, NULL, 'aktif', 'Egzoz gazı geri gönderme soğutucusunun sızdırmazlık kontrolü için sızdırmazlık kontrol cihazı. ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589029100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(517, 'W000589219900', 'Far Temizlik seti', NULL, NULL, 'aktif', 'Far camlarının içten temizlenmesi için temizlik seti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W000589219900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(518, 'W001589007100', 'POMPA', NULL, NULL, 'aktif', 'Bakım çalışmalarında AdBlue® pompa modülü hidrolik akümülatör balonunun doldurulması ve basınç kontrolü için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W001589007100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(519, 'W442589003300', 'ÇEKTİRME', NULL, NULL, 'aktif', 'Ön krank milindeki çalışma halkasını çektirerek çıkarmak için çektirme aleti. Çalışma halkası 403 031 07 27 flanşlı eski model için de kullanılabilir.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W442589003300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(520, 'W964589003300', 'ÇEKTİRME ÇANI', NULL, NULL, 'aktif', 'Direksiyon kutusu kumanda parmağını direksiyon dişli kutusundan çekip çıkarmak için çektirme çanı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W964589003300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(521, 'W715589073100', 'Tutma tertibatı', NULL, NULL, 'aktif', ' Vites çatalını split grubuna sabitlemek için', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589073100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(522, 'W963589016300', 'KİLİT ÇÖZÜCÜ', NULL, NULL, 'aktif', ' Basınçlı hava hortumundaki soket bağlantısını kompresör ve basınçlı hava hattı arasından ayırmak için', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W963589016300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(523, 'W000589183100', 'Fren pedallı kriko', NULL, NULL, 'aktif', 'Fren pedalı kaldıracı', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W000589183100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(524, 'W936589053300', 'ÇEKTİRME', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589053300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(525, 'W715589081500', 'Malafa', NULL, NULL, 'aktif', 'Radyal mil keçesinin güç çıkış tarafına çakılması için malafa W715589061500', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589081500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(526, 'W936589011500', 'Malafa', NULL, NULL, 'aktif', 'Pilot yatağın emniyet segmanıyla birlikte volana çakılması için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589011500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(527, 'W906589004300', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W906589004300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(528, 'W604589001500', 'ÇAKMA MALAFA', NULL, NULL, 'aktif', 'Silindir krank gövdesindeki yağ püskürtme memesini hizalama kenarlı çakma zımbası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W604589001500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(529, 'W611589001500', 'ÇAKMA MALAFA', NULL, NULL, 'aktif', 'Krank muhafazasındaki yağ püskürtme çıkışı için hizalama dayanaklı çakma malafası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589001500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(530, 'W715589246300', 'Tutma tertibatı', NULL, NULL, 'aktif', 'Enine vites değiştirme tertibatı sökülü iken vites boş konumundayken vites değiştirme kızaklarını tutmak için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589246300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(531, 'W715589030700', 'Muylu anahtarı', NULL, NULL, 'aktif', 'Split grubu pistonlarının sökülmesi ve takılması için bir muylu anahtar.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589030700', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(532, 'W221589030900', 'Lokma anahtarı', NULL, NULL, 'aktif', 'Fren kaliperi cıvatalarını çözmek ve sıkmak için. Ön stabilizatör çubuğunun çözülmesi ve sıkılması için. Tork çubuğunda ve arka kamber ayar kolunda somunları çözmek sıkmak için. Arka eksantrik cıvatasında rot ayarının ayarlanması için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W221589030900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(533, 'W963589043100', 'Tutma tertibatı', NULL, NULL, 'aktif', 'Egzoz emisyonu iyileştirme ünitesindeki bakım kapağı gerdirme bandlarının yaylarını demontaj veya montaj sırasında gergin olarak tutmak için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W963589043100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(534, 'W470589035900', 'piston sıkacağı', NULL, NULL, 'aktif', 'Pistonun silindir çalışma yüzeyine (10,6l) takılmasında', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589035900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(535, 'W936589011400', 'Mesafe pulu', NULL, NULL, 'aktif', 'Arka radyal mil keçesi için takma tertibatı dengeleme pulu, 457 589 01 43 00 takma tertibatı ile birlikte kullanılır.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589011400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(536, 'W470589042100', 'Euro-6 sentil çanta', NULL, NULL, 'aktif', 'Egzoz supabı ve emme supabının ayarlanması için ayar aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589042100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(537, 'W611589012100', 'Euro-6 Geri geri dönüş', NULL, NULL, 'aktif', 'Enjektörlerin yakıt fazlası miktarını ölçmek için yakıt fazlası kontrol cihazı. Kontrol cihaz', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W611589012100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(538, 'W936589014000', 'Tutma tertibatı', NULL, NULL, 'aktif', ' Krank milinin üst ölü noktaya (ÜÖN) sabitlenmesi için tutma tertibatı.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589014000', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(539, 'W470589119106', 'adaptör', NULL, NULL, 'aktif', 'Yakıt alçak basınç devridaim hattının sızdırmazlık kontrolü için adaptör; manometre W 103 589 00 21 01 ve adaptör W 470 589 11 91 05 ile', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589119106', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(542, 'W936589033302', 'Darbeli çektirme', NULL, NULL, 'aktif', 'Çeşitli yapı parçalarını sıkmak için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589033302', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(543, 'W936589033301', 'Alet takımı', NULL, NULL, 'aktif', 'Koruma kovanını silindir kapağından çektirmek ve koruma kovanını enjektörün üzerine preslemek için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589033301', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(544, 'W470589043302', 'takma aleti', NULL, NULL, 'aktif', 'O ringlerin enjektöre takılması için yerleştirme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589043302', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(545, 'W470589043301', 'takma aleti', NULL, NULL, 'aktif', 'O ringlerin enjektöre takılması için yerleştirme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589043301', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(546, 'W470589030900', 'lokma', NULL, NULL, 'aktif', 'Yağ termostatının takılması ve sökülmesi için lokma ucu.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589030900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(547, 'W470589062301', 'Sente aparatı kırmızı şablon', NULL, NULL, 'aktif', 'Eksantrik millerinin üst ölü noktaya (OT) konumlandırılması için şablon.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589062301', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(548, 'W470589062302', 'Sente aparatı kırmızı şablon', NULL, NULL, 'aktif', 'Eksantrik millerinin üst ölü noktaya (OT) konumlandırılması için şablon.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589062302', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(549, 'W936589000700', 'tırnaklı anahtar', NULL, NULL, 'aktif', 'Enjektörün su kovanını söküp takmak için tırnaklı anahtar.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589000700', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(550, 'W470589021502', 'Malafa', NULL, NULL, 'aktif', ' Eksantrik mili muhafaza gövdesindeki kapağın montajı için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589021502', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(551, 'W470589079101', 'sızdırmazlık kontrol cihazı', NULL, NULL, 'aktif', 'Egzoz gazı geri dönüş soğutucusu kontrolü için sızdırmazlık kontrol cihazı, yüksek basınç pompası 124 589 24 21 00 ile bağlantılı olarak.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589079101', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(552, 'W470589000700', 'tırnaklı anahtar', NULL, NULL, 'aktif', 'Enjektörün su kovanını sökülmesi ve takılması için tırnaklı anahtar.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589000700', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(553, 'W936589039100', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589039100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(554, 'W470589036300', 'Adaptör seti', NULL, NULL, 'aktif', 'Takılı durumdaki kam milinde kam mili çerçevesinin sökülmesi ve takılması için adaptör seti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589036300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(555, 'W936589019100', 'Kapama tapası', NULL, NULL, 'aktif', 'Kontrol çalışmaları sırasında Rail bağlantılarının kapatılması için kapama tapası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589019100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(557, 'W936589003100', 'Adapsyon', NULL, NULL, 'aktif', 'Dişlinin sökülmesi ve takılması sırasında yakıt pompasını ve basınçlı hava kompresörünü sabitlemek için, sabitleme tertibatı 470 589 08 40 00 ile birlikte kullanılır.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589003100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(558, 'W936589049100', 'Adaptör', NULL, NULL, 'aktif', 'Enjektörlerin ve Rail basınç ayar valfının yakıt geri dönüş miktarının ölçümü için. Yakıt filtresi modülünde kontrol adaptörü 470 589 02 21 00 ile bağlantılı olarak yakıt basıncı ölçümü için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589049100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(559, 'W936589009100', 'Adaptör', NULL, NULL, 'aktif', 'Enjektör deliği üzerinden kompresyon kontrolü için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589009100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(560, 'W470589012100', 'Ayarl aleti', NULL, NULL, 'aktif', '3. dişlide kumanda tahrikini ayarlamak için ayar aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589012100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(561, 'W470589012300', 'Sabitleme tertibatı', NULL, NULL, 'aktif', 'Dişli çark tahrikinin sökülmesi sırasında krank milinin OT\'ye sabitlenmesi için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589012300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL);
INSERT INTO `aletler` (`id`, `seri_no`, `adi`, `marka`, `model`, `durum`, `aciklama`, `olusturma_tarihi`, `guncelleme_tarihi`, `created_at`, `barkod`, `kategori`, `raf_no`, `silindi`, `raf_id`, `eklenme_tarihi`, `zimmetli_personel_id`) VALUES
(562, 'W470589032302', 'ŞABLON', NULL, NULL, 'aktif', 'Eksantrik millerinin üst ölü noktaya konumlanması için şablon', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589032302', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(563, 'W470589032300', 'ŞABLON', NULL, NULL, 'aktif', 'Eksantrik millerinin üst ölü noktaya konumlanması için şablon', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589032300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(564, 'W936589003300', 'Çektirme aleti', NULL, NULL, 'aktif', 'Enjektörlerin silindir kapağıdan dışarı çektirilmesi için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589003300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(565, 'W470589001500', 'Malafa', NULL, NULL, 'aktif', 'Krank milinin volan dişli çerçevesi üzerinden OT\'ye sabitlenmesi için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589001500', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(566, 'W470589009103', 'ADAPTÖR', NULL, NULL, 'aktif', 'Kompresyonun enjektör deliği üzerinden kontrol edilmesine yönelik adaptör', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589009103', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(567, 'W470589009100', 'ADAPTÖR', NULL, NULL, 'aktif', 'Kompresyonun enjektör deliği üzerinden kontrol edilmesine yönelik adaptör', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589009100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(568, 'W711589024300', 'takma aleti', NULL, NULL, 'aktif', 'Şanzıman gövdesinde grup milinin yatağını takmak için takma el aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W711589024300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(569, 'W470589003100', 'ÖLÇÜM KÖPRÜSÜ', NULL, NULL, 'aktif', 'Piston taşmasını ölçmek için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589003100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(570, 'W400589092100', 'Bilgi Yok', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W400589092100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(571, 'W970589002300', 'AYARLAMA APARATI', NULL, NULL, 'aktif', 'Vites kolu için ayar tertibatı', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W970589002300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(572, 'W936589002300', 'ŞABLON', NULL, NULL, 'aktif', 'Eksantrik millerinin konumlanması için şablon.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589002300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(573, 'W470589013300', 'DIŞARI ÇEKME ALETİ', NULL, NULL, 'aktif', 'Enjektörün silindir kapağından sökülmesi için çektirme aleti.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589013300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(574, 'W470589066100', 'Kılavuz pimleri', NULL, NULL, 'aktif', 'Montaj sırasında silindir kapağın yönlendirilmesi esnasında.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589066100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(575, 'W470589000100', 'Karşı tutucu', NULL, NULL, 'aktif', 'Yakıt geri dönüş hattı yağ radyatörü bağlantısının kontralanması için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589000100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(577, 'W470589024300', 'Keçe çakacağı', NULL, NULL, 'aktif', 'Arka radyal mil keçesinin krank mili çıkışına takılması için.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589024300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(578, 'W715589266300', 'Oturma plakası', NULL, NULL, 'aktif', 'Şanzımanı kanal lifti ile sökmek için. Hatırlatma: Rotary Blitz Tip/Model şanzıman yuva plakasıyla birlikte: GA IVÜrün No. 590-3135 (şanzıman yuva plakasını sabitlemeye yarayan cıvatalar)', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589266300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(579, 'W936589016200', 'Motor kaldırma aparato', NULL, NULL, 'aktif', 'Komple motorun cereskal ile bağlantılı olarak sökülmesini ve takılmasını içeren uyarlama.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589016200', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(580, 'W711589014300', 'Basınç cihazı', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W711589014300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(581, 'W936589003700', 'Piston segman Takacağı Sıktırma', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589003700', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(582, 'W343589003300', 'Çektirme tertibatı', NULL, NULL, 'aktif', 'Miller, akslar ve pimler için 13 parçalı dışarı çektirme tertibat', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W343589003300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(583, 'W470589016300', 'Kablo Seti', NULL, NULL, 'aktif', 'Bilgi Yok', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589016300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(584, 'W963589009100', 'Doldurma cihazı', NULL, NULL, 'aktif', ' Park klima sisteminin soğutma maddesi devridaim hattının boşaltılması ve kabarcıksız olarak doldurulması için dolum cihazı. ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W963589009100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(586, 'W936589006100', 'Supap alet çantası', NULL, NULL, 'aktif', 'Valf yaylarının, valf sapı contasının montaj malafası ve çektirme aleti dahil ayrıca valf kılavuzları için bir alıştırma piminin sökülmesi ve takılması için valf takım çantası.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589006100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(587, 'W715589133300', 'çektirme', NULL, NULL, 'aktif', 'Şanzıman gövdesi arka parçasını çektirmek için ve 1. vites için dişliyi çektirmek için. Hatırlatma: Aşağıdaki birimlerle bağlantılı olarak, 715 589 15 34 00 Hidrolik silindir 715 589 10 34 00 Adaptör 715 589 11 34 00 Adaptör 715 589 12 34 00 Adaptör 652 589 00 33 21 El pompası 652 589 00 33 23 Hidrolik hortum', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589133300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(588, 'W715589024300', 'Yerleştirme tertibatı', NULL, NULL, 'aktif', 'Krank milleri ana yatağının (arka) preslenmesi için çektirme tertibatı, 715 589 13 33 00 çektirme aleti, 715 589 15 34 00 hidrolik silindir, 715 589 10 34 00 adaptör, 715 589 11 34 00 adaptör, 715 589 12 34 00 adaptör, 652 589 00 33 21 el pompası ve 652 589 00 33 23 hidrolik hortum ile bağlantılı olarak.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W715589024300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(589, 'W470589016200', 'Kavrama aleti (Kutu arkası)', NULL, NULL, 'aktif', 'Dizel partikül filtresini (DPF) sökmek ve takmak için kavrama aleti, 470   589   04   31   00 yuvasıyla bağlantılı olarak.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589016200', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(590, 'W470589219100', 'Kontrol kapağı', NULL, NULL, 'aktif', 'Tüm emme sisteminin sızdırmazlık kontrolü için. Not (Motor 934, 936 ile Tip 405, 437 hariç): Kapak A   001   988   95   35 ile bağlantılı olarak.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589219100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(591, 'W000589786300', 'GÜÇLENDİRİCİ', NULL, NULL, 'aktif', 'TORK GÜÇLENDİRİCİ', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W000589786300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(592, 'W000589680300', 'Yıldız anahtar lokması', NULL, NULL, 'aktif', 'Borulardaki rakor somununu gevşetmek ve sıkmak için yıldız anahtar lokması, anahtar genişliği 17 mm açık, tahrik 1/2\" dört köşeli.', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W000589680300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(593, 'W936589001400', 'Bilya çektirmesi', NULL, NULL, 'aktif', '', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W936589001400', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(594, 'W470589022300', 'Ayar el aleti', NULL, NULL, 'aktif', '', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589022300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(595, 'W400589079100', 'E6 Soğutma sistemi test adaptörü', NULL, NULL, 'aktif', 'YEŞİL KAPAKLAR', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W400589079100', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(596, 'W470589119105', 'Adaptör', NULL, NULL, 'aktif', '', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W470589119105', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(597, 'W642589056300', 'Montaj parçaları', NULL, NULL, 'aktif', '', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W642589056300', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(598, 'W422589020900', 'Özel Lokma', NULL, NULL, 'aktif', '', '2025-02-07 13:01:41', '2025-07-02 14:17:26', '2025-02-07 13:01:41', 'W422589020900', NULL, NULL, 0, NULL, '2025-02-07 13:01:41', NULL),
(599, '000 589 24 07 00', '˜€ €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 24 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(600, '000 589 37 37 00', 'P˜STON SEGMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 37 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(601, '000 589 52 37 00', 'PEN€E', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 52 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(602, '000 589 52 43 00', '€EKT˜RME FREN S˜L˜ND˜R', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 52 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(603, '001 589 72 09 00', 'LOKMA 65 MM', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 72 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(604, '103 589 02 09 00', 'F˜LTRE KAPAK ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '103 589 02 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(605, '112 589 00 01 00', 'EKSANTR˜K TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 00 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(606, '112 589 00 10 00', 'MAFSALLI ALLEN', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(607, '112 589 00 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(608, '112 589 00 32 00', 'EKSANTR˜K SAB˜TLEY˜C˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 00 32 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(609, '112 589 01 03 00', '™ZEL YILDIZ ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 01 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(610, '112 589 01 09 00', 'BUJ˜ ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 01 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(611, '112 589 01 32 00', 'EKSANTR˜K SAB˜TLEY˜C SOL', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 01 32 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(612, '112 589 03 31 00', 'MERKEZLEME M˜L˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 03 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(613, '112 589 03 40 00', 'KRANK K˜L˜TLEME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 03 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(614, '112 589 09 63 00', 'Z˜NC˜R P˜M PER€˜NLEME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '112 589 09 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(615, '116 589 01 62 00', 'FREN YAYI KANCASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 01 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(616, '113 589 00 40 00', 'KARI TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '113 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(617, '116 589 02 07 00', 'ALLEN (T) ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 02 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(618, '116 589 03 07 00', 'ALLEN (T) ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 03 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(619, '116 589 20 33 00', 'Z˜NC˜R P˜M˜ €EKT˜RMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '116 589 20 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(620, '119 589 04 63 00', 'BASIN€LI HORTUM', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '119 589 04 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(621, '124 589 03 33 00', 'ROT €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 03 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(622, '123 589 03 43 00', 'MONTAJ ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '123 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(623, '124 589 03 34 00', 'ROT €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '124 589 03 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(624, '124 589 05 43 00', 'SARI €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '124 589 05 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(625, '126 589 01 62 00', 'MONTAJ ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 01 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(626, '126 589 02 09 00', '30 LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 02 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(627, '129 589 00 21 00', 'TEST ADAPT™Rš', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(628, '129 589 00 34 00', '€EKT˜RME AYA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 00 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(629, '129 589 01 07 00', 'FLAN ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 01 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(630, '129 589 01 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(631, '137 589 00 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '137 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(632, '137 589 01 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '137 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(633, '140 589 13 43 00', 'BANT MONTAJ ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 13 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(634, '140 589 43 63 00', 'KONTROL KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '140 589 43 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(635, '163 589 00 07 00', 'FLAN TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 00 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(636, '163 589 02 43 00', 'LAST˜K HUR€ €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 02 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(637, '166 589 00 03 00', 'V KAYI MONTAJ ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '166 589 00 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(638, '166 589 00 14 00', 'MALAFA KRANK ARKA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '166 589 00 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(639, '166 589 00 59 00', 'MONTAJ TAHTASI S˜L˜ND˜R˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '166 589 00 59 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(640, '166 589 01 40 00', 'SAB˜TLEME VALANTI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '166 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(641, '168 589 00 15 00', 'MALAFA PR˜ZD˜REK KE€ES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(642, '168 589 00 37 00', 'PENSE FREN YAYLARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 00 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(643, '168 589 01 15 00', 'MALAFA YAN M˜L KE€ES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(644, '168 589 02 63 00', 'HELEZON YAY €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 02 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(645, '168 589 04 63 00', 'KONTROL KABLOSU 77 UC', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 04 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(646, '201 589 00 01 00', 'A€IK A¦IZ ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 00 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(647, '201 589 12 43 00', 'BANT MONTAJ ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 12 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(648, '203 589 00 43 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(649, '203 589 01 07 00', 'DEPO MššR ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 01 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(650, '203 589 01 31 00', 'HELEZON YAYI €EKT˜RME M˜L˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 01 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(651, '203 589 01 43 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(652, '203 589 01 63 00', 'HELEZON YAYI €EKT˜RME BALI¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '203 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(653, '343 589 00 40 00', 'KOMPARAT™R AYA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '343 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(654, '407 589 00 63 00', 'MOTOR D™NDERME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '407 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(655, '601 589 00 10 00', 'ALLEN ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '601 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(656, '601 589 02 40 00', 'KRANK SAB˜TLEME ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '601 589 02 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(657, '616 589 00 34 00', 'P˜M €EKT˜RME PAR€ASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '616 589 00 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(658, '617 589 00 10 00', 'ALLEN ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '617 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(659, '658 589 00 63 00', 'KONTROL KABLOSU ABS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '658 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(660, '000 589 12 09 00', 'LOKMA 50 MM', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 12 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(661, '30-36-41', 'A€IK A¦IZ ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '30-36-41', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(662, '000 589 14 09 00', 'LOKMA 60 MM', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 14 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(663, '001 589 50 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 50 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(664, '001 589 76 09 00', 'TORKLA ALLEN TAKIMI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '001 589 76 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(665, '113 589 00 01 00', 'A€IK A¦IZ ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '113 589 00 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(666, '116 589 22 33 00', 'PORYA €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 22 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(667, '140 589 02 33 00', 'KANCA G™STERGE PENEL˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(668, '168 589 01 91 00', 'KAP RADYAT™R ™L€ME ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(669, '000 589 58 43 00', 'Z˜NC˜R P˜M PE€˜NLEME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 58 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(670, '128 589 00 21 00', 'F˜L˜ SOKET KUTUSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '128 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(671, '124 589 05 19 00', 'D˜SK KUMPASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 05 19 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(672, '140 589 00 31 00', 'HELEZON YAYI €EKT˜RME M˜L˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '140 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(673, '202 589 13 63 00', 'YAY €EKT˜RME M˜L˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '202 589 13 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(674, '202 589 14 63 00', 'YAY €EKT˜RME M˜L˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '202 589 14 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(675, '203 589 00 07 00', '2 TIRNAKLI ™ZEL LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '203 589 00 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(676, '111 589 25 63 00', 'S˜BOP YAYI S™KME ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '111 589 25 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(677, '102 589 02 09 00', 'BUJ˜ ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 02 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(678, '435 589 01 31 00', 'SAB˜TLEME ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '435 589 01 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(679, '000 589 68 03 00', 'YILDIZ ANAHTAR 17  REKOR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 68 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(680, '001 589 27 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '001 589 27 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(681, '000 589 51 37 00', 'SEKMAN PEN€E', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 51 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(682, '104 589 00 63 00', 'KONTROL KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '104 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(683, '123 589 00 16 00', 'UZATMA UZUN KOL', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '123 589 00 16 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(684, '000 589 02 34 00', '€EKT˜RME PAR€ASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 02 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(685, '201 589 06 34 00', '€EKT˜RME PAR€ASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '201 589 06 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(686, '611 589 00 90 00', 'YAKIT BASIN€ HORTUMU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 00 90 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(687, '360 589 00 24 00', 'MANOMETRE-HAVA SAAT˜-', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '360 589 00 24 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(688, '460 589 00 21 00', 'MASTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '460 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(689, 'W-137 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'W-137 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(690, '638 589 05 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '638 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(691, '001 589 76 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 76 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(692, '124 589 24 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 24 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(693, '210 589 00 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(694, '202 589 00 93 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '202 589 00 93 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(695, '210 589 00 71 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 00 71 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(696, '000 589 40 37 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 40 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(697, '201 589 01 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(698, '166 589 00 43 00', '€EKME APARATI (6 PAR€A)', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '166 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(699, '201 589 00 34 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 00 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(700, '140 589 08 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 08 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(701, '140 589 01 34 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 01 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(702, '271 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(703, '204 589 13 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '204 589 13 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(704, '220 589 03 43 00', '™ZEL EL ALET˜ ROT ATTIRMA TAKIMLARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(705, '202 589 02 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(706, '611 589 07 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 07 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(707, '611 589 05 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 05 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(708, '202 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(709, '201 589 13 21 00', '™ZEL EL ALET˜ VAKUM METRE SAAT˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 13 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(710, '220 589 00 99 00', 'ELEKTR˜K €ANTASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 00 99 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(711, '000 589 26 68 00', 'ENJEKT™R FIR€ASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 26 68 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(712, '211 589 00 63 00', 'KL˜MA REKORU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(713, '230 589 02 63 00', 'SBC KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '230 589 02 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(714, '611 589 01 63 00', 'KOMPR™S™R BUJ˜ YER˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(715, '220 589 00 33 00', 'DENGE KOLU €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(716, '140 589 17 63 00', 'DRK POMPA BASIN€', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 17 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(717, '220 589 06 43 00', '™N TABLA €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 06 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(718, '124 589 02 34 00', 'B˜LYA S™KME TAKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 02 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(719, '140 589 45 63 00', 'SšSPANSYON KONTROL', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 45 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(720, '220 589 00 99 35', 'ADAPT™R KABLO', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 00 99 35', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(721, '611 589 03 63 00', 'ADAPT™R KABLO', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(722, '163 589 03 43 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(723, '129 589 03 43 00', 'ALT KAFA €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(724, '211 589 00 09 00', 'AMART˜S™R HORTUMU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(725, '169 589 00 91 00', 'RADYAT™R KAPA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '169 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(726, '639 589 00 91 00', 'RADYAT™R KAPA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '639 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(727, '611 589 00 40 00', 'KANAT ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(728, 'Q 8454 984 0000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'Q 8454 984 0000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(729, '1034 290 MM', 'E¦R˜ YAYSIZ  SEGMAN PENSES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '1034 290 MM', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(730, '1036 300 MM', 'DšZ YAYLI SEGMAN PENSES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '1036 300 MM', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(731, '1038 300 MM', 'E¦R˜ YAYLI SEGMAN PENSES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '1038 300 MM', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(732, '1032 300 MM', 'DšZ YAYSIZ SEGMAN PENSES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '1032 300 MM', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(733, '209 589 07 23 00', '™N KAPI MASTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '209 589 07 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(734, '209 589 00 09 00', 'KOMB˜ LOKMA ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '209 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(735, '203 589 02 31 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 02 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(737, '950 589 01 99 03', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '950 589 01 99 03', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(738, '950 589 01 99 02', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '950 589 01 99 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(739, '611 589 05 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(740, '230 589 00 22 00', 'PROGRAM CD\'S˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '230 589 00 22 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(741, '124 589 06 21 00', 'DRK POMPA TEST C˜HAZI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 06 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(742, '111/8-3/4', 'LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '111/8-3/4', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(743, '000 589 77 03 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 77 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(744, '602 589 03 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '602 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(745, '611 589 00 03 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 00 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(746, '611 589 01 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '611 589 01 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(747, '126 589 00 10 00', 'SRS S™KME TAKMA ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(748, '001 589 78 09 00', 'ISITMA BUJ˜ LOKMASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 78 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(752, 'A 000 589 03 50', 'TAKIM €ANTSI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'A 000 589 03 50', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(753, '422 589 01 09 00', 'LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '422 589 01 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(754, '422 589 02 09 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '422 589 02 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(756, '1 1/8-3/4', 'LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '1 1/8-3/4', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(757, '668 589 00 34 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '668 589 00 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(758, '303 589 00 90 00', 'DREKS. TEST C˜HAZI HORTUMU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '303 589 00 90 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(759, '140-202', 'KASA KALIPLARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '140-202', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(760, '8050', 'MOTOR KOMPRESYONUNU ™L€. SA.', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '8050', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(761, '140 589 03 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(762, '140 589 06 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 06 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(763, '102 589 00 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(764, '000 589 22 01 00', 'A€IK A¦IZ ANAHTAR 19 MM.', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 22 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(765, '000 589 23 01 00', 'A€IK A¦IZ ANAHTAR 22 MM.', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 23 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(766, '000 589 12 28 02', 'PLAST˜K BORU BI€A¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 12 28 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(767, '360 589 00 21 00', 'FREN TEST', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '360 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(768, '620 589 00 59 00', 'ANZUMAN ASKI TERT˜BATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '620 589 00 59 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(769, '617 589 04 23 00', 'SENT˜L 60 (1 SET)', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '617 589 04 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(770, '000 589 38 31 00', 'P˜STON SEKMAN KELEP€ES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 38 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(771, '749 589 00 07 00', 'PORYA ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '749 589 00 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(772, '102 589 01 14 00', 'YšKSšK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 01 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(773, '102 589 01 40 00', 'KRANK SAB˜TLEME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(774, '102 589 05 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 05 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(776, '102 589 04 63 00', 'KONTROL KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 04 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(777, '124 589 45 63 00', 'KONTROL KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 45 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(778, '140 589 29 63 00', 'KONTROL KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 29 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(779, '140 589 09 33 00', 'ROT €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 09 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(780, '140 589 11 43 00', 'BUR€ €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '140 589 11 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(781, '140 589 24 63 00', 'BASKI PAR€ASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 24 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(782, '140 589 00 33 00', 'ROT €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(783, '126 589 00 01 00', 'AFT ANAHTARI 46', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 00 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(784, '001 589 66 21 00', 'TORK ANAHTARI (AFT ˜€˜N)', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 66 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(785, '126 589 15 63 00', 'ADAPT™R ABS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 15 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(786, '140 589 10 33 00', 'BASKI PAR€ASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 10 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(788, '126 589 09 21 00', 'ABS KONTROL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 09 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(790, '140 589 14 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 14 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(791, '124 589 09 63 00', 'MONTAJ ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 09 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(792, '403 589 00 21 00', 'KOMP. ™L€ME ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '403 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(793, '000 589 12 28 00', 'KABLO KES˜C˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 12 28 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(794, '442 589 00 31 00', 'POMPA ˜ST˜NAT ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '442 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(795, '406 589 00 43 00', 'KE€E APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '406 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(796, '425 589 00 61 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '425 589 00 61 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(797, '406 589 02 59 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '406 589 02 59 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(798, '425 589 01 62 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '425 589 01 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(799, '435 589 00 43 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '435 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL);
INSERT INTO `aletler` (`id`, `seri_no`, `adi`, `marka`, `model`, `durum`, `aciklama`, `olusturma_tarihi`, `guncelleme_tarihi`, `created_at`, `barkod`, `kategori`, `raf_no`, `silindi`, `raf_id`, `eklenme_tarihi`, `zimmetli_personel_id`) VALUES
(801, '406 589 06 33 00', 'ROT ATTIRACA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '406 589 06 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(802, '406 589 01 59 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '406 589 01 59 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(803, '352 589 01 31 00', 'KE€E APARATI -F˜T˜L €AKACA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '352 589 01 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(804, '317 589 06 15 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '317 589 06 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(805, '363 589 01 07 00', 'PORYE ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '363 589 01 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(806, '352 589 07 15 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '352 589 07 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(807, '435 589 01 43 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '435 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(808, '425 589 04 43 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '425 589 04 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(809, '424 589 01 43 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '424 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(810, '617 589 01 63 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '617 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(811, '318 589 00 15 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '318 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(812, '000 589 29 34 00', 'ANZUMAN €EKT˜RME ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 29 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(813, '180 589 00 30 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '180 589 00 30 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(814, '360 589 00 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '360 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(815, '001 589 07 33 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '001 589 07 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(816, '601 589 02 59 03', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '601 589 02 59 03', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(817, '442 589 00 91 00', 'VENT˜L', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '442 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(818, '000 589 27 01 00', 'ANAHTAR 19', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 27 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(819, '102 589 13 15 00', 'TAPA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 13 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(820, '123 589 02 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '123 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(821, '601 589 19 33 00', '™ZEL €EKT˜RME TAKIMI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '601 589 19 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(822, '000 589 43 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 43 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(823, '000 34 07 00', '8 E¦R˜ LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 34 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(824, '000 589 04 07 00', '10 LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 04 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(825, '123 589 02 10 00', '8 MAVSALLI G™MME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '123 589 02 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(826, '381 589 00 31 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '381 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(827, '110 589 01 01 00', 'S˜BOP AYAR ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '110 589 01 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(828, '442 581 01 66 00', 'REKOR ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '442 581 01 66 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(829, '119 589 02 09 00', 'BUJ˜ LOKMASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '119 589 02 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(830, '116 589 01 40 00', 'VOLANT TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(831, '103 589 00 33 03', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '103 589 00 33 03', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(832, '615 589 00 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '615 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(833, '001 589 48 21 00', 'RADYAT™R BASIN€ SAAT˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 48 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(834, '201 589 06 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 06 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(835, '001 589 43 33 00', 'BALATA €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 43 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(836, '116 589 00 43 00', 'S˜BOP LAST˜K GE€˜RECE¦˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(837, '617 589 00 43 00', 'S˜BOP LAST˜K GE€˜RECE¦˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '617 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(838, '116 589 01 43 00', 'S˜BOP LAST˜K GE€˜RECE¦˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(839, '220 589 01 99 50', 'TORNAV˜DA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 01 99 50', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(840, '357002', 'AIRPULLER U€ SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '357002', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(841, 'Q84553080000', '˜LAVE AKS YA¦ DOLUM C˜HAZI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q84553080000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(842, '425 589 00 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '425 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(843, '424 589 00 33 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '424 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(844, '000 589 15 31 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 15 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(845, '422 589 00 43 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '422 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(846, '387 589 02 37 00', 'REKOR PENSE', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '387 589 02 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(847, '520 983 03 99 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '520 983 03 99 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(848, '000 589 01 13 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 01 13 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(849, '615 589 00 21 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '615 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(850, '617 589 05 23 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '617 589 05 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(851, '116 589 08 21 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '116 589 08 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(852, '312 589 09 07 00', 'ALET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '312 589 09 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(853, '636 589 02 03 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '636 589 02 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(854, '352 589 00 23 00', 'YA¦ TAZ˜K ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '352 589 00 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(855, '601 589 00 53 00', 'T KOL', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '601 589 00 53 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(856, '422 589 00 63 00', 'POMPA TAKMA ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '422 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(857, '406 589 00 61 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '406 589 00 61 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(858, '312 589 01 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '312 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(859, '116 589 00 13 00', 'LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 00 13 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(860, '601 589 13 63 00', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '601 589 13 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(861, '443 589 02 33 00', 'ANZUMAN €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '443 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(862, '126 589 04 31 00', 'MASTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 04 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(863, '201 589 07 21 00', 'BANT BALIK ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 07 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(864, '201 589 00 37 00', '™ZEL PENSE', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 00 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(865, '201 589 03 59 00', 'BANT S™KME ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 03 59 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(866, '126 589 06 23 00', 'FLAN', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '126 589 06 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(867, '636374', 'SOS˜ST S˜L˜KON TABANCA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '636374', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(868, '210 589 00 07 00', 'KONTAK S™KME CONTASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 00 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(869, 'KD1152A', 'SCOOTER BLOCK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'KD1152A', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(870, 'KOT2095', 'OBDPL NGCSC', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'KOT2095', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(871, 'K9511', 'INSTALLER RECEIVER B', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K9511', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(872, 'K9672', 'INSTALLER', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K9672', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(873, '400 589 04 21 00', 'YA¦ KONTROL €UBU¦U', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '400 589 04 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(874, '639 589 11 63 00', 'ADAPT™R KABLO', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '639 589 11 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(875, 'ART˜CLE NO:F 13782(400 ML)', 'S˜KA JETFLOW GUN SL˜KON TABANCASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'ART˜CLE NO:F 13782(400 ML)', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(876, '642 589 00 09 00', 'YA¦ F˜LTRES˜ S™KME APARTI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '642 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(877, 'AD506', 'DAYAMA SET˜ - 9 PAR€A', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'AD506', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(878, '143', '€EK˜€ TAKIMI - 5 PAR€A', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '143', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(879, '550.5240.0', 'AUTOPROTECT-OTOMOT˜K KAYNAK MASKE', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '550.5240.0', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(880, 'MIM', 'LAST˜K D˜ DER˜NL˜¦˜ ™L€ME-0-50 mm', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'MIM', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(881, 'OKS.01', 'OKS˜JEN KAYNAK SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'OKS.01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(882, '5100-A', 'ASET˜LEN SAAT˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '5100-A', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(883, '902001', 'e) aliminyum yapŸtrma seti', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '902001', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(884, '639 589 03 63 00', 'D˜G˜TAL TERMOMETRE -50/+280 DERECE', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '639 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(885, 'K 815 2', 'V˜TO V˜TES KOLU AYAR APARTI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'K 815 2', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(886, 'K 869 3', '˜NSTALLER', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K 869 3', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(887, 'K 950 4', 'REMOVER', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K 950 4', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(888, 'K 951 2', '˜NSTALLER SEAL', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K 951 2', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(889, 'K 952 4', 'REMOVER BUSH˜NG', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K 952 4', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(890, 'K 953 3', 'D˜AL ˜ND˜CATOR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K 953 3', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(891, '000 589 13 99 30', 'BOOSTER-PAC AKš ARJ ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '000 589 13 99 30', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(892, '715 589 01 34 00', 'D˜KEY ANZUMAN KR˜KOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '715 589 01 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(893, '611 589 00 37 00', 'ISITMA BUJ˜ LOKMASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 00 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(894, '422 589 01 23 00', 'ISITMA BUJ˜ PENSES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '422 589 01 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(895, '271 589 00 31 00', 'MOTOR SENTE APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(896, '111 589 03 15 00', 'MOTOR SENTE KAMASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '111 589 03 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(897, '646 589 00 91 00', 'ADAPT™R KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '646 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(898, '646 589 01 21 00', 'HORTUM SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '646 589 01 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(899, '000 589 838 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 838 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(900, '628 589 02 63 00', 'KABLO SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '628 589 02 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(901, 'W202589044310', 'ROT €EKT˜RME APARATI Kš€šK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'W202589044310', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(902, 'W203589013100', 'ROT €EKT˜RME APARATI BšYšK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'W203589013100', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(903, 'PAKKENS', 'GERD˜RME APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'PAKKENS', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(904, '450 589 00 10 00', 'KALEM', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(905, '450 589 00 62 00', '˜€ TORK T 70', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 00 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(906, '450 589 00 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(907, 'Q0005143V001000000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'Q0005143V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(908, 'Q0005149V001000000', 'TAIYICI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q0005149V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(909, '450 589 05 63 00', 'B˜LYALI MAFSAL', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(910, '450 589 06 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 06 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(911, 'Q0005568V001000000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'Q0005568V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(912, 'Q0006966V001000000', 'SOKET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q0006966V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(913, 'Q 450 589 01 91 00', 'C˜VATA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q 450 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(914, 'Q0007345V001000000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'Q0007345V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(915, '450 589 16 63 00', 'C˜VATA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 16 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(916, '450 589 03 33 00', 'KABLO', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 03 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(917, '452 589 00 23 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '452 589 00 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(918, '450 589 27 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 27 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(919, 'Q0005009V001000000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'Q0005009V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(920, 'Q0005136V001000000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q0005136V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(921, '450 589 00 15 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(922, '450 589 01 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(923, 'Q0005147V001000000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'Q0005147V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(924, '450 589 05 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 05 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(925, '450 589 17 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 17 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(926, '450 589 08 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 08 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(927, 'Q0007665V001000000', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'Q0007665V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(928, '450 589 02 91 00', 'ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 02 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(929, '450 589 03 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 03 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(930, 'Q0014668V001000000', 'ADAPT™R', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q0014668V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(931, 'Q0014902V001000000', 'ADAPT™R TORKU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q0014902V001000000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(932, 'Q0015810V0000000001', '™ZEL TORNAV˜DA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q0015810V0000000001', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(933, '450 589 26 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 26 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(934, '211 589 04 21 01', 'DARBEL˜ 80 LOKMA 6 K™E', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '211 589 04 21 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(935, '842001', 'SBC KONTROL TAKIMI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '842001', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(936, '450 589 03 09 00', 'STAB˜L˜ZAT™R SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 03 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(937, '450 589 20 63 00', 'TORX FREN PEDALI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 20 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(938, '452 589 02 09 00', 'ANT˜F˜R˜Z DOLUM ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '452 589 02 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(939, '451 589 00 40 00', 'LOKMA ESP BASIN€ SENS™Rš', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(940, '451 589 01 31 00', 'KARI TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 01 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(941, '451 589 01 40 00', 'SAB˜TLEME APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(942, '451 589 00 31 00', 'SAB˜TLEME APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(943, '451 589 00 63 00', 'GERD˜RME APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(944, '451 589 01 39 00', 'TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 01 39 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(945, '451 589 00 10 00', 'UZATMA PAR€A', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(946, '451 589 00 61 00', 'P˜ML˜ ANAHTAR(SMART)', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 00 61 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(947, '451 589 01 10 00', 'MONTAL ALET˜(SMART)', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 01 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(948, '451 589 00 62 00', 'TORX U€ TAKIMI(SMART)', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 00 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(949, '211 589 04 21 05', 'ALTLIK YUVA(SMART)', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 04 21 05', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(950, '9647643(08917643)', 'ADAPTOR KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '9647643(08917643)', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(951, '450 589 04 33 00', 'EVAPOMAT KL˜MA DEZENFEKTE MODšLš', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 04 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(952, '450 589 00 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(953, '6511126099', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '6511126099', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(954, '651112099', 'KABLO', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '651112099', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(955, 'Q1X56136512', 'KABLO', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Q1X56136512', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(956, 'OPT-P305J', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'OPT-P305J', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(957, '741 589 02 15 00', 'HAVALI TABANCA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '741 589 02 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(958, '906 589 01 62 00', 'P˜N', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '906 589 01 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(959, '272 589 01 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '272 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(960, '272 589 02 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '272 589 02 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(961, '272 589 01 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '272 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(962, '204 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(963, '204 589 01 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(964, '204 589 00 43 00', '™ZEL EL ALET˜    TEST KABLOSU     B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(965, '204 589 01 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(966, '204 589 02 43 00', '™EL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 02 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(967, '204 589 03 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(968, '204 589 04 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 04 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(969, 'KVM1085', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'KVM1085', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(970, '452 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '452 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(971, 'QUAN˜X4500', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'QUAN˜X4500', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(972, '211 589 06 23 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 06 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(973, 'K8452', 'BALATA KONTROL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'K8452', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(974, 'OPT-P611', 'MOTOR KRANK €EKT˜RME MALAFASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'OPT-P611', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(976, '8571-01.GEDORE S20-1000', 'OSAKA HAVALI TABANCA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '8571-01.GEDORE S20-1000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(977, '4550-55 GEDORE 100-550', 'TORK ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '4550-55 GEDORE 100-550', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(978, '230 589 01 33 00', 'HORTUM €IKARACA¦I-221 BaŸlyor OPT-216', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '230 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(979, '50+70C', 'COMMAND C˜HAZI YAZILIM YšKLEME DVD', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '50+70C', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(980, '964948900', 'DUAL D˜J˜TAL TERMOMETRE', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '964948900', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(981, '403 589 03 15 00', 'YILDIZ ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '403 589 03 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(982, '749 589 01 09 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '749 589 01 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(983, '221 589 00 33 00', 'ROT ATTIRACA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '221 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(985, '230 589 00 33 00', '230 589 00 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '230 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(986, '221 589 02 33 00', '221 589 02 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '221 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(987, '221 589 03 33 00', '221 589 03 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '221 589 03 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(988, '210 589 04 63 00', '210 589 04 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 04 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(989, '271 589 00 10 00', '271 589 00 10 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(990, '271 589 01 01 00', '271 589 01 01 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 01 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(991, '271 589 02 33 00', '271 589 02 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(992, '271 589 05 63 00', '271 589 05 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '271 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(993, '642 589 00 33 00', '642 589 00 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '642 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(994, '668 589 00 63 00', '668 589 00 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '668 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(995, 'A 620 990 03 70', 'A 620 990 03 70', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'A 620 990 03 70', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(996, '611 589 02 63 00', '611 589 02 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 02 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(997, '212 589 00 43 00', 'BUR€ €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '212 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(998, '171 589 00 34 00', '171 589 00 34 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '171 589 00 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(999, '221 589 05 33 00', 'ROT ATTIRACA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '221 589 05 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1000, '651 589 01 63 00', 'KABLO APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '651 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1001, '271 589 03 40 00', 'KARI TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 03 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1002, '271 589 01 43 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1003, 'MA001 589 38 33 00', 'MA001 589 38 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA001 589 38 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1004, 'MA001 589 79 09 00', 'MA001 589 79 09 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA001 589 79 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1005, 'MA124 589 34 63 00', 'MA124 589 34 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA124 589 34 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1006, 'MA221 589 00 31 00', 'MA221 589 00 31 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA221 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1007, 'MA272 589 02 63 00', 'MA272 589 02 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA272 589 02 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1008, 'MA722 589 01 31 00', 'MA722 589 01 31 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA722 589 01 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1009, 'MA722 589 04 15 00', 'MA722 589 04 15 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA722 589 04 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1010, 'MA001 589 51 33 00', 'MA001 589 51 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA001 589 51 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1011, 'MA124 589 00 91 00', 'MA124 589 00 91 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA124 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1012, 'MA163 589 01 91 00', 'MA163 589 01 91 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA163 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1013, 'MA164 589 01 07 00', 'MA164 589 01 07 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA164 589 01 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1014, 'MA640 589 00 91 00', 'MA640 589 00 91 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA640 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1015, 'MA639 589 01 91 00', 'MA639 589 01 91 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA639 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1016, 'MA208 589 00 15 00', 'MA208 589 00 15 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MA208 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1017, '271 589 00 21 00', 'KONTROL C˜HAZI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '271 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1018, '541 589 00 01 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '541 589 00 01 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1019, '904 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '904 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1020, '220 589 01 99 20', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 01 99 20', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1021, '129 589 00 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1022, '129 589 10 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 10 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1023, '163 589 00 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1024, '163 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1025, '163 589 02 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 02 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1026, '163 589 06 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 06 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1027, '164 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1028, '164 589 01 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1029, '164 589 02 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 02 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1030, '164 589 03 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 03 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1031, '169 589 00 35 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '169 589 00 35 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1032, '169 589 02 62 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '169 589 02 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1033, '169 589 02 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '169 589 02 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1034, '210 589 01 14 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 01 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1035, '210 589 03 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1036, '210 589 03 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1037, '210 589 07 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 07 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1038, '211 589 00 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1039, '211 589 00 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1040, '211 589 01 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1041, '240 589 00 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '240 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1042, '211 589 03 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1043, '639 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '639 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL);
INSERT INTO `aletler` (`id`, `seri_no`, `adi`, `marka`, `model`, `durum`, `aciklama`, `olusturma_tarihi`, `guncelleme_tarihi`, `created_at`, `barkod`, `kategori`, `raf_no`, `silindi`, `raf_id`, `eklenme_tarihi`, `zimmetli_personel_id`) VALUES
(1044, '211 589 05 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 05 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1045, '211 589 06 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 06 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1046, '215 589 01 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '215 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1047, '220 589 04 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 04 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1048, '221 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '221 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1049, '221 589 01 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '221 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1050, '230 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '230 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1051, '230 589 11 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '230 589 11 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1052, '266 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '266 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1053, '271 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1054, '271 589 01 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1055, '640 589 00 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '640 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1056, '204 589 03 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1057, '212 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '212 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1058, '613 589 00 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '613 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1059, '203 589 01 63 02', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 01 63 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1060, '638 589 03 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '638 589 03 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1061, '639 589 05 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '639 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1062, '220 589 02 31 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 02 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1063, '164 589 00 10 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 00 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1064, '168 589 02 31 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 02 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1065, '639 589 00 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '639 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1066, '210 589 00 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1067, '642 589 01 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '642 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1068, '271 589 00 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1069, '668 589 01 34 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '668 589 01 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1070, '271 589 03 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 03 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1071, '642 589 00 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '642 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1072, '230 589 00 34 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '230 589 00 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1073, '639 589 02 23 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '639 589 02 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1074, '164 589 01 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1075, '164 589 03 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1076, '901 589 04 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '901 589 04 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1077, '271 589 01 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1078, '163 589 01 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1079, '639 589 00 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '639 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1080, '203 589 03 31 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 03 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1081, '642 589 00 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '642 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1082, '606 589 00 37 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '606 589 00 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1083, '201 589 08 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '201 589 08 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1084, '611 589 01 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1087, '129 589 01 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 01 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1088, '221 589 01 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '221 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1089, '129 589 11 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 11 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1090, '164 589 00 05 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '164 589 00 05 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1091, '100 589 02 59 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '100 589 02 59 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1092, '211 589 01 03 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 01 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1094, '611 589 02 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1095, '169 589 00 62 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '169 589 00 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1096, '169 589 01 62 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '169 589 01 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1097, '450 589 00 07 00', 'TANK ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 00 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1098, '203 589 03 10 00', 'VENT˜L ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 03 10 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1099, '208 589 00 21 00', 'BASKI TERT˜BATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '208 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1100, '211 589 02 21 00', 'S˜LECEK APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 02 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1101, '169 589 00 37 00', '€AKMAKLIK €IKARMA AP.', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '169 589 00 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1102, '607 589 01 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1103, '607 589 05 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 05 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1104, '607 589 04 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 04 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1105, '607 589 00 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1106, '415 589 00 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '415 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1107, '415 589 01 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '415 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1108, '270 589 02 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 02 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1109, '270 589 02 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 02 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1110, '607 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1111, '607 589 00 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1112, '607 589 02 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 02 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1113, '607 589 01 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1114, '607 589 00 31 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1115, '607 589 03 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 03 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1116, '607 589 02 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 02 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1117, '270 589 01 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1118, 'B007 280 424', 'B007 280 424 D˜˜ TORX LOKMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'B007 280 424', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1119, '514 589 01 62 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '514 589 01 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1120, '700 589 00 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1121, '415 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '415 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1122, '607 589 02 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 02 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1123, '607 589 01 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1124, '700 589 01 14 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 01 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1125, '415 589 00 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '415 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1126, '700 589 01 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1127, '700 589 02 15 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 02 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1128, '607 589 01 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1129, '000 589 00 21 00', '™ZEL EL ALET˜ ADAPT™R KUTU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1130, '700 589 00 14 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 00 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1132, '607 589 03 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 03 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1133, '000 589 08 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 08 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1134, '607 589 00 63 00', 'C˜TAN BA¦LANTI KABLOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1135, '270 589 01 61 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 01 61 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1136, '103 589 03 09 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '103 589 03 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1137, 'R01-260', '150x0,01MM D˜J˜TAL. KUMPAS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'R01-260', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1138, '220 589 00 99 02', '220 589 00 99 02', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 00 99 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1139, '450 589 10 21 00', 'YAYLI TERAZ˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '450 589 10 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1140, '140 589 02 33  00', 'ACI ™LCšM', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '140 589 02 33  00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1141, '220 589 05 99 00', 'KABLO SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 05 99 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1142, '001 589 78 21 00', 'EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 78 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1143, '626 589 02 40 00', '™ZEL EL ALET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '626 589 02 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1144, '626 589 04 40 00', 'AYAR EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '626 589 04 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1146, '626 589 01 91 00', '™ZEL ALET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '626 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1147, '626 589 00 40 00', '™ZEL ALET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '626 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1148, '271 589 07 63 00', 'GERD˜R˜C˜,Z˜NC˜R ™L€ME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 07 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1149, '626 589 01 40 00', 'TUTMA K˜L˜D˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '626 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1150, '626 589 03 40 00', 'TUTMA K˜L˜D˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '626 589 03 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1151, '272 589 00 91 00', 'ADAPT™R', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '272 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1152, '626 589 00 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '626 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1153, '450 589 17 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 17 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1154, '270 589 00 40 00', 'Tutma kilidi', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1155, '278 589 01 15 00', 'ENJEKT™R BAKIM TAKIMI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '278 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1156, '278 589 00 33 00', 'Enjekt”r €ektirme', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '278 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1157, '470 589 01 62 01', 'S™KME APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '470 589 01 62 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1158, '103 589 00 21 00', 'EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '103 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1159, '700 589 08 15 00', 'Malafa', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 08 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1160, '700 589 04 43 00', 'El aleti', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 04 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1161, '700 589 09 15 00', 'Malafa', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 09 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1162, '129 589 00 91 00', 'MEOT ENJEKT™R TAPA SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1163, '266 589 01 63 00', 'MEOT HTA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '266 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1164, '700 589 00 31 00', '™zel el aleti', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '700 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1165, '278 589 00 09 00', 'Buji anahtar', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '278 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1166, '001 589 01 16 10', 'Yldz anahtar Binek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 01 16 10', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1168, '607 589 05 63 00', 'temel plaka Binek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '607 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1169, '642 589 05 63 00', 'montaj elemanBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '642 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1170, '654 589 00 09 00', 'lokma anahtarBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1171, '654 589 00 14 00', 'kovanBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1172, '654 589 00 21 00', 'ayar aletiBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1173, '654 589 00 31 00', 'montaj plakaBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1174, '654 589 00 40 00', 'tutma par‡aBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1175, '654 589 00 91 00', 'adapt”rBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1176, '654 589 01 40 00', 'tutma aletiBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1177, '654 589 01 43 00', '‡ektirmeBinek', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1178, '725 589 00 90 00', 'Ÿanzuman ya§ basma adat”r', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '725 589 00 90 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1179, '725 589 02 90 00', 'Binek Otomatik anzman Ya§ Seviyesi Ayarlama aparat', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '725 589 02 90 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1180, '129 589 01 21 00', 'Binek direksiyon sabitleme aparat', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 01 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1181, '000 589 02 21 00', 'GECE G™Rš KAMERASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 02 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1182, '470 589 01 07 00', 'TIRNAKLI ANAHTAR X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 01 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1183, '470 589 04 23 00', 'EL ALET˜ X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 04 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1184, '470 589 05 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 05 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1185, '470 589 06 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 06 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1187, '699 589 01 40 00', 'Kars Tutma PA X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '699 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1188, '699 589 00 40 00', 'Tutma Kilidi X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '699 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1189, '470 589 07 15 00', 'Malafa X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 07 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1190, '470 589 26 91 00', 'Adapt”r X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 26 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1191, '470 589 11 15 00', 'Malafa X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 11 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1192, '470 589 09 15 00', 'Malafa X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 09 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1193, '470 589 08 15 00', 'Malafa Seti X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 08 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1194, '470 589 12 15 00', 'Malafa Seti X CLASS B˜NEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 12 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1195, '001 589 00 40 00', 'SAP Par‡a', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1196, '725 589 00 59 00', 'S”kme Takma', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '725 589 00 59 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1197, '220 589 00 99 38', 'Kontrol Kablosu', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 00 99 38', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1199, 'Ka-Bo', 'QGK15202018-24H Servis Tamir Kiti', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', 'Ka-Bo', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1202, '246 589 01 33 00', 'W-246 589 01 33 00 SBC S™KET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '246 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1203, '715 589 05 21 00', '715 589 05 21 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '715 589 05 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1204, '211 589 03 21 00', '211 589 03 21 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 03 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1205, '435 589 00 21 00', '435 589 00 21 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '435 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1206, '425 589 00 15 00', '425 589 00 15 00 PKW-TORNAV˜DA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '425 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1207, '015 589 01 15 00', 'PKW-TORNAV˜DA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '015 589 01 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1208, '102 589 03 33 00', '102 589 03 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '102 589 03 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1209, '123 589 05 33 00', 'PKW-10 ALYAN', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '123 589 05 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1210, '901 589 00 63 00', '901 589 00 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '901 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1211, '000 589 05 07 00', 'W 000 589 05 07 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 05 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1212, '123 581 00 67 00', '123 581 00 67 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '123 581 00 67 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1213, '673 589 00 15 00', '673 589 00 15 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '673 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1214, '435 589 00 35 00', '435 589 00 35 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '435 589 00 35 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1215, '406 589 07 33 00', '406 589 07 33 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '406 589 07 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1216, '437 589 00 23 00', '437 589 00 23 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '437 589 00 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1217, '427 589 00 43 00', '427 589 00 43 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '427 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1218, '427 589 01 43 00', '427 589 01 43 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '427 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1219, '140 589 00 14 02', '140 589 00 14 02', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 00 14 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1220, '435 581 00 02 00', '435 581 00 02 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '435 581 00 02 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1221, '000 589 64 09 00', 'W 000 589 64 09 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 64 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1222, '437 589 01 37 00', '437 589 01 37 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '437 589 01 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1223, '385 589 04 63 00', '385 589 04 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '385 589 04 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1224, '000 589 45 31 00', 'W 000 589 45 31 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 45 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1225, '103 589 03 15 00', '103 589 03 15 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '103 589 03 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1226, '000 589 10 53 00', 'W 000 589 10 53 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 10 53 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1227, '203 589 02 43 01', '203 589 02 43 01', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 02 43 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1228, '168 589 04 14 00', '168 589 04 14 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 04 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1229, '202 589 00 07 00', '202 589 00 07 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 00 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1230, '129 589 06 23 00', '129 589 06 23 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 06 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1231, '112 589 02 31 00', '112 589 02 31 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 02 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1234, '111 589 08 43 01', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '111 589 08 43 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1236, '202 589 13 63 01', 'HELEZON €EKT˜RMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 13 63 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1237, '202 589 13 63 02', 'HELEZON €EKT˜RMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 13 63 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1238, '202 589 14 63 01', 'HELEZON €EKT˜RMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 14 63 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1239, '202 589 14 63 02', 'HELEZON €EKT˜RMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 14 63 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1240, '129 589 03 43 07', '™ZEL EL ALET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 03 43 07', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1241, '220 589 03 43 03', '™ZEL ALET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 03 43 03', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1242, '230 589 00 34 02', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '230 589 00 34 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1243, '202 589 04 43 01', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 04 43 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1244, '202 589 04 43 02', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 04 43 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1245, '638 589 03 33 03', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '638 589 03 33 03', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1246, '202 589 04 43 06', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 04 43 06', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1247, '202 589 04 43 07', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 04 43 07', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1248, '163 589 01 07 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '163 589 01 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1249, '617 589 04 21 00', 'HAVA ™L€ME VAKUM SAAT˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '617 589 04 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1250, '001 589 75 09 00', 'YILDIZ K™E 55', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 75 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1251, '168 589 03 43 03', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 03 43 03', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1252, '124 589 05 43 01', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '124 589 05 43 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1253, '210 589 00 43 06', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 00 43 06', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1254, 'A 000 092 47 08', 'A 000 092 47 08 KAPAKLI BASIN€ SAAT˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'A 000 092 47 08', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1255, '246 589 00 40 00', 'MAR AKIM SINIRLAYICISI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '246 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1256, '658 589 01 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '658 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1257, '000 589 55 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 55 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1258, '000 589 56 43 00', '™ZEL EL ALET', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 56 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1259, '724 589 00 33 00', 'OTOMAT˜K ANZ. €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '724 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1260, '724 589 01 33 00', 'OTOMAT˜K ANZ. €EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '724 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1261, '210 589 01 16 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '210 589 01 16 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1262, '117 589 03 23 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '117 589 03 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1263, '000 589 18 53 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 18 53 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1264, '000 589 16 33 00', '€EKT˜RME AYAKLARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 16 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1265, '001 589 71 21 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 71 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1266, '000 589 00 40 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 00 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1267, '126 589 02 62 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '126 589 02 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1268, '166 589 00 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '166 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1269, '168 589 00 43 01', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 00 43 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1270, '168 589 00 43 02', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 00 43 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1271, '168 589 05 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 05 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1272, '220 589 02 33 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 02 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1273, '168 589 03 43 10', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 03 43 10', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1274, '166 589 01 14 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '166 589 01 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1275, '230 589 00 34 01', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '230 589 00 34 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1276, '730 589 05 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '730 589 05 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1277, '730 589 01 43 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '730 589 01 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1278, '711 589 16 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '711 589 16 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1279, '715 589 00 34 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '715 589 00 34 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1280, '715 589 04 15 00', 'BURC', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '715 589 04 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1281, '406 589 08 61 00', 'BURC', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '406 589 08 61 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1282, '730 589 02 43 00', 'BURC', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '730 589 02 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1283, '168 589 00 90 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 00 90 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1284, '202 589 00 43 02', '€EKT˜RME', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '202 589 00 43 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1285, '271 589 00 91 00', 'D˜ZELHAVA KA€A¦I BULMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1286, '273 589 00 91 00', 'BENZ.HAVA KA€A¦I BULMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '273 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1287, '901 589 00 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '901 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1288, '220 328 02 79 00', '220 328 02 79 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 328 02 79 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1289, '140 589 11 63 00', 'ANZIMAN APARATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 11 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1290, '715 589 04 21 00', 'V˜TES KOLU AYAR APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '715 589 04 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1291, '000 589 49 37 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 49 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1292, '000 589 54 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 54 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1293, '000 589 53 43 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 53 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1294, '446 301 02 10', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '446 301 02 10', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL);
INSERT INTO `aletler` (`id`, `seri_no`, `adi`, `marka`, `model`, `durum`, `aciklama`, `olusturma_tarihi`, `guncelleme_tarihi`, `created_at`, `barkod`, `kategori`, `raf_no`, `silindi`, `raf_id`, `eklenme_tarihi`, `zimmetli_personel_id`) VALUES
(1295, '168 589 00 27 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 00 27 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1296, '168 589 01 27 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 01 27 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1297, '168 589 01 63 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1298, '168 589 02 23 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 02 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1299, '168 589 03 23 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 03 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1300, '203 589 01 23 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 01 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1301, '203 589 02 27 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 02 27 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1302, '203 589 07 22 00', 'APARAT', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '203 589 07 22 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1304, 'NFZ', 'CETAFORM  C˜TAN BALATA €EKT˜RMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'NFZ', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1305, '204 589 04 43 01', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 04 43 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1306, '204 589 04 43 02', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 04 43 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1307, '270 589 00 07 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 00 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1308, '270 589 01 07 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 01 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1309, '270 589 00 91 00', '™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '270 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1310, '111 018 03 02', 'SMART  ™ZEL EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '111 018 03 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1311, '622 004 10 09', 'SMART JAK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '622 004 10 09', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1312, '450 589 01 09 00', 'SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 01 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1313, '450 589 01 33 00', 'SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 01 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1314, '168 589 00 23 00', 'MOTOR SEHPASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '168 589 00 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1315, '450 589 11 21 00', 'SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 11 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1316, '204 589 03 43 02', '204 589 03 43 02', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 03 43 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1317, '450 589 07 09 00', '450 589 07 09 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 07 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1318, '451 589 00 09 00', 'E-10', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '451 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1319, '450 589 01 40 00', 'SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1320, '450 589 00 63 00', 'SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1321, '450 589 02 09 00', 'SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 02 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1322, 'PKW', '00015143V001000000 SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'PKW', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1324, '450 589 03 11 00', 'SMART', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 03 11 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1325, '450 589 04 21 00', '450 589 04 21 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '450 589 04 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1326, '699 589 00 05 00', 'KANCA ANAHTARI  X-CLASS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '699 589 00 05 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1327, '699 589 00 15 00', 'SšRšKLEME ALET˜  X-CLASS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '699 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1328, '699 589 02 40 00', 'AYARLAMA APARATI X-CLASS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '699 589 02 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1329, '699 589 03 40 00', 'TUTMA K˜L˜D˜  X-CLASS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '699 589 03 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1330, '204 589 02 63 02', 'KAPAK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '204 589 02 63 02', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1331, '470 589 10 15 00', 'MALAFA  X-CLASS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 589 10 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1332, '470 588 02 23 00', 'AYAR G™STERGES˜ X-CLASS', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 588 02 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1334, 'KABO', 'S˜L˜ND˜R KAPAK TEM˜ZLEME SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'KABO', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1338, '611 589 00 14 00', '€EKT˜REREK TAKMA ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 00 14 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1339, '116 589 00 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1340, '611 589 00 63 00', 'BA¦LANTI PAR€ASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '611 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1341, '716 589 03 33 00', '€IKARMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '716 589 03 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1342, '119 589 00 43 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '119 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1343, '112 589 09 61 00', 'MONTAJ EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '112 589 09 61 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1344, '220 589 04 99 38', 'K˜L˜T A€MA EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '220 589 04 99 38', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1345, '470 588 00 21 00', 'RADAR SENS™Rš AYAR G™STERGES˜09842-10-AYAR PANOSU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '470 588 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1346, '321 589 04 21 00', 'AYAR C˜HAZI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '321 589 04 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1347, '447 589 01 63 00', 'V˜N€ KOLU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '447 589 01 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1348, '285 589 00 21 00', '™ZEL EL ALET˜ B˜DON', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '285 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1349, '000 588 20 21 00', 'RADAR SENS™Rš H˜ZALAMA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 20 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1350, '000 588 00 99 00', 'Kemer tokas-Aksiyon aleti', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 00 99 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1351, '000 588 16 31 00', 'UYARLAMA ELAMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 16 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1352, '253 589 00 15 00', 'MALAFA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '253 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1355, 'MW177 589 00 09 00', 'LOKMA EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MW177 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1356, 'MW000 589 93 63 00 8', 'MONTAJ EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MW000 589 93 63 00 8', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1357, 'MW177 589 01 09 00', 'LOKMA ANAHTAR ELEMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MW177 589 01 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1358, 'MW254 589 00 23 00', 'SAB˜TLEME TERT˜BATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MW254 589 00 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1360, 'MW256 5489 02 31 00', 'MONTAJ EL ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MW256 5489 02 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1361, 'MW285 589 01 03 00', 'HALKA ANAHTAR ELEMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', 'MW285 589 01 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1362, '001 588 00 54 00', 'SEHPA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 588 00 54 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1363, '243 58902 43 00', '€EKME TAKMA ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '243 58902 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1365, '000 588 13 62 00', 'AGREGA YUVASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 13 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1366, '297 589 00 31 00', 'AC˜L DURUM TAKOZ SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '297 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1367, '000 588 14 62 00', 'UYARLAMA ELEMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 14 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1368, '243 588 00 32 00', 'BA¦LAMA PLAKALARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '243 588 00 32 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1369, '000 588 20 31 00', 'DAYAMA MALZEMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 20 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1372, '256 589 01 91 00', 'ADAPT™R', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '256 589 01 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1373, '271 589 09 63 00', 'MONTAJ ELEMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '271 589 09 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1374, '654 589 00 33 00', 'PER€˜N BASTIRMA ELEMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 33 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1375, '654 589 00 32 00', 'PLAKA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 32 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1377, '000 589 01 68 01', 'TEM˜ZLEME MALZEMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 01 68 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1379, '000 588 19 31 00', 'YšK TESP˜T NOKTASI MALZEMES˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 19 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1380, '170 589 04 63 00', 'DESTEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '170 589 04 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1381, '243 589 00 91 00', 'KONTROL KAPA¦I', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '243 589 00 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1382, '000 589 51 31 00', 'ADAPT™R', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 51 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1384, '000 589 48 31 00', 'TUTUCU', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 48 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1386, '211 589 00 31 00', 'ADAPTER', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '211 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1387, '000 588 07 19 00', '™L€šM C˜HAZI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 07 19 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1388, '654 589 03 21 00', 'AYAR ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 03 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1389, '642 589 02 63 00', 'V˜DALANAB˜L˜R PAR€A', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '642 589 02 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1391, '725 589 004000', 'TESPIT TERT˜BATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '725 589 004000', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1392, '116 589 0659 00', 'MONTAJ SEHPASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '116 589 0659 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1393, '140 589 34 63 00', 'W140589346300 TESP˜T PLKASI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 34 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1395, '000 588 00 62 00', 'CALASKA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 588 00 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1396, '722 589 00 31 00', 'MONTAJ ELEMANI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '722 589 00 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1397, '001 589 12 91 00', 'W 001 589 12 91 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 12 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1398, '293 589 00 23 00', '293 589 00 23 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '293 589 00 23 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1399, '715 589 22 15 00', 'W715 589 22 15 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '715 589 22 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1400, '000 589 95 63 00', 'W 000 589 95 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 95 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1401, '129 589 00 91 12', '129 589 00 91 12', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '129 589 00 91 12', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1402, '725 589 03 40 00', '725 589 03 40 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '725 589 03 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1403, '725 589 02 40 00', '725 589 02 40 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '725 589 02 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1404, '206 589 00 21 00', 'W206 589 00 21 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '206 589 00 21 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1405, '001 589 13 91 00', 'W 001 589 13 91 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 13 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1407, '454 589 00 37 00', '454 589 00 37 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '454 589 00 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1408, '001 589 06 91 00', 'W 001 589 06 91 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '001 589 06 91 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1409, '654 589 00 43 00', '654 589 00 43 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 00 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1410, '656 589 00 15 00', '656 589 00 15 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '656 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1411, '454 589 00 03 00', '454 589 00 03 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '454 589 00 03 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1412, '654 589 03 21 01', '654 589 03 21 01', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 03 21 01', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1413, '654 589 01 31 00', '654 589 01 31 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 01 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1415, '000 589 54 37 00', 'W 000 589 54 37 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '000 589 54 37 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1416, '140 589 00 63 00', '140 589 00 63 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '140 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1417, '608 589 01 40 00', '608 589 01 40 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '608 589 01 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1420, '447 589 01 31 00', 'ADAPT™R SET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '447 589 01 31 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1421, '654 589 03 40 00', 'KONTRA', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 03 40 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1422, '907 589 00 09 00', 'LOKMA ANAHTAR', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '907 589 00 09 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1423, '654 589 02 43 00', 'MONTAJ ALET˜', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '654 589 02 43 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1424, '447 589 00 62 00', 'TUTMA TERT˜BATI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '447 589 00 62 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1425, '447 589 00 63 00', 'DESTEK', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '447 589 00 63 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1427, '254 589 00 15 00', 'W254 589 00 15 00', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-07-02 14:17:26', '2025-03-17 08:23:39', '254 589 00 15 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1428, '470 589 02 07 00', 'OLUKLU SOMUN ANAHTARI', NULL, NULL, 'aktif', '', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '2025-03-17 08:23:39', '470 589 02 07 00', NULL, NULL, 0, NULL, '2025-03-17 08:23:39', NULL),
(1429, 'KaputDemiri', 'Kaput Demiri', 'Mercedes', NULL, 'aktif', NULL, '2025-05-03 06:17:22', '2025-05-03 06:17:22', '2025-05-03 06:17:22', 'Kaput Demiri', 'Özel Alet', 'B-1', 0, NULL, '2025-05-03 08:17:22', NULL),
(1430, '124589051900', 'Disk Kumpası', 'Meredes', NULL, 'aktif', NULL, '2025-05-03 06:21:19', '2025-05-03 06:21:19', '2025-05-03 06:21:19', '124589051900', 'Özel Alet', 'Dolap', 0, NULL, '2025-05-03 08:21:19', NULL),
(1431, 'lehimmakinesi', 'Lehim Makinesi', 'Ceta', NULL, 'aktif', NULL, '2025-05-03 08:49:34', '2025-05-03 08:52:12', '2025-05-03 08:49:34', 'lehimmakinesi', 'Elektrikli Alet', 'C2', 0, NULL, '2025-05-03 10:49:34', NULL),
(1432, '1686133680', 'DS Battery Tester', 'DS-ONE', NULL, 'aktif', NULL, '2025-05-06 07:22:44', '2025-05-06 07:22:44', '2025-05-06 07:22:44', '1686133680', 'DS Özel Alet', 'B-2', 0, NULL, '2025-05-06 09:22:44', NULL),
(1433, '123456789', '27 Lokma siyah', '/', NULL, 'aktif', NULL, '2025-05-15 06:49:21', '2025-05-15 06:49:21', '2025-05-15 06:49:21', '27lokma', 'El aleti', 'Lokma Standı', 0, NULL, '2025-05-15 08:49:21', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `calibrations`
--

CREATE TABLE `calibrations` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `calibration_date` datetime NOT NULL,
  `next_calibration_date` datetime NOT NULL,
  `certificate_no` varchar(50) DEFAULT NULL,
  `company` varchar(100) NOT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `damage_reports`
--

CREATE TABLE `damage_reports` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `work_order` varchar(50) DEFAULT NULL,
  `damage_description` text NOT NULL,
  `date_reported` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('reported','in_repair','repaired') DEFAULT 'reported'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `error_logs`
--

CREATE TABLE `error_logs` (
  `id` int(11) NOT NULL,
  `error_type` varchar(50) NOT NULL,
  `error_message` text NOT NULL,
  `additional_data` text DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hasar_tutanaklari`
--

CREATE TABLE `hasar_tutanaklari` (
  `id` int(11) NOT NULL,
  `tutanak_no` varchar(20) NOT NULL,
  `alet_id` int(11) NOT NULL,
  `personel_id` int(11) NOT NULL,
  `is_emri_no` varchar(50) DEFAULT NULL,
  `hasar_tarihi` date NOT NULL,
  `hasar_yeri` varchar(255) DEFAULT NULL,
  `hasar_turu` varchar(100) DEFAULT NULL,
  `hasar_nedeni` varchar(255) DEFAULT NULL,
  `hasar_aciklamasi` text DEFAULT NULL,
  `tahmini_maliyet` decimal(12,2) DEFAULT NULL,
  `durum` varchar(20) DEFAULT 'beklemede',
  `olusturma_tarihi` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `hasar_tutanaklari`
--

INSERT INTO `hasar_tutanaklari` (`id`, `tutanak_no`, `alet_id`, `personel_id`, `is_emri_no`, `hasar_tarihi`, `hasar_yeri`, `hasar_turu`, `hasar_nedeni`, `hasar_aciklamasi`, `tahmini_maliyet`, `durum`, `olusturma_tarihi`) VALUES
(1, '2025-07-001', 17, 1, '33AD0124', '2025-07-01', 'PKW Atölye', 'Fiziksel Hasar', 'Fazla kuvvet uygulanması', 'Çektirme aletinin tırnağı kırılmıştır', 12500.00, 'beklemede', '2025-07-01 11:24:40');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `is_emirleri`
--

CREATE TABLE `is_emirleri` (
  `id` int(11) NOT NULL,
  `is_emri_no` varchar(50) NOT NULL,
  `proje_adi` varchar(100) DEFAULT NULL,
  `baslama_tarihi` date DEFAULT NULL,
  `bitis_tarihi` date DEFAULT NULL,
  `durum` enum('devam_ediyor','tamamlandi','iptal') DEFAULT 'devam_ediyor',
  `aciklama` text DEFAULT NULL,
  `olusturma_tarihi` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `is_emirleri`
--

INSERT INTO `is_emirleri` (`id`, `is_emri_no`, `proje_adi`, `baslama_tarihi`, `bitis_tarihi`, `durum`, `aciklama`, `olusturma_tarihi`) VALUES
(1, '33AD0124', NULL, NULL, NULL, 'devam_ediyor', NULL, '2025-04-28 10:29:20');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kalibrasyon`
--

CREATE TABLE `kalibrasyon` (
  `id` int(11) NOT NULL,
  `alet_id` int(11) NOT NULL,
  `kalibrasyon_tarihi` date NOT NULL,
  `sonraki_kalibrasyon_tarihi` date NOT NULL,
  `sertifika_no` varchar(50) DEFAULT NULL,
  `firma` varchar(100) DEFAULT NULL,
  `aciklama` text DEFAULT NULL,
  `gecerlilik_suresi` int(11) NOT NULL DEFAULT 12
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `kalibrasyon`
--

INSERT INTO `kalibrasyon` (`id`, `alet_id`, `kalibrasyon_tarihi`, `sonraki_kalibrasyon_tarihi`, `sertifika_no`, `firma`, `aciklama`, `gecerlilik_suresi`) VALUES
(1, 1, '2024-01-01', '2026-01-01', 'KAL001', 'Kalibrasyon A.Ş.', '', 24),
(2, 2, '2024-02-01', '2025-02-01', 'KAL002', 'Kalibrasyon A.Ş.', NULL, 12),
(3, 3, '2024-03-01', '2025-03-01', 'KAL003', 'Kalibrasyon B Ltd.', NULL, 12),
(4, 4, '2024-04-01', '2025-04-01', 'KAL004', 'Kalibrasyon B Ltd.', NULL, 12),
(5, 5, '2025-06-24', '2026-06-24', 'KAL005', 'Kalibrasyon A.Ş.', '', 12);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `loans`
--

CREATE TABLE `loans` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `loan_date` datetime NOT NULL,
  `expected_return_date` datetime DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `status` enum('active','returned','overdue') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `related_id` int(11) DEFAULT NULL,
  `related_type` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'unread',
  `priority` varchar(20) DEFAULT 'normal',
  `created_at` datetime DEFAULT current_timestamp(),
  `read_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `odunc_islemler`
--

CREATE TABLE `odunc_islemler` (
  `id` int(11) NOT NULL,
  `alet_id` int(11) NOT NULL,
  `personel_id` int(11) NOT NULL,
  `verilis_tarihi` datetime NOT NULL,
  `planlanan_donus_tarihi` datetime NOT NULL,
  `gercek_donus_tarihi` datetime DEFAULT NULL,
  `durum` enum('devam','tamamlandi') DEFAULT 'devam',
  `aciklama` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `odunc_islemler`
--

INSERT INTO `odunc_islemler` (`id`, `alet_id`, `personel_id`, `verilis_tarihi`, `planlanan_donus_tarihi`, `gercek_donus_tarihi`, `durum`, `aciklama`) VALUES
(1, 1, 1, '2025-01-01 09:00:00', '2025-01-08 17:00:00', NULL, 'devam', NULL),
(2, 3, 2, '2025-01-02 10:00:00', '2025-01-09 17:00:00', NULL, 'devam', NULL),
(3, 5, 3, '2024-12-01 09:00:00', '2024-12-08 17:00:00', NULL, 'tamamlandi', NULL),
(4, 1, 4, '2024-11-01 09:00:00', '2024-11-08 17:00:00', NULL, 'tamamlandi', NULL),
(5, 3, 5, '2024-10-01 09:00:00', '2024-10-08 17:00:00', NULL, 'tamamlandi', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `odunc_kayitlari`
--

CREATE TABLE `odunc_kayitlari` (
  `id` int(11) NOT NULL,
  `alet_id` int(11) NOT NULL,
  `personel_id` int(11) NOT NULL,
  `verilis_tarihi` datetime NOT NULL,
  `iade_tarihi` datetime DEFAULT NULL,
  `verilis_yapan` int(11) DEFAULT NULL,
  `iade_alan` int(11) DEFAULT NULL,
  `notlar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `odunc_kayitlari`
--

INSERT INTO `odunc_kayitlari` (`id`, `alet_id`, `personel_id`, `verilis_tarihi`, `iade_tarihi`, `verilis_yapan`, `iade_alan`, `notlar`) VALUES
(1, 163, 1, '2025-01-15 10:48:15', '2025-01-20 08:53:22', NULL, NULL, NULL),
(2, 17, 1, '2025-01-17 10:49:41', '2025-01-17 15:09:54', NULL, NULL, NULL),
(3, 113, 2, '2025-01-17 10:49:52', '2025-01-17 12:21:28', NULL, NULL, NULL),
(4, 125, 4, '2025-01-17 15:09:42', '2025-02-08 08:04:24', NULL, NULL, NULL),
(5, 55, 4, '2025-01-20 08:53:36', '2025-02-21 11:01:02', NULL, NULL, NULL),
(6, 15, 1, '2025-02-04 11:35:36', '2025-02-08 08:04:30', NULL, NULL, NULL),
(7, 124, 1, '2025-02-08 08:04:12', '2025-02-17 06:12:10', NULL, NULL, NULL),
(8, 91, 4, '2025-02-08 08:04:58', '2025-02-17 06:12:04', NULL, NULL, NULL),
(9, 127, 5, '2025-02-13 07:23:46', '2025-02-17 06:11:59', NULL, NULL, NULL),
(10, 21, 2, '2025-02-20 08:05:54', '2025-03-25 13:06:04', NULL, NULL, NULL),
(11, 124, 2, '2025-02-20 08:06:18', '2025-03-25 13:06:08', NULL, NULL, NULL),
(12, 508, 2, '2025-02-20 08:06:38', '2025-03-25 13:06:13', NULL, NULL, NULL),
(13, 17, 1, '2025-02-20 08:06:51', '2025-03-25 13:06:17', NULL, NULL, NULL),
(14, 11, 2, '2025-02-22 07:05:24', '2025-02-22 07:05:52', NULL, NULL, NULL),
(15, 46, 4, '2025-03-03 07:01:42', '2025-05-03 09:54:09', NULL, NULL, NULL),
(16, 592, 2, '2025-03-26 00:27:00', '2025-05-03 09:54:16', NULL, NULL, NULL),
(17, 42, 2, '2025-04-15 08:40:38', '2025-05-03 09:54:20', NULL, NULL, NULL),
(18, 499, 4, '2025-04-30 12:06:39', '2025-05-03 09:54:23', NULL, NULL, NULL),
(19, 1429, 6, '2025-05-03 08:17:45', '2025-05-03 11:38:17', NULL, NULL, NULL),
(20, 1430, 6, '2025-05-03 08:21:32', '2025-05-03 10:16:04', NULL, NULL, NULL),
(21, 1430, 7, '2025-05-03 10:16:14', '2025-05-03 10:53:43', NULL, NULL, NULL),
(22, 1431, 8, '2025-05-03 10:52:48', '2025-05-03 12:02:40', NULL, NULL, NULL),
(23, 835, 9, '2025-05-05 14:28:13', '2025-05-05 16:43:12', NULL, NULL, NULL),
(24, 1429, 11, '2025-05-05 15:00:36', '2025-05-05 17:03:11', NULL, NULL, NULL),
(25, 189, 12, '2025-05-05 15:19:12', '2025-05-05 16:33:23', NULL, NULL, NULL),
(26, 115, 15, '2025-05-06 08:57:04', '2025-05-06 10:42:38', NULL, NULL, NULL),
(27, 499, 6, '2025-05-06 08:57:40', '2025-05-06 10:42:43', NULL, NULL, NULL),
(28, 1432, 17, '2025-05-06 09:25:57', '2025-05-06 09:49:00', NULL, NULL, NULL),
(29, 194, 1, '2025-05-06 09:29:51', '2025-05-06 09:30:00', NULL, NULL, NULL),
(30, 1429, 18, '2025-05-06 10:36:24', '2025-05-06 15:14:31', NULL, NULL, NULL),
(31, 835, 19, '2025-05-06 12:11:59', '2025-05-07 09:28:03', NULL, NULL, NULL),
(32, 1430, 20, '2025-05-06 13:35:26', '2025-05-06 13:44:42', NULL, NULL, NULL),
(33, 120, 2, '2025-05-06 13:50:51', '2025-05-07 09:55:42', NULL, NULL, NULL),
(34, 1429, 11, '2025-05-07 07:59:47', '2025-05-08 10:42:46', NULL, NULL, NULL),
(35, 172, 19, '2025-05-07 09:22:00', '2025-05-14 10:13:43', NULL, NULL, NULL),
(36, 561, 2, '2025-05-09 10:14:43', '2025-06-24 08:26:13', NULL, NULL, NULL),
(37, 1433, 12, '2025-05-15 08:49:37', '2025-06-24 16:28:04', NULL, NULL, NULL),
(38, 15, 2, '2025-06-12 12:18:22', NULL, NULL, NULL, NULL),
(39, 40, 2, '2025-06-18 15:05:42', NULL, NULL, NULL, NULL),
(40, 20, 1, '2025-06-24 08:26:24', NULL, NULL, NULL, NULL),
(41, 1231, 1, '2025-06-24 11:07:34', NULL, NULL, NULL, NULL),
(42, 626, 1, '2025-06-24 11:08:17', NULL, NULL, NULL, NULL),
(43, 60, 2, '2025-06-24 11:10:10', NULL, NULL, NULL, NULL),
(44, 1401, 1, '2025-06-24 11:18:07', NULL, NULL, NULL, NULL),
(45, 1212, 20, '2025-06-24 11:20:56', NULL, NULL, NULL, NULL),
(46, 11, 20, '2025-06-24 11:20:57', NULL, NULL, NULL, NULL),
(47, 1219, 40, '2025-06-24 15:16:34', '2025-06-25 10:35:16', NULL, NULL, NULL),
(48, 1222, 19, '2025-06-25 10:36:05', NULL, NULL, NULL, NULL),
(49, 992, 19, '2025-06-25 10:37:06', NULL, NULL, NULL, NULL),
(50, 990, 19, '2025-06-25 10:37:06', NULL, NULL, NULL, NULL),
(51, 675, 19, '2025-06-25 10:37:06', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `personel`
--

CREATE TABLE `personel` (
  `id` int(11) NOT NULL,
  `sicil_no` varchar(50) NOT NULL,
  `ad` varchar(50) NOT NULL,
  `soyad` varchar(50) NOT NULL,
  `departman` varchar(100) DEFAULT NULL,
  `unvan` varchar(100) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `personel`
--

INSERT INTO `personel` (`id`, `sicil_no`, `ad`, `soyad`, `departman`, `unvan`, `telefon`, `email`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '1001', 'Ahmet Yılmaz', '', 'Üretim', NULL, '5551234567', 'ahmet.yilmaz@firma.com', 'active', '2025-04-14 13:20:10', '2025-04-28 14:33:40', NULL),
(2, '1002', 'Mehmet Kaya', '', 'Bakım', NULL, '5557654321', 'mehmet.kaya@firma.com', 'active', '2025-04-14 13:20:10', '2025-04-28 14:33:40', NULL),
(3, '1003', 'Ayşe Demir', '', 'Kalite', NULL, '5559876543', 'ayse.demir@firma.com', 'active', '2025-04-14 13:20:10', '2025-04-28 14:33:40', NULL),
(4, '0010', 'Salih', 'Deniz', 'HTA', 'Teknik Personel', NULL, 'salih@salih.com', 'active', '2025-04-29 07:47:02', '2025-04-29 07:47:02', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `phinxlog`
--

CREATE TABLE `phinxlog` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `racks`
--

CREATE TABLE `racks` (
  `id` int(11) NOT NULL,
  `rack_code` varchar(50) NOT NULL,
  `floor` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `racks`
--

INSERT INTO `racks` (`id`, `rack_code`, `floor`, `section`, `description`, `created_at`, `updated_at`) VALUES
(1, 'A-01', 'Zemin', 'A Bölümü', 'El aletleri rafı', '2025-04-14 13:20:10', NULL),
(2, 'B-01', 'Zemin', 'B Bölümü', 'Ölçüm aletleri rafı', '2025-04-14 13:20:10', NULL),
(3, 'C-01', 'Kat 1', 'C Bölümü', 'Kesici aletler rafı', '2025-04-14 13:20:10', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `raflar`
--

CREATE TABLE `raflar` (
  `id` int(11) NOT NULL,
  `kod` varchar(50) NOT NULL,
  `aciklama` text DEFAULT NULL,
  `eklenme_tarihi` datetime DEFAULT current_timestamp(),
  `guncelleme_tarihi` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `raflar`
--

INSERT INTO `raflar` (`id`, `kod`, `aciklama`, `eklenme_tarihi`, `guncelleme_tarihi`) VALUES
(1, 'BİNEK 1/1', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(2, 'BİNEK 1/2', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(3, 'BİNEK 1/3', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(4, 'BİNEK 1/4', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(5, 'BİNEK 1/5', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(6, 'BİNEK 1/6', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(7, 'BİNEK 1/7', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(8, 'BİNEK 1/8', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(9, 'BİNEK 2/1', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(10, 'BİNEK 2/2', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(11, 'BİNEK 2/3', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(12, 'BİNEK PAKET', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(13, 'BİNEK 3/1', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(14, 'EQ Dolap', NULL, '2025-01-14 22:34:47', '2025-01-14 22:34:47'),
(15, '213', NULL, '2025-02-07 12:45:21', '2025-02-07 12:45:21'),
(16, '203', NULL, '2025-02-07 12:45:21', '2025-02-07 12:45:21'),
(17, '124', NULL, '2025-02-07 12:45:21', '2025-02-07 12:45:21'),
(18, '114', NULL, '2025-02-07 12:45:21', '2025-02-07 12:45:21'),
(19, ';;;', NULL, '2025-02-07 12:45:21', '2025-02-07 12:45:21'),
(20, '715 589 15 34 00 hidrolik silindir', NULL, '2025-02-07 12:45:21', '2025-02-07 12:45:21'),
(21, 'BİNEK 3/2', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(22, 'BİNEK 3/3', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(23, 'BİNEK 3/4', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(24, 'BİNEK 3/5', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(25, 'BİNEK 3/ORTA', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(26, 'BİNEK 3/SON', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(27, 'BİNEK 2/SON', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(28, 'ORTA / ÇANTA', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(29, 'ORTA / HTA', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(30, 'NFZ 1', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(31, 'Çekmece', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(32, 'NFZ 2', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(33, 'NFZ 4', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(34, 'NFZ Koridor', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(35, 'NFZ 3', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(36, 'C4', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(37, 'C1', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(38, 'Lokma dolabı', NULL, '2025-02-07 13:01:41', '2025-02-07 13:01:41'),
(39, 'PANO-1', NULL, '2025-03-17 08:23:38', '2025-03-17 08:23:38'),
(40, 'PANO-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(41, 'PANO-3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(42, 'PANO-3 A-7 B-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(43, 'A-2 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(44, 'A-5', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(45, 'PANO-1 A-5', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(46, 'A-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(47, 'A-6', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(48, 'PANO-4', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(49, 'A-1 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(50, 'BšYšK PANO RAF-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(51, 'BšYšK PANO-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(52, 'B-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(53, 'A-9', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(54, 'A-3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(55, 'C-4 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(56, 'A-2--B-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(57, 'A-8', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(58, 'B-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(59, 'A-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(60, 'BšYšK PAMO-1 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(61, 'A-4', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(62, 'BšYšK  PANO-1 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(63, 'Kš€šK PANO-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(64, 'A-2+A-9', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(65, 'A-3---B-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(66, 'B-4', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(67, 'B-6', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(68, 'Kš€šK PANO-šST RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(69, 'Kš€šK PANO  RAF-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(70, 'A.5', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(71, 'UN˜MOG    PANO-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(72, 'BšYšK   PANO-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(73, 'A-7', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(74, 'UN˜MOG   PANO-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(75, 'BšYšK PANO-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(76, 'C-3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(77, 'UN˜MOG    PANO-3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(78, 'MEPANO-4', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(79, 'UN˜MOG   PANO-3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(80, 'A-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(81, 'PANO3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(82, 'UN˜MOG    PANO-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(83, 'A-9 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(84, 'UN˜MOG     PANO-3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(85, 'B-5', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(86, 'PANO-1 VE B-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(87, 'A-5 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(88, 'PANO -4', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(89, 'BšYšK PANO-1 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(90, 'UNMOG 3.PANO ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(91, 'BšYšK PANO-2 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(92, 'A-5--A-9 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(93, 'BšYšK  PANO-1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(94, 'A-5---B-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(95, 'A-4 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(96, 'B-2---B-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(97, 'A-6. RAF ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(98, 'Kš€šK PANO 1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(99, 'B-3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(100, 'Kš€šK PANO-1 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(101, 'A-4--B-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(102, 'A-8+A-9 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(103, 'A-6 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(104, 'NFZ Raf Yeri:Sa§ Raf-4-EnSonda', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(105, 'UN˜MOG PANO-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(106, 'HAZET   PANO-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(107, 'Kš€šK PANO 2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(108, 'Kš€šK PANO-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(109, 'Kš€šK PANO 3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(110, 'A-5-UN˜MOG P2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(111, 'PANO-3  A-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(112, 'Kš€šK PANO šST RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(113, 'UN˜MOG PANO-3 ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(114, 'A-4.', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(115, 'MASA 2.€EKMECE', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(116, 'C-2', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(117, 'B-3 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(118, 'B-6 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(119, 'A9 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(120, 'A9RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(121, 'A4 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(122, 'A4RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(123, 'C2RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(124, 'B˜NEK ATOLYE', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(125, 'A3 RAF ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(126, 'B4 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(127, 'B-2 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(128, 'TšRKER˜N ODASI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(129, 'B˜NEK ATA™LYES˜', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(130, 'PANO 3', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(131, 'A2 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(132, 'PANO 1', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(133, 'A3 RAF ARKASI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(134, 'A3 ARKASI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(135, 'B3 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(136, 'A6 RAF ALTI', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(137, 'B6 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39'),
(138, 'B.6 RAF', NULL, '2025-03-17 08:23:39', '2025-03-17 08:23:39');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `raf_listesi`
--

CREATE TABLE `raf_listesi` (
  `id` int(11) NOT NULL,
  `adi` varchar(100) NOT NULL,
  `konum` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `raf_listesi`
--

INSERT INTO `raf_listesi` (`id`, `adi`, `konum`) VALUES
(1, 'C-1', 'Tarsus'),
(2, 'C-2', 'Tarsus'),
(3, 'C-3', 'Tarsus'),
(4, 'C-4', 'Tarsus');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `tutanak_id` int(11) DEFAULT NULL,
  `service_no` varchar(50) NOT NULL,
  `company` varchar(100) NOT NULL,
  `send_date` datetime NOT NULL,
  `completion_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `expected_return_date` datetime DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `status` enum('waiting','in_service','completed','cancelled') NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `services`
--

INSERT INTO `services` (`id`, `tool_id`, `tutanak_id`, `service_no`, `company`, `send_date`, `completion_date`, `notes`, `expected_return_date`, `return_date`, `cost`, `status`, `description`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '2221114455', 'teknik servis a.ş', '2025-04-14 00:00:00', NULL, NULL, '2025-04-21 00:00:00', NULL, 2000.00, 'completed', 'cevap bekleniyor', '2025-04-14 20:52:27', '2025-05-02 11:14:23'),
(3, 2, 3, '2221114455', 'teknik servis a.ş', '2025-04-28 00:00:00', NULL, NULL, '2025-05-15 00:00:00', NULL, 5700.00, 'completed', '', '2025-04-28 11:10:33', '2025-04-29 10:28:14');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `service_records`
--

CREATE TABLE `service_records` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `service_provider` varchar(100) DEFAULT NULL,
  `send_date` timestamp NULL DEFAULT current_timestamp(),
  `expected_return_date` date DEFAULT NULL,
  `actual_return_date` timestamp NULL DEFAULT NULL,
  `estimated_cost` decimal(10,2) DEFAULT NULL,
  `actual_cost` decimal(10,2) DEFAULT NULL,
  `service_description` text DEFAULT NULL,
  `status` enum('sent','in_progress','completed','delayed') DEFAULT 'sent'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `servis_islemler`
--

CREATE TABLE `servis_islemler` (
  `id` int(11) NOT NULL,
  `tutanak_id` int(11) NOT NULL,
  `firma` varchar(100) NOT NULL,
  `gonderim_tarihi` date NOT NULL,
  `tahmini_donus_tarihi` date DEFAULT NULL,
  `gercek_donus_tarihi` date DEFAULT NULL,
  `servis_no` varchar(50) DEFAULT NULL,
  `maliyet` decimal(10,2) DEFAULT 0.00,
  `durum` enum('servise_gonderildi','serviste','onarildi','onarilamaz','pert') DEFAULT 'servise_gonderildi',
  `servis_aciklama` text DEFAULT NULL,
  `olusturma_tarihi` timestamp NULL DEFAULT current_timestamp(),
  `guncelleme_tarihi` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `servis_islemler`
--

INSERT INTO `servis_islemler` (`id`, `tutanak_id`, `firma`, `gonderim_tarihi`, `tahmini_donus_tarihi`, `gercek_donus_tarihi`, `servis_no`, `maliyet`, `durum`, `servis_aciklama`, `olusturma_tarihi`, `guncelleme_tarihi`) VALUES
(1, 11, 'Teknik Servis A.Ş', '2025-03-04', '2025-03-11', NULL, '5527014554', 0.00, 'servise_gonderildi', 'Gitti bekliyoruz', '2025-03-04 11:51:19', '2025-03-04 11:51:19'),
(2, 11, 'Teknik Servis A.Ş', '2025-03-04', '2025-03-11', NULL, '5527014554', 0.00, 'servise_gonderildi', 'Gitti gelicek inş.', '2025-03-04 12:23:13', '2025-03-04 12:23:13'),
(3, 11, 'Teknik Servis A.Ş.', '2025-03-04', '2025-03-11', NULL, '123324', 0.00, 'servise_gonderildi', 'sdfsfsd', '2025-03-04 12:47:36', '2025-03-04 12:47:36'),
(4, 10, 'Teknik Servis A.Ş.', '2025-03-04', '2025-03-11', NULL, '123324', 0.00, 'servise_gonderildi', 'sdfsfsd', '2025-03-04 12:49:03', '2025-03-04 12:49:03'),
(5, 10, 'Teknik Servis A.Ş.', '2025-03-04', '2025-03-11', NULL, '55222233344', 0.00, 'servise_gonderildi', 'Gelecek inşallah', '2025-03-04 12:56:37', '2025-03-04 12:56:37'),
(6, 8, 'ARG KİMYEVİ TEKNOLOJİK YAPI MALZ. VE İNŞ. TAAH. LTD. ŞTİ.', '2025-03-12', '2025-03-19', NULL, '05527012122', 0.00, 'servise_gonderildi', 'dfgrret', '2025-03-12 06:16:30', '2025-03-12 06:16:30'),
(7, 7, 'ARG KİMYEVİ TEKNOLOJİK YAPI MALZ. VE İNŞ. TAAH. LTD. ŞTİ.', '2025-03-12', '2025-03-30', NULL, '05527012122', 0.00, 'servise_gonderildi', 'ertert34', '2025-03-12 06:17:27', '2025-03-12 06:17:27'),
(8, 7, 'Teknik Servis A.Ş', '2025-03-25', '2025-04-25', NULL, '55878556', 0.00, 'servise_gonderildi', 'Uzaya gitti gelicek', '2025-03-25 10:38:54', '2025-03-25 10:38:54'),
(9, 6, 'ARG KİMYEVİ TEKNOLOJİK YAPI MALZ. VE İNŞ. TAAH. LTD. ŞTİ.', '2025-05-09', '2025-05-30', NULL, '', 0.00, 'servise_gonderildi', '', '2025-05-09 08:13:11', '2025-05-09 08:13:11'),
(10, 6, 'ARG KİMYEVİ TEKNOLOJİK YAPI MALZ. VE İNŞ. TAAH. LTD. ŞTİ.', '2025-05-15', '2025-05-29', NULL, '', 0.00, 'servise_gonderildi', '', '2025-05-15 06:50:22', '2025-05-15 06:50:22');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `servis_takip`
--

CREATE TABLE `servis_takip` (
  `id` int(11) NOT NULL,
  `servis_islem_id` int(11) NOT NULL,
  `tarih` datetime NOT NULL,
  `durum` varchar(50) NOT NULL,
  `aciklama` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tools`
--

CREATE TABLE `tools` (
  `id` int(11) NOT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `serial_no` varchar(50) NOT NULL,
  `qr_code_path` varchar(255) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `rack_id` int(11) DEFAULT NULL,
  `status` enum('active','passive','in_service','in_calibration','damaged') NOT NULL,
  `calibration_required` tinyint(1) NOT NULL DEFAULT 0,
  `last_calibration_date` datetime DEFAULT NULL,
  `next_calibration_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `tools`
--

INSERT INTO `tools` (`id`, `barcode`, `serial_no`, `qr_code_path`, `name`, `brand`, `model`, `category`, `rack_id`, `status`, `calibration_required`, `last_calibration_date`, `next_calibration_date`, `created_at`, `updated_at`, `qr_code`, `deleted_at`) VALUES
(1, 'T001', 'ST12345', NULL, 'Tornavida Set', 'Stanley', 'STHT0-62113', 'El Aleti', 1, '', 0, NULL, NULL, '2025-04-14 13:20:10', NULL, NULL, NULL),
(2, 'T002', 'FL98765', NULL, 'Dijital Multimetre', 'Fluke', '87V', 'Ölçüm Cihazı', 2, '', 1, '2025-05-02 00:00:00', '2026-05-02 00:00:00', '2025-04-14 13:20:10', '2025-05-02 11:58:42', NULL, NULL),
(3, 'T003', 'BS45678', NULL, 'Açılı Taşlama', 'Bosch', 'GWS 7-115', 'Elektrikli El Aleti', 3, 'active', 0, NULL, NULL, '2025-04-14 13:20:10', '2025-05-02 11:14:23', NULL, NULL),
(211, 'W415589009100', 'W415589009100', NULL, 'Kontrol Bağlantısı', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(212, 'W654589000900', 'W654589000900', NULL, 'Lokma anahtarı', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(213, 'W607589044300', 'W607589044300', NULL, 'Takma el aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(214, 'W607589014300', 'W607589014300', NULL, 'Çektirme', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(215, 'W7000589003100', 'W7000589003100', NULL, 'Çektirme', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(216, 'W470589010700', 'W470589010700', NULL, 'Tırnaklı Anahtar', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(217, 'W259589001502', 'W259589001502', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(218, 'W700589011400', 'W700589011400', NULL, 'Kovan', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(219, 'W607589011500', 'W607589011500', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(220, 'W415589006300', 'W415589006300', NULL, 'Bilgi Yok', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(221, 'W626589034000', 'W626589034000', NULL, 'Tutma kilidi', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(222, 'Bilgi Yok', 'Bilgi Yok', NULL, 'STETESKOP', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(223, 'W415589003300', 'W415589003300', NULL, 'Çektirme', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(224, 'W470589051500', 'W470589051500', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(225, 'W607589054300', 'W607589054300', NULL, 'Takma el aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(226, 'W654589003201', 'W654589003201', NULL, 'Plaka', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(227, 'W700589081500', 'W700589081500', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(228, 'W607589024000', 'W607589024000', NULL, 'Tutma kilidi', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(229, 'W626589004000', 'W626589004000', NULL, 'Karşı tutucu', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(230, 'W203589014301 -02', 'W203589014301 -02', NULL, 'Çektirerek sökme ve takma el aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(231, 'W700589021500', 'W700589021500', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(232, 'W240589009100', 'W240589009100', NULL, 'EHB- ADAPTÖR', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(233, 'W700589011500', 'W700589011500', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(234, 'W700589091500', 'W700589091500', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(235, 'W700589001500', 'W700589001500', NULL, 'Malafa', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(236, 'W700589001400', 'W700589001400', NULL, 'Lokma anahtarı', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(237, 'W626589014000', 'W626589014000', NULL, 'Tutma kilidi', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(238, 'W1105890000100', 'W1105890000100', NULL, 'Rekor anahtarı', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(239, 'W642589003100', 'W642589003100', NULL, 'Aşağıda tutma aleti seti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(240, 'W270589016100', 'W270589016100', NULL, 'Tutma Tertibatı', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(241, 'W220589044301', 'W220589044301', NULL, 'Takma el aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(242, 'W164589004300', 'W164589004300', NULL, 'Çektirerek sökme ve takma el aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(243, 'W700589161500', 'W700589161500', NULL, 'Malafa / Prizdirek', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(244, 'W607589003102', 'W607589003102', NULL, 'Adapsyon', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(245, 'W166589004300', 'W166589004300', NULL, 'Çektirerek sökme ve takma el aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(246, 'W163589004300 /04', 'W163589004300 /04', NULL, 'Presleyerek sökme ve takma aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(247, 'W607589034300', 'W607589034300', NULL, 'Takma el aleti', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(248, 'W270589029100', 'W270589029100', NULL, 'Bağlantı Adaptörü', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(249, 'W129589010900', 'W129589010900', NULL, 'Geçmeli kovan', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(250, 'W607058929100', 'W607058929100', NULL, 'Vidalanabilir parça', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(251, 'W607589019100', 'W607589019100', NULL, 'ADAPTÖR', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(252, 'W654589003202', 'W654589003202', NULL, 'PLAKA', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(253, 'W646589022100', 'W646589022100', NULL, '1240 bar test adaptörü', 'MERCEDES', 'NONE', 'El Aleti', NULL, 'active', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2025-04-29 07:31:50', '2025-05-05 15:05:21', NULL, NULL),
(254, 'W642589026309', 'W642589026309', NULL, 'ADAPTÖR', 'MERCEDES', 'NONE', 'El Aleti', NULL, '', 0, NULL, NULL, '2025-04-29 07:31:50', '2025-04-29 07:31:50', NULL, NULL),
(255, 'T54824723', '123456', NULL, 'özel alet', 'yok', 'yok', 'Diğer', 1, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2025-05-02 10:43:00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tool_transactions`
--

CREATE TABLE `tool_transactions` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkout_date` timestamp NULL DEFAULT current_timestamp(),
  `expected_return_date` date NOT NULL,
  `return_date` timestamp NULL DEFAULT NULL,
  `status` enum('active','returned','overdue') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('admin','user') NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `surname`, `department`, `email`, `role`, `active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', '$2y$10$mAYEkO24V/aTMe1DtX52neOxr0l66i7Rlpc9QFdIqTsrUYZtUFsQK', 'Sistem Yöneticisi', NULL, NULL, 'admin@takimhane.local', 'admin', 1, '2025-04-14 13:20:10', NULL, NULL);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `aletler`
--
ALTER TABLE `aletler`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `seri_no` (`seri_no`),
  ADD KEY `raf_id` (`raf_id`),
  ADD KEY `zimmetli_personel_id` (`zimmetli_personel_id`);

--
-- Tablo için indeksler `calibrations`
--
ALTER TABLE `calibrations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tool_id` (`tool_id`);

--
-- Tablo için indeksler `damage_reports`
--
ALTER TABLE `damage_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tool_id` (`tool_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_damage_status` (`status`);

--
-- Tablo için indeksler `error_logs`
--
ALTER TABLE `error_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `error_type` (`error_type`),
  ADD KEY `created_at` (`created_at`);

--
-- Tablo için indeksler `hasar_tutanaklari`
--
ALTER TABLE `hasar_tutanaklari`
  ADD PRIMARY KEY (`id`),
  ADD KEY `personel_id` (`personel_id`),
  ADD KEY `hasar_tutanaklari_ibfk_1` (`alet_id`);

--
-- Tablo için indeksler `is_emirleri`
--
ALTER TABLE `is_emirleri`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `is_emri_no` (`is_emri_no`);

--
-- Tablo için indeksler `kalibrasyon`
--
ALTER TABLE `kalibrasyon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alet_id` (`alet_id`);

--
-- Tablo için indeksler `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tool_id` (`tool_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Tablo için indeksler `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`),
  ADD KEY `created_at` (`created_at`);

--
-- Tablo için indeksler `odunc_islemler`
--
ALTER TABLE `odunc_islemler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alet_id` (`alet_id`),
  ADD KEY `personel_id` (`personel_id`);

--
-- Tablo için indeksler `odunc_kayitlari`
--
ALTER TABLE `odunc_kayitlari`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alet_id` (`alet_id`),
  ADD KEY `personel_id` (`personel_id`),
  ADD KEY `verilis_yapan` (`verilis_yapan`),
  ADD KEY `iade_alan` (`iade_alan`);

--
-- Tablo için indeksler `personel`
--
ALTER TABLE `personel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sicil_no` (`sicil_no`);

--
-- Tablo için indeksler `phinxlog`
--
ALTER TABLE `phinxlog`
  ADD PRIMARY KEY (`version`);

--
-- Tablo için indeksler `racks`
--
ALTER TABLE `racks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rack_code` (`rack_code`);

--
-- Tablo için indeksler `raf_listesi`
--
ALTER TABLE `raf_listesi`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tool_id` (`tool_id`),
  ADD KEY `tutanak_id` (`tutanak_id`);

--
-- Tablo için indeksler `tools`
--
ALTER TABLE `tools`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `serial_no` (`serial_no`),
  ADD UNIQUE KEY `barcode` (`barcode`),
  ADD KEY `rack_id` (`rack_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `aletler`
--
ALTER TABLE `aletler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1434;

--
-- Tablo için AUTO_INCREMENT değeri `calibrations`
--
ALTER TABLE `calibrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `error_logs`
--
ALTER TABLE `error_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `hasar_tutanaklari`
--
ALTER TABLE `hasar_tutanaklari`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `is_emirleri`
--
ALTER TABLE `is_emirleri`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `personel`
--
ALTER TABLE `personel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `racks`
--
ALTER TABLE `racks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `raf_listesi`
--
ALTER TABLE `raf_listesi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `tools`
--
ALTER TABLE `tools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `calibrations`
--
ALTER TABLE `calibrations`
  ADD CONSTRAINT `calibrations_ibfk_1` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `hasar_tutanaklari`
--
ALTER TABLE `hasar_tutanaklari`
  ADD CONSTRAINT `hasar_tutanaklari_ibfk_1` FOREIGN KEY (`alet_id`) REFERENCES `aletler` (`id`),
  ADD CONSTRAINT `hasar_tutanaklari_ibfk_2` FOREIGN KEY (`personel_id`) REFERENCES `personel` (`id`);

--
-- Tablo kısıtlamaları `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`),
  ADD CONSTRAINT `loans_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `loans_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `personel` (`id`);

--
-- Tablo kısıtlamaları `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`tutanak_id`) REFERENCES `hasar_tutanaklari` (`id`) ON DELETE SET NULL;

--
-- Tablo kısıtlamaları `tools`
--
ALTER TABLE `tools`
  ADD CONSTRAINT `tools_ibfk_1` FOREIGN KEY (`rack_id`) REFERENCES `racks` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
