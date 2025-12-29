<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('calibrations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('workshop_id')->constrained();
            $table->foreignId('tool_id')->constrained()->cascadeOnDelete();
            $table->date('calibration_date'); // When it was done
            $table->date('next_calibration_date'); // When it expires
            $table->string('certificate_no')->nullable();
            $table->string('company')->nullable(); // Who calibrated it
            $table->enum('status', ['pass', 'fail'])->default('pass');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('calibrations');
    }
};
