<?php

namespace App;

class SkillUser extends Model
{
       /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'skill_user';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['user_id', 'skill_id'];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'skill_id' => 'integer',
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
