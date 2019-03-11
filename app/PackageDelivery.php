<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class PackageDelivery extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'ordered_package_id',
        'description',
        'filename'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'ordered_package_id' => 'integer'
    ];

    /**
     * Documents many to many morph relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function documents()
    {
        return $this->hasMany(PackageDeliveryDocument::class, 'package_delivery_id');
    }

    /**
     * Proposals one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function package_order()
    {
        return $this->belongsTo(PackageOrder::class);
    }
}