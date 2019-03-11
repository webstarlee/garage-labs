<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class CustomerSupport extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'order_id',
        'service_id',
        'reason',
        'comment',
        'type',
        'author_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'author_id' => 'integer',
        'service_id' => 'integer'
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