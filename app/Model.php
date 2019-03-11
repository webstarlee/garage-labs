<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model as BaseModel;

abstract class Model extends BaseModel
{
    /**
     * The "booting" method of the model.
     *
     * @return void
     */
    public static function boot()
    {
        parent::boot();

        static::addGlobalScope(function (Builder $query) {
            $query->addSelect((new static)->getTable() . '.*');
        });
    }

    /**
     * Default value for avatar path
     * @param null $value
     * @return \Illuminate\Contracts\Routing\UrlGenerator|null|string
     */
    public function getAvatarPathAttribute($value = null)
    {
        return is_null($value) ? url('vendor/avatar/default.jpg') : url($value);
    }

    /**
     * Default value for avatar path
     * @param $value
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getUserAvatarPathAttribute($value)
    {
        return $this->getAvatarPathAttribute($value);
    }

    /**
     * Casting argument to boolean
     * @param $value
     * @return bool
     */
    public function castBooleanAttribute($value)
    {
        if(is_string($value)) {
            switch($value) {
                case '1':
                case 'true':
                    return true;
                case '0':
                case 'false':
                    return false;
            }
        }
        
        if(is_bool($value)) {
            return $value;
        }
        
        if(is_integer($value)) {
            switch($value) {
                case 0:
                    return false;
                default:
                    return true;
            }
        }
    }

    /**
     * Order by desc UPDATED_AT column
     * @param Builder $query
     * @return mixed
     */
    public function scopeLastUpdated(Builder $query)
    {
        return $query->orderBy($this->getTable() . '.' . $this->getUpdatedAtColumn(), 'desc');
    }
}
