<?php

namespace App\Http\Controllers;

use App\Models\Shelf;
use Illuminate\Http\Request;

class ShelfController extends Controller
{
    public function index()
    {
        $shelves = Shelf::withCount('tools')->get();
        return view('shelves.index', compact('shelves'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate(['name' => 'required|string', 'location' => 'nullable|string']);
        Shelf::create($validated);
        return redirect()->back()->with('success', 'Raf eklendi.');
    }
    
    public function show(Shelf $shelf) {
        $tools = $shelf->tools()->paginate(10);
        return view('shelves.show', compact('shelf', 'tools'));
    }
}
