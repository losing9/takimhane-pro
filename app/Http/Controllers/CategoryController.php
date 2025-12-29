<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = Category::withCount('tools')->get();
        return view('categories.index', compact('categories'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate(['name' => 'required|string']);
        Category::create($validated);
        return redirect()->back()->with('success', 'Kategori eklendi.');
    }
}
