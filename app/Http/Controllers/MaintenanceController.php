<?php

namespace App\Http\Controllers;

use App\Models\Maintenance;
use App\Models\Tool;
use Illuminate\Http\Request;

class MaintenanceController extends Controller
{
    public function index(Request $request)
    {
        $query = Maintenance::with('tool');

        if ($request->has('status') && $request->status) {
            $query->where('status', $request->status);
        }

        $maintenances = $query->latest()->paginate(10);
        return view('maintenance.index', compact('maintenances'));
    }

    public function create()
    {
        $tools = Tool::where('status', '!=', 'scrapped')->get(); // Can report damage on active/loaned tools
        return view('maintenance.create', compact('tools'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'tool_id' => 'required|exists:tools,id',
            'description' => 'required|string',
            'repair_company' => 'nullable|string',
        ]);

        $maintenance = Maintenance::create($validated);
        
        // Auto update tool status
        $maintenance->tool->update(['status' => 'maintenance']);

        return redirect()->route('maintenance.index')->with('success', 'Arıza kaydı oluşturuldu.');
    }

    public function update(Request $request, Maintenance $maintenance)
    {
        $validated = $request->validate([
            'status' => 'required|in:pending,in_progress,completed,scrapped',
            'cost' => 'nullable|numeric',
            'completed_at' => 'nullable|date',
        ]);

        $maintenance->update($validated);

        if ($validated['status'] === 'completed') {
            $maintenance->tool->update(['status' => 'active']);
        } elseif ($validated['status'] === 'scrapped') {
            $maintenance->tool->update(['status' => 'scrapped']);
        }

        return redirect()->route('maintenance.index')->with('success', 'Bakım durumu güncellendi.');
    }



    public function prepareReport(Maintenance $maintenance)
    {
        return view('maintenance.prepare-report', compact('maintenance'));
    }

    public function generateReport(Request $request, Maintenance $maintenance)
    {
        $validated = $request->validate([
            'description' => 'required|string',
            'result' => 'nullable|string',
        ]);

        $maintenance->update($validated);

        $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadView('maintenance.report', compact('maintenance'));
        return $pdf->download('ariza-tutanagi-' . $maintenance->id . '.pdf');
    }
}
