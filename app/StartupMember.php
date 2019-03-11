<?php

namespace App;

class StartupMember extends Model
{   /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'startup_members';


    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'start_up_id',
        'link',
        'email',
        'user_id',
    	'role',
        'description',
        'active',
        'name',
        'avatar_path'
    ];

    public function info() {
        return $this->belongsTo(User::class, 'user_id');
    }
}
