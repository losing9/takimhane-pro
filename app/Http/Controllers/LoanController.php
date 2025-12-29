<?php

namespace App\Http\Controllers;

use App\Models\Loan;
use App\Models\Tool;
use App\Models\Personnel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoanController extends Controller
{
    public function index(Request $request)
    {
        $query = Loan::with(['tool', 'personnel', 'user']);

        if ($request->has('search')) {
            $search = $request->input('search');
            $query->whereHas('tool', function($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('serial_number', 'like', "%{$search}%");
            })->orWhereHas('personnel', function($q) use ($search) {
                $q->where('name', 'like', "%{$search}%");
            });
        }

        if ($request->has('status')) {
            if ($request->status == 'open') {
                $query->whereNull('returned_at');
            } elseif ($request->status == 'closed') {
                $query->whereNotNull('returned_at');
            }
        }

        $loans = $query->latest()->paginate(10);
        return view('loans.index', compact('loans'));
    }

    public function create()
    {
        // Only show active tools that are not currently loaned out
        // Logic: Tool status 'active' AND not currently in an open loan
        // BUT simplistic approach: Tool status 'active'.
        // Better: Check if tool is in 'loans' table with null 'returned_at'
        
        $activeTools = Tool::where('status', 'active')
            ->whereDoesntHave('loans', function($q) {
                $q->whereNull('returned_at');
            })
            ->get();
            
        $personnel = Personnel::all();
        
        return view('loans.create', compact('activeTools', 'personnel'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'tool_id' => 'required|exists:tools,id',
            'personnel_id' => 'required|exists:personnel,id',
            'notes' => 'nullable|string',
        ]);

        $validated['user_id'] = Auth::id(); // Issuer
        $validated['issued_at'] = now();
        
        // Inherit workshop from the tool
        $tool = Tool::findOrFail($validated['tool_id']);
        $validated['workshop_id'] = $tool->workshop_id;

        Loan::create($validated);

        return redirect()->route('loans.index')->with('success', 'Alet zimmetlendi.');
    }

    public function update(Request $request, Loan $loan)
    {
        // Used for returning the item
        if ($request->has('return_action')) {
            $loan->update([
                'returned_at' => now(),
                'notes' => $loan->notes . "\n[İade Notu]: " . $request->input('notes'),
            ]);
            
            return redirect()->back()->with('success', 'Alet iade alındı.');
        }
        
        return redirect()->back();
    }
    public function returnForm(Loan $loan)
    {
        return view('loans.return', compact('loan'));
    }
}
