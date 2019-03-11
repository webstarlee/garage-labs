<?php

namespace App\Events;

use App\PackageOrder;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class PackageWasAskedRevision
{
    use InteractsWithSockets, SerializesModels;

    /**
     * @var packageOrder
     */
    public $packageOrder;
    
    /**
     * Create a new event instance.
     * @param PackageOrder $packageOrder
     */
    public function __construct(PackageOrder $packageOrder)
    {
        $this->packageOrder = $packageOrder;
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
