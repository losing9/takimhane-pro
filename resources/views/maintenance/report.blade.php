<!DOCTYPE html>
<html lang="tr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Arıza Tespit Tutanağı - {{ $maintenance->tool->serial_number }}</title>
    <style>
        body { 
            font-family: 'DejaVu Sans', sans-serif; 
            font-size: 14px; 
            color: #333; 
            margin: 0;
            padding: 0;
        }
        .page { 
            width: 100%; 
            margin: 0 auto; 
            background: white; 
            padding: 40px; 
        }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        td { padding: 8px; border-bottom: 1px solid #eee; }
        h1 { 
            font-size: 20px; 
            text-transform: uppercase; 
            border-bottom: 2px solid #333; 
            padding-bottom: 15px; 
            margin-bottom: 40px; 
            text-align: center; 
        }
        .status-box { 
            padding: 4px 8px; 
            border-radius: 4px; 
            font-weight: bold; 
            text-transform: uppercase; 
            color: #dc2626; 
        }
        .description-box { 
            background: #f8fafc; 
            padding: 15px; 
            border: 1px solid #e2e8f0; 
            border-radius: 5px; 
            min-height: 100px; 
            margin-bottom: 30px; 
            font-size: 13px; 
            line-height: 1.6; 
        }
        .result-box { 
            border: 1px solid #e2e8f0; 
            border-radius: 5px; 
            height: 120px; 
            margin-bottom: 30px; 
        }
        .signatures { 
            margin-top: 60px; 
            width: 100%; 
            page-break-inside: avoid;
        }
        .signature-box { 
            float: left; 
            width: 33.33%; 
            text-align: center; 
        }
        .signature-line { 
            border-top: 1px solid #94a3b8; 
            width: 80%; 
            margin: 50px auto 0; 
            font-size: 10px; 
            color: #64748b; 
            padding-top: 5px; 
        }
        .footer { 
            position: fixed; 
            bottom: 20px; 
            left: 0; 
            width: 100%; 
            text-align: center; 
            font-size: 10px; 
            color: #94a3b8; 
        }
        .clearfix::after { content: ""; clear: both; display: table; }
    </style>
</head>
<body>
    <div class="page">
        <!-- Header -->
        <h1>
            ARIZA / HASAR TESPİT TUTANAĞI <br>
            <span style="font-size:12px; font-weight:normal; text-transform:none; color:#666;">
                {{ \App\Models\Workshop::find($maintenance->workshop_id)->name ?? 'Takımhane' }}
            </span>
        </h1>

        <!-- Date & No -->
        <table style="margin-bottom: 30px;">
            <tr>
                <td><strong>Referans No:</strong> #{{ $maintenance->id }}</td>
                <td style="text-align: right;"><strong>Tarih:</strong> {{ $maintenance->created_at->format('d.m.Y') }}</td>
            </tr>
        </table>

        <!-- Tool Information -->
        <h3 style="font-size:14px; text-transform:uppercase; border-bottom:1px solid #ccc; padding-bottom:5px; color:#666;">Ekipman Bilgileri</h3>
        <table>
            <tr>
                <td width="30%"><strong>Ekipman Adı:</strong></td>
                <td>{{ $maintenance->tool->name }}</td>
            </tr>
            <tr>
                <td><strong>Seri Numarası:</strong></td>
                <td>{{ $maintenance->tool->serial_number }}</td>
            </tr>
            <tr>
                <td><strong>Marka / Model:</strong></td>
                <td>{{ $maintenance->tool->brand }} / {{ $maintenance->tool->model }}</td>
            </tr>
            <tr>
                <td><strong>Mevcut Durum:</strong></td>
                <td>
                    <span class="status-box">
                        {{ $maintenance->status == 'pending' ? 'Bekliyor' : ($maintenance->status == 'in_progress' ? 'İşlemde' : 'Tamamlandı') }}
                    </span>
                </td>
            </tr>
        </table>

        <!-- Fault Description -->
        <h3 style="font-size:14px; text-transform:uppercase; border-bottom:1px solid #ccc; padding-bottom:5px; color:#666; margin-top: 20px;">Arıza / Hasar Tanımı</h3>
        <div class="description-box">
            {{ $maintenance->description }}
        </div>

        <!-- Additional Notes / Result -->
        <h3 style="font-size:14px; text-transform:uppercase; border-bottom:1px solid #ccc; padding-bottom:5px; color:#666; margin-top: 20px;">Tespit ve Sonuç</h3>
        <div class="result-box" style="padding: 10px; font-size: 13px; line-height: 1.6;">
            {{ $maintenance->result }}
        </div>

        <!-- Signatures -->
        <div class="signatures clearfix">
            <div class="signature-box">
                <div style="font-weight:bold; font-size:12px; margin-bottom:10px;">Takımhane Sorumlusu</div>
                <div class="signature-line">İmza</div>
            </div>
            
            <div class="signature-box">
                <div style="font-weight:bold; font-size:12px; margin-bottom:10px;">Personel (Teslim Eden)</div>
                <div class="signature-line">İmza</div>
            </div>

            <div class="signature-box">
                <div style="font-weight:bold; font-size:12px; margin-bottom:10px;">Servis Şefi</div>
                <div class="signature-line">İmza</div>
            </div>
        </div>
        
        <script type="text/php">
            if (isset($pdf)) {
                $text = "Sayfa {PAGE_NUM} / {PAGE_COUNT}";
                $size = 10;
                $font = $fontMetrics->getFont("DejaVu Sans");
                $width = $fontMetrics->get_text_width($text, $font, $size) / 2;
                $x = ($pdf->get_width() - $width) / 2;
                $y = $pdf->get_height() - 35;
                $pdf->page_text($x, $y, $text, $font, $size);
            }
        </script>

        <div class="footer">
            Bu belge {{ now()->format('d.m.Y H:i') }} tarihinde TakımhanePro sistemi üzerinden oluşturulmuştur.
        </div>
    </div>
</body>
</html>
