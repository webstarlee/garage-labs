<?php

namespace App;

class City extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name', 'country_id'];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'country_id' => 'integer'
    ];

    public function country()
    {
        return $this->belongsTo(Country::class, 'country_id');
    }
}
