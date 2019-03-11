<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class Milestone extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'title',
        'description',
        'deadline',
        'id',
        'price',
        'status',
        'proposal_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'price' => 'integer',
        'proposal_id' => 'integer'
    ];

    /**
     * Accept milestone
     * @return void
     */
     public function accept()
     {
         $this->status = 'accepted';
     }

     public function delivery() {
         $this->status = 'submitted';
     }

     /**
      * Reject milestone
      * @return void
      */
     public function reject()
     {
         $this->status = 'rejected';
     }

    /**
     * Set status to closed
     * @return void
     */
    public function approve()
    {
        $this->status = 'approved';
    }

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
    public function proposal()
    {
        return $this->belongsTo(Proposal::class);
    }

    public function revision() {
        return $this->hasMany(Revision::class, 'milestone_id');
    }

    public function deliveries() {
        return $this->hasMany(DeliveryMilestone::class, 'milestone_id');
    }

    /**
     * Create/move documents and link to current milestone
     * @param array $documents
     */
    public function uploadAndaddDocuments(array $documents)
    {
        $result = [];

        foreach($documents as $document) {
            $filename = str_random(10) . '.' .$document->getClientOriginalExtension();
            $document->move(public_path('storage'), $filename);

            array_push($result, new MilestoneDocument([
                'milestone_id' => $this->id,
                'filename' => $filename
            ]));
        }

        $this->documents()->saveMany($result);
    }
}