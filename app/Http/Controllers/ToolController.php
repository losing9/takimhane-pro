<?php

namespace App\Http\Controllers;

use App\Models\Tool;
use App\Models\Workshop;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class ToolController extends Controller
{
    public function index(Request $request)
    {
        $query = Tool::query();

        if ($request->has('search')) {
            $search = $request->input('search');
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('serial_number', 'like', "%{$search}%")
                  ->orWhere('model', 'like', "%{$search}%");
            });
        }

        if ($request->has('status') && $request->status != '') {
            $query->where('status', $request->status);
        }

        $tools = $query->latest()->paginate(10);

        return view('tools.index', compact('tools'));
    }

    public function create()
    {
        return view('tools.create');
    }

    public function store(Request $request)
    {
        $user = Auth::user();

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'brand' => 'nullable|string|max:255',
            'model' => 'nullable|string|max:255',
            'serial_number' => [
                'required', 
                'string', 
                \Illuminate\Validation\Rule::unique('tools')->where(function ($query) use ($user) {
                    return $query->where('workshop_id', $user->workshop_id);
                })
            ],
            'status' => 'required|in:active,maintenance,repair,scrapped,lost',
            'purchase_date' => 'nullable|date',
            'price' => 'nullable|numeric',
        ]);

        // Workshop ID is handled by Model's creating method or we set it here explicitly if needed
        // But our global scope handles reading. For writing, we need to ensure it's set.
        // The Tool model event `creating` I added earlier handles setting workshop_id from Auth user.

        // Force workshop assignment from authenticated user
        $validated['workshop_id'] = $user->workshop_id;

        Tool::create($validated);

        if ($request->has('save_and_new')) {
            return redirect()->route('tools.create')->with('success', 'Alet eklendi. Sıradaki aleti giriniz.');
        }

        return redirect()->route('tools.index')->with('success', 'Alet başarıyla eklendi.');
    }

    public function edit(Tool $tool)
    {
        // Global scope ensures user can only access their workshop's tool
        return view('tools.edit', compact('tool'));
    }

    public function update(Request $request, Tool $tool)
    {
        $user = Auth::user();

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'brand' => 'nullable|string|max:255',
            'model' => 'nullable|string|max:255',
            'serial_number' => [
                'required', 
                'string', 
                \Illuminate\Validation\Rule::unique('tools')->ignore($tool->id)->where(function ($query) use ($user) {
                    return $query->where('workshop_id', $user->workshop_id);
                })
            ],
            'status' => 'required|in:active,maintenance,repair,scrapped,lost',
            'purchase_date' => 'nullable|date',
            'price' => 'nullable|numeric',
        ]);

        $tool->update($validated);

        return redirect()->route('tools.index')->with('success', 'Alet güncellendi.');
    }

    public function destroy(Tool $tool)
    {
        $tool->delete();
        return redirect()->route('tools.index')->with('success', 'Alet silindi.');
    }
}
