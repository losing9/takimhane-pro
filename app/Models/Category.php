<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class Category extends Model
{
    use HasFactory;

    protected $fillable = ['workshop_id', 'name'];

    protected static function booted()
    {
        static::addGlobalScope('workshop', function (Builder $builder) {
            if (Auth::check() && !Auth::user()->isSuperAdmin()) {
                $builder->where('workshop_id', Auth::user()->workshop_id);
            }
        });

        static::creating(function ($model) {
            if (Auth::check() && !Auth::user()->isSuperAdmin()) {
                $model->workshop_id = Auth::user()->workshop_id;
            }
        });
    }

    public function workshop(): BelongsTo
    {
        return $this->belongsTo(Workshop::class);
    }

    public function tools(): HasMany
    {
        return $this->hasMany(Tool::class);
    }
}
