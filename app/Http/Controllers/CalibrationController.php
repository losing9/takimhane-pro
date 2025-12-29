<?php

namespace App\Http\Controllers;

use App\Models\Calibration;
use App\Models\Tool;
use Illuminate\Http\Request;

class CalibrationController extends Controller
{
    public function index()
    {
        $upcoming = Calibration::with('tool')
            ->where('next_calibration_date', '>=', now())
            ->orderBy('next_calibration_date')
            ->paginate(10);
            
        $history = Calibration::with('tool')
            ->where('next_calibration_date', '<', now())
            ->latest('calibration_date')
            ->paginate(10);

        return view('calibration.index', compact('upcoming', 'history'));
    }

    public function create()
    {
        $tools = Tool::all();
        return view('calibration.create', compact('tools'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'tool_id' => 'required|exists:tools,id',
            'calibration_date' => 'required|date',
            'next_calibration_date' => 'required|date|after:calibration_date',
            'company' => 'nullable|string',
            'certificate_no' => 'nullable|string',
            'status' => 'required|in:pass,fail',
            'notes' => 'nullable|string',
        ]);

        Calibration::create($validated);

        return redirect()->route('calibration.index')->with('success', 'Kalibrasyon kaydedildi.');
    }
}
