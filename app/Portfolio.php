<?php

namespace App;

use App\User;

class Portfolio extends Model
{
    protected $table = 'portfolios';

    protected $fillable = [
    	'title',
    	'item_path',
    	'description'
    ];

    /**
     * User one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function User()
    {
        return $this->belongsTo(User::class, 'user_id');
    }



}
