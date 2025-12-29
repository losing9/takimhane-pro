<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return redirect()->route('dashboard');
});

use App\Http\Controllers\DashboardController;

Route::get('/dashboard', [DashboardController::class, 'index'])->middleware(['auth', 'verified'])->name('dashboard');
    
    Route::resource('tools', \App\Http\Controllers\ToolController::class);
    Route::resource('personnel', \App\Http\Controllers\PersonnelController::class);
    Route::resource('loans', \App\Http\Controllers\LoanController::class);
    Route::get('loans/{loan}/return', [\App\Http\Controllers\LoanController::class, 'returnForm'])->name('loans.return');

    // Super Admin Routes
    Route::post('workshops', [\App\Http\Controllers\WorkshopController::class, 'store'])->name('workshops.store');
    Route::get('workshops/{workshop}/users/create', [\App\Http\Controllers\WorkshopController::class, 'createUserForm'])->name('workshops.users.create');
    Route::post('workshops/{workshop}/users', [\App\Http\Controllers\WorkshopController::class, 'storeUser'])->name('workshops.users.store');

    Route::post('workshops/{workshop}/users', [\App\Http\Controllers\WorkshopController::class, 'storeUser'])->name('workshops.users.store');

    Route::resource('shelves', \App\Http\Controllers\ShelfController::class);
    Route::resource('categories', \App\Http\Controllers\CategoryController::class);
    
    Route::get('maintenance/{maintenance}/report', [\App\Http\Controllers\MaintenanceController::class, 'prepareReport'])->name('maintenance.report');
    Route::post('maintenance/{maintenance}/report', [\App\Http\Controllers\MaintenanceController::class, 'generateReport'])->name('maintenance.report.generate');
    Route::resource('maintenance', \App\Http\Controllers\MaintenanceController::class);
    Route::resource('calibration', \App\Http\Controllers\CalibrationController::class);

    // Import/Export
    Route::get('import-export', [\App\Http\Controllers\ImportExportController::class, 'index'])->name('import-export.index');
    Route::post('import', [\App\Http\Controllers\ImportExportController::class, 'import'])->name('import');
    Route::get('export', [\App\Http\Controllers\ImportExportController::class, 'export'])->name('export');
    Route::get('export-csv', [\App\Http\Controllers\ImportExportController::class, 'exportCsv'])->name('export-csv');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // AI Routes
    Route::post('/ai/ask', [App\Http\Controllers\AiController::class, 'ask'])->name('ai.ask');
});

require __DIR__.'/auth.php';
