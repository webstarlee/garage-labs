<?php

namespace App;

class ServiceSubCategory extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'service_subcategories';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];

    /**
     * With proposals count
     * @param Builder $query
     * @return Builder
     */
    public function scopeSubServiceCount(Builder $query)
    {
        $query->leftJoin('services', 'services.subcategory_id', '=', 'service_subcategories.id');
        $query->groupBy('services.subcategory_id');
        $query->addSelect(DB::raw('count(services.id) as subservices_count'));

        return $query;
    }
}
