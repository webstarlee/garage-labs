<?php

namespace App\Events;

use App\Proposal;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class ProposalWasCreated
{
    use InteractsWithSockets, SerializesModels;

    /**
     * Proposal object
     * @var Proposal
     */
    public $proposal;
    
    /**
     * Create a new event instance.
     * @param Proposal $proposal
     */
    public function __construct(Proposal $proposal)
    {
        $this->proposal = $proposal;
    }
}
