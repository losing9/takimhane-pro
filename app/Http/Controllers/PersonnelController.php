<?php

namespace App\Http\Controllers;

use App\Models\Personnel;
use App\Models\User;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;

class PersonnelController extends Controller
{
    public function index(Request $request)
    {
        $query = Personnel::query();

        if ($request->has('search')) {
            $search = $request->input('search');
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('department', 'like', "%{$search}%")
                  ->orWhere('phone', 'like', "%{$search}%");
            });
        }

        $personnel = $query->latest()->paginate(10);
        return view('personnel.index', compact('personnel'));
    }

    public function create()
    {
        return view('personnel.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'surname' => 'required|string|max:255',
            'personnel_id' => 'required|string|max:50|unique:personnel,personnel_id,NULL,id,workshop_id,' . Auth::user()->workshop_id,
            'department' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
        ]);

        // Force workshop assignment from authenticated user
        $user = User::find(Auth::id());
        $validated['workshop_id'] = $user->workshop_id;

        Personnel::create($validated);

        if ($request->has('save_and_new')) {
            return redirect()->route('personnel.create')->with('success', 'Personel eklendi. Sıradaki personeli giriniz.');
        }

        return redirect()->route('personnel.index')->with('success', 'Personel eklendi.');
    }

    public function edit(Personnel $personnel)
    {
        return view('personnel.edit', compact('personnel'));
    }

    public function update(Request $request, Personnel $personnel)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'surname' => 'required|string|max:255',
            'personnel_id' => 'required|string|max:50|unique:personnel,personnel_id,' . $personnel->id . ',id,workshop_id,' . Auth::user()->workshop_id,
            'department' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
        ]);

        $personnel->update($validated);

        return redirect()->route('personnel.index')->with('success', 'Personel güncellendi.');
    }

    public function destroy(Personnel $personnel)
    {
        $personnel->delete();
        return redirect()->route('personnel.index')->with('success', 'Personel silindi.');
    }
}
