<?php

namespace App\Events;

use App\ServiceMessage;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class ServiceMessageWasCreated
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
    public function __construct(ServiceMessage $message)
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
