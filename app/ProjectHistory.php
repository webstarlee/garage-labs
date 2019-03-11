<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class ProjectHistory extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'description',
        'proposal_id',
        'author_id',
        'action'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'proposal_id' => 'integer',
        'author_id' => 'integer'
    ];

    /**
     * Proposals one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function proposal()
    {
        return $this->belongsTo(Proposal::class);
    }

    public function author() 
    {
        return $this->belongsTo(User::class, 'author_id');
    }

    public function offer($supplier, $amount)
    {
        $this->description = $supplier.' offered '.$amount.'€';
    }

    public function modifyOffer($supplier, $amount)
    {
        $this->description = $supplier.' modified offer to '.$amount.'€ - waiting for accepting';
    }

    public function acceptOffer($supplier, $amount, $owner)
    {
        $this->description = $supplier.' offered '.$amount.'€ (accepted by '.$owner.')';
    }

    public function createMilestone($title)
    {
        $this->description = 'Milestone '.'"'.$title.'"'." was created on ".date("d/m/Y");
    }

    public function fundMilestone($title, $ammount)
    {
        $this->description = 'Milestone '.'"'.$title.'" funded on '.date("d/m/Y").'('.$ammount.'€) - waiting for acceptation';
    }

    public function acceptMilestone($title, $supplier)
    {
        $this->description = 'Milestone '.'"'.$title.'" was accepted by '.$supplier;
    }

    public function submitMilestone($title, $amount, $supplier)
    {
        $this->description = 'Milestone '.'"'.$title.'" was submitted by '.$supplier.'('.$amount.'€)';
    }

    public function approveMilestone($title, $amount, $owner)
    {
        $this->description = 'Milestone '.' "'.$title.'" was approved by '.$owner.'('.$amount.'€)';
    }

    public function askRevision($title, $amount, $owner)
    {
        $this->description = 'Revision asked on for milestone'.' "'.$title.'" was asked on '.date("d/m/Y");
    }
}