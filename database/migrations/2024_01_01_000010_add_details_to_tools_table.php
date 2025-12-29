<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tools', function (Blueprint $table) {
            $table->foreignId('shelf_id')->nullable()->constrained('shelves')->nullOnDelete();
            $table->foreignId('category_id')->nullable()->constrained('categories')->nullOnDelete();
            $table->string('price')->nullable();
            $table->date('purchase_date')->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('tools', function (Blueprint $table) {
            $table->dropForeign(['shelf_id']);
            $table->dropForeign(['category_id']);
            $table->dropColumn(['shelf_id', 'category_id', 'price', 'purchase_date']);
        });
    }
};
