<?php

namespace App\Http\Controllers;



use App\Models\Workshop;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;

class WorkshopController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255|unique:workshops',
        ]);

        Workshop::create($validated);

        return redirect()->route('dashboard')->with('success', 'Yeni şube/takımhane oluşturuldu.');
    }

    public function createUserForm(Workshop $workshop)
    {
        return view('admin.users.create', compact('workshop'));
    }

    public function storeUser(Request $request, Workshop $workshop)
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        $user = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'workshop_id' => $workshop->id,
            'role' => 'manager', // Default role for workshop managers
        ]);

        return redirect()->route('dashboard')->with('success', 'Yönetici kullanıcı başarıyla oluşturuldu.');
    }
}
