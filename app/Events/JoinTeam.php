<?php

namespace App\Events;

use App\StartUp;
use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\InteractsWithSockets;

class JoinTeam
{
    use InteractsWithSockets, SerializesModels;

    /**
     * Project instance
     * @var Project
     */
    public $startup;

    /**
     * Create a new event instance.
     * @param Project $project
     */
    public function __construct(StartUp $startup)
    {
        $this->startup = $startup;
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
