<?php

namespace App;

class Skill extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];

    /**
     * Many to many relationship with User entity
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function users()
    {
        return $this->belongsToMany(User::class);
    }

    /**
     * Many to many relationship with Startup entity
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function startups()
    {
        return $this->belongsToMany(StartUp::class);
    }
}
