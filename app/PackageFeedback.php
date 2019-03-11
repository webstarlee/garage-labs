<?php

namespace App;

class PackageFeedback extends Model
{
    protected $table = 'package_feedback';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'buyer_id',
        'seller_id',
        'package_id',
        'message',
        'rating',
        'communication',
        'skill',
        'deadline',
        'experience',
        'ordered_package_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'buyer_id' => 'integer',
        'seller_id' => 'integer',
        'package_id' => 'integer',
        'rating' => 'integer',
        'communication' => 'integer',
        'skill' => 'integer',
        'deadline' => 'integer',
        'experience' => 'integer',
        'ordered_package_id' => 'integer'
    ];

    public function author() {
        return $this->belongsTo(User::class, 'buyer_id');
    }

    /**
     * Project many to one
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function package()
    {
       return $this->belongsTo(Package::class);
    }
}