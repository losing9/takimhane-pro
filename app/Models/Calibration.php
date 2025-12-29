<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class Calibration extends Model
{
    use HasFactory;

    protected $fillable = [
        'workshop_id', 'tool_id', 'calibration_date', 'next_calibration_date', 'certificate_no', 'company', 'status', 'notes'
    ];

    protected $casts = [
        'calibration_date' => 'date',
        'next_calibration_date' => 'date',
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
            }
        });
    }

    public function tool(): BelongsTo
    {
        return $this->belongsTo(Tool::class);
    }
}
