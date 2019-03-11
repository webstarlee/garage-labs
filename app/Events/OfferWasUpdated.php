<?php

namespace App\Events;

use App\Proposal;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class OfferWasUpdated
{
    use InteractsWithSockets, SerializesModels;

    /**
     * Proposal instance
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
