<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Workshop extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = ['name', 'location', 'logo_path'];

    public function users(): HasMany
    {
        return $this->hasMany(User::class);
    }

    public function tools(): HasMany
    {
        return $this->hasMany(Tool::class);
    }

    public function personnel(): HasMany
    {
        return $this->hasMany(Personnel::class);
    }
}
