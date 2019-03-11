<?php

namespace App;

class OtherSkill extends Model
{
       /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'other_skills';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['user_id', 'skill'];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'user_id' => 'integer'
    ];

    /**
     * Many to many relationship with User entity
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function users()
    {
        return $this->hasOne(User::class);
    }
}
