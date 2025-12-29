<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Imports\ToolsImport;
use App\Exports\ToolsExport;
use Maatwebsite\Excel\Facades\Excel;
use App\Models\Tool;

class ImportExportController extends Controller
{
    public function index()
    {
        return view('import-export.index');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:csv,txt,xlsx,xls',
        ]);

        try {
            Excel::import(new ToolsImport, $request->file('file'));
            return redirect()->back()->with('success', 'Veriler başarıyla içe aktarıldı.');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Hata oluştu: ' . $e->getMessage());
        }
    }

    public function export()
    {
        return Excel::download(new ToolsExport, 'tools.xlsx');
    }
    
    public function exportCsv()
    {
        return Excel::download(new ToolsExport, 'tools.csv');
    }
}
