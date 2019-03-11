<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class Package extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'service_id',
        'author_id',
        'name',
        'description',
        'price',
        'days_to_deliver',
        'number_devisions',
        'instruction'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'service_id' => 'integer',
        'author_id' => 'integer',
        'price' => 'integer',
        'days_to_deliver' => 'integer',
        'number_devisions' => 'integer'
    ];

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function service()
    {
        return $this->belongsTo(Service::class);
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\hasOne
     */
    public function package_orders()
    {
        return $this->hasMany(PackageOrder::class);
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function feedbacks()
    {
        return $this->hasMany(PackageFeedback::class, 'package_id');
    }
}