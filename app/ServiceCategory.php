<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;
use DB;

class ServiceCategory extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'service_categories';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'display'
    ];

    /**
     * Documents many to many  relationship
     * @return \Illuminate\Database\Eloquent\Relations\
     */
    public function subcategories()
    {
        return $this->hasMany(ServiceSubCategory::class, 'category_id');
    }

     /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getDisplayAttribute()
    {
        return false;
    }

    /**
     * With proposals count
     * @param Builder $query
     * @return Builder
     */
    public function scopeServiceCount(Builder $query)
    {
        $query->leftJoin('services', 'services.category_id', '=', 'service_categories.id');
        $query->groupBy('services.category_id');
        $query->addSelect(DB::raw('count(services.id) as services_count'));

        return $query;
    }
}
