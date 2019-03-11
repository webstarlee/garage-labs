<?php

namespace App\Events;

use App\Milestone;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class MilestoneWasAccept
{
    use InteractsWithSockets, SerializesModels;

    /**
     * Proposal object
     * @var Proposal
     */
    public $milestone;
    
    /**
     * Create a new event instance.
     * @param Proposal $proposal
     */
    public function __construct(Milestone $milestone)
    {
        $this->milestone = $milestone;
    }
}
