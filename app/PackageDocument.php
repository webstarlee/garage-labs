<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class PackageDocument extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'package_id',
        'package_order_id',
        'filename'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'package_id' => 'integer',
        'package_order_id' => 'integer'
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'url'
    ];

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\
     */
    public function package()
    {
        return $this->belongsTo(Package::class);
    }

    /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getUrlAttribute()
    {
        return url("storage/$this->filename");
    }
}