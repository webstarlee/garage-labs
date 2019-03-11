<?php

namespace App\Events;

use App\StartupMessage;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class StartupMessageWasCreated
{
    use InteractsWithSockets, SerializesModels;

    /**
     * Message instance
     *
     * @var Message
     */
    public $message;
    
    /**
     * Create a new event instance.
     * @param Message $message
     */
    public function __construct(StartupMessage $message)
    {
        $this->message = $message;
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
