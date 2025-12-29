<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class Maintenance extends Model
{
    use HasFactory;

    protected $fillable = [
        'workshop_id', 'tool_id', 'user_id', 'description', 'result', 'status', 'cost', 'repair_company', 'completed_at'
    ];

    protected $casts = [
        'completed_at' => 'date',
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
                $model->workshop_id = Auth::user()->workshop_id;
                $model->user_id = Auth::id();
            }
        });
    }

    public function tool(): BelongsTo
    {
        return $this->belongsTo(Tool::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
