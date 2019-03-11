<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class Fundraising extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'author_id',
        'title',
        'firstname',
        'name',
        'email',
        'mobile',
        'problem',
        'business_model',
        'team'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'author_id' => 'integer'
    ];

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }
}