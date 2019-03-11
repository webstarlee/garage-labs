<?php

namespace App\Events;

use App\Message;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\InteractsWithSockets;

class MessageWasCreated
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
    public function __construct(Message $message)
    {
        $this->message = $message;
    }
}
