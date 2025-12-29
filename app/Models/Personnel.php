<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class Personnel extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'personnel'; // Explicit table name

    protected $fillable = [
        'workshop_id',
        'personnel_id',
        'name',
        'surname',
        'department',
        'email',
        'phone',
        'is_active'
    ];

    protected static function booted()
    {
        static::addGlobalScope('workshop', function (Builder $builder) {
            if (Auth::check() && !Auth::user()->isSuperAdmin()) {
                $builder->where('workshop_id', Auth::user()->workshop_id);
            }
        });

        static::creating(function ($model) {
            if (Auth::check() && !Auth::user()->isSuperAdmin()) {
                // Fetch fresh user to handle stale sessions
                $user = \App\Models\User::find(Auth::id());
                $model->workshop_id = $user->workshop_id;
            }
        });
    }

    public function workshop(): BelongsTo
    {
        return $this->belongsTo(Workshop::class);
    }
}
