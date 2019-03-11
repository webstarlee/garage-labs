<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class DeliveryMilestone extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'description',
        'milestone_id',
        'filename'
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
     * Documents many to many morph relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function documents()
    {
        return $this->hasMany(MilestoneDocument::class, 'milestone_id');
    }

    /**
     * Proposals one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function milestone()
    {
        return $this->belongsTo(Milestone::class);
    }
}