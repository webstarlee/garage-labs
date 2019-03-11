<?php

namespace App;



class FondsType extends Model
{
    
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'fonds_types';

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
	    return $this->hasMany(StartUp::class, 'fonds_types_id');
	}
}
