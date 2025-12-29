<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class Tool extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'workshop_id',
        'serial_number',
        'name',
        'brand',
        'model',
        'barcode',
        'status',
        'description',
        'shelf_location'
    ];

    protected static function booted()
    {
        static::addGlobalScope('workshop', function (Builder $builder) {
            if (Auth::check() && !Auth::user()->isSuperAdmin()) {
                $builder->where('workshop_id', Auth::user()->workshop_id);
            }
        });
        
        static::creating(function ($model) {
            if (Auth::check()) {
                // Fetch fresh user data to handle stale sessions
                $user = \App\Models\User::find(Auth::id());
                $model->workshop_id = $model->workshop_id ?? $user->workshop_id;
            }
            
            if (empty($model->barcode) && !empty($model->serial_number)) {
                $model->barcode = $model->serial_number;
            }
        });
    }

    public function workshop(): BelongsTo
    {
        return $this->belongsTo(Workshop::class);
    }

    public function shelf(): BelongsTo
    {
        return $this->belongsTo(Shelf::class);
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function maintenances(): HasMany
    {
        return $this->hasMany(Maintenance::class);
    }

    public function calibrations(): HasMany
    {
        return $this->hasMany(Calibration::class);
    }

    public function loans(): HasMany
    {
        return $this->hasMany(Loan::class);
    }

    public function currentLoan()
    {
        return $this->hasOne(Loan::class)->whereNull('returned_at');
    }
}
