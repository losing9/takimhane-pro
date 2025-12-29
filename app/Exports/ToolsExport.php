<?php

namespace App\Exports;

use App\Models\Tool;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class ToolsExport implements FromCollection, WithHeadings, WithMapping
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return Tool::with(['category', 'shelf'])->get();
    }

    public function headings(): array
    {
        return [
            'Seri Numarası',
            'Alet Adı',
            'Kategori',
            'Raf',
            'Açıklama',
            'Marka',
            'Model',
            'Barkod',
            'Durum',
            'Stok Giriş Tarihi',
            'Fiyat'
        ];
    }

    public function map($tool): array
    {
        return [
            $tool->serial_number,
            $tool->name,
            $tool->category ? $tool->category->name : '',
            $tool->shelf ? $tool->shelf->name : ($tool->shelf_location ?? ''),
            $tool->description,
            $tool->brand,
            $tool->model,
            $tool->barcode,
            $tool->status,
            $tool->purchase_date ? $tool->purchase_date->format('Y-m-d') : '',
            $tool->price,
        ];
    }
}
