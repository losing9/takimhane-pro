<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('maintenances', function (Blueprint $table) {
            $table->id();
            $table->foreignId('workshop_id')->constrained();
            $table->foreignId('tool_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained(); // Who reported/managed it
            $table->text('description'); // Fault description
            $table->enum('status', ['pending', 'in_progress', 'completed', 'scrapped'])->default('pending');
            $table->decimal('cost', 10, 2)->nullable();
            $table->string('repair_company')->nullable(); // If sent outside
            $table->date('completed_at')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('maintenances');
    }
};
