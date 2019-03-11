<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class Revision extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'description',
        'milestone_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'milestone_id' => 'integer'
    ];


    /**
     * Proposals one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function milestone()
    {
        return $this->belongsTo(Milestone::class);
    }
}