<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tool;
use App\Models\Personnel;
use App\Models\Loan;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    public function index()
    {
        // Super Admin Dashboard logic
        if (Auth::user()->isSuperAdmin()) {
            return $this->adminDashboard();
        }

        $workshopId = Auth::user()->workshop_id;

        // Basic stats (scoped automatically by Global Scope if not Super Admin)
        $totalTools = Tool::count();
        $loansOut = Loan::whereNull('returned_at')->count();
        $overdue = Loan::whereNull('returned_at')
                       ->where('issued_at', '<', now()->subDays(1)) // Pseudo overdue logic
                       ->count();
        $totalPersonnel = Personnel::count();

        // Recent loans
        $recentLoans = Loan::with(['tool', 'personnel'])
                           ->latest()
                           ->take(5)
                           ->get();

        return view('dashboard', compact('totalTools', 'loansOut', 'overdue', 'totalPersonnel', 'recentLoans'));
    }

    private function adminDashboard()
    {
        $stats = [
            'total_workshops' => \App\Models\Workshop::count(),
            'total_users' => \App\Models\User::count(),
            'total_tools' => Tool::count(),
            'active_loans' => Loan::whereNull('returned_at')->count(),
        ];

        $workshops = \App\Models\Workshop::withCount(['users', 'tools'])->get();

        return view('admin.dashboard', compact('stats', 'workshops'));
    }
}
