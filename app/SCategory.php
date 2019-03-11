<?php

namespace App;

class SCategory extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'scategories';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];

    /**
     * Many to many relationship with StartUp entity
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function startups()
    {
        return $this->belongsToMany(StartUp::class);
    }
}
