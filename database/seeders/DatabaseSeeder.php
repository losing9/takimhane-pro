<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Workshop;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash; // Important!

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Create HQ Workshop
        $hq = Workshop::create([
            'name' => 'Genel Merkez',
            'location' => 'Istanbul',
        ]);

        // Create Super Admin
        User::create([
            'name' => 'Super Admin',
            'email' => 'admin@admin.com',
            'password' => Hash::make('password'),
            'workshop_id' => $hq->id, // Admin belongs to HQ? Or null? Let's say HQ for now.
            'role' => 'super_admin',
        ]);

        // Create a Manager
        User::create([
            'name' => 'Takımhane Sorumlusu 1',
            'email' => 'manager@manager.com',
            'password' => Hash::make('password'),
            'workshop_id' => $hq->id,
            'role' => 'manager',
        ]);
        
        // Create a separate workshop for testing isolation
        $izmir = Workshop::create([
            'name' => 'İzmir Takımhane',
            'location' => 'İzmir',
        ]);
        
        User::create([
            'name' => 'İzmir Sorumlusu',
            'email' => 'izmir@manager.com',
            'password' => Hash::make('password'),
            'workshop_id' => $izmir->id,
            'role' => 'manager',
        ]);
    }
}
