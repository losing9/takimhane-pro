<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class Loan extends Model
{
    use HasFactory;

    protected $fillable = [
        'workshop_id',
        'tool_id',
        'personnel_id',
        'user_id',
        'issued_at',
        'returned_at',
        'notes'
    ];

    protected $casts = [
        'issued_at' => 'datetime',
        'returned_at' => 'datetime',
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
                $model->user_id = Auth::id(); // Record who issued it
            }
        });
    }

    public function workshop(): BelongsTo
    {
        return $this->belongsTo(Workshop::class);
    }

    public function tool(): BelongsTo
    {
        return $this->belongsTo(Tool::class);
    }

    public function personnel(): BelongsTo
    {
        return $this->belongsTo(Personnel::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
