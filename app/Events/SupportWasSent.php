<?php

namespace App\Events;

use App\CustomerSupport;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class SupportWasSent
{
    use InteractsWithSockets, SerializesModels;

    /**
     * @var customerSupport
     */
    public $customerSupport;
    
    /**
     * Create a new event instance.
     * @param CustomerSupport $customerSupport
     */
    public function __construct(CustomerSupport $customerSupport)
    {
        $this->customerSupport = $customerSupport;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('channel-name');
    }
}
