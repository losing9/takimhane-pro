<?php

namespace App\Imports;

use App\Models\Tool;
use App\Models\Category;
use App\Models\Shelf;
use App\Models\Workshop;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class ToolsImport implements ToModel, WithHeadingRow
{
    private $workshopId;

    public function __construct()
    {
        // Find or create 'Özel Alet' category
        $this->specialCategory = Category::firstOrCreate(['name' => 'Özel Alet']);
        
        // Use authenticated user's workshop or default to 1 (fallback)
        $this->workshopId = \Illuminate\Support\Facades\Auth::check() 
            ? \Illuminate\Support\Facades\Auth::user()->workshop_id 
            : 1;
    }

    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        // Skip if serial number is missing
        if (empty($row['seri_numarasi'])) {
            return null;
        }

        $serialNumber = trim($row['seri_numarasi']);
        
        // Handle Shelf
        $shelfId = null;
        if (!empty($row['raf'])) {
            $shelfName = trim($row['raf']);
            $shelf = Shelf::firstOrCreate([
                'name' => $shelfName,
                'workshop_id' => $this->workshopId
            ]);
            $shelfId = $shelf->id;
        }

        // Handle Date
        $purchaseDate = null;
        if (!empty($row['stok_giris_tarihi'])) {
            try {
                $purchaseDate = Carbon::parse($row['stok_giris_tarihi']);
            } catch (\Exception $e) {
                // Ignore date error
            }
        }

        return Tool::updateOrCreate(
            [
                'workshop_id'   => $this->workshopId,
                'serial_number' => $serialNumber,
            ],
            [
                'name'          => isset($row['kategori']) ? trim($row['kategori']) : 'Bilinmeyen Alet',
                'category_id'   => $this->specialCategory->id,
                'shelf_location'=> isset($row['raf']) ? trim($row['raf']) : null,
                'shelf_id'      => $shelfId,
                'description'   => isset($row['aciklama']) ? trim($row['aciklama']) : null,
                'purchase_date' => $purchaseDate,
                'status'        => 'active',
                'barcode'       => $serialNumber, // Use serial_number as barcode
            ]
        );
    }
}
