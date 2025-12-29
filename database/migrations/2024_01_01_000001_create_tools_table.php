<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tools', function (Blueprint $table) {
            $table->id();
            $table->foreignId('workshop_id')->constrained()->onDelete('cascade');
            $table->string('serial_number')->index();
            $table->string('name');
            $table->string('brand')->nullable();
            $table->string('model')->nullable();
            $table->string('barcode')->nullable();
            $table->enum('status', ['active', 'maintenance', 'lost', 'scrapped'])->default('active');
            $table->text('description')->nullable();
            $table->string('shelf_location')->nullable(); // Raf No
            $table->timestamps();
            $table->softDeletes();

            $table->unique(['workshop_id', 'serial_number']); // Serial No unique only within workshop? Or global? Assuming scoped for now.
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tools');
    }
};
