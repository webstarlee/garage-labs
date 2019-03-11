<?php

namespace App\Listeners;

use App\Events\StartUpWasCreated;
use App\Notification;

class SendStartUpCreatedNotification
{
    /**
     * Handle the event.
     *
     * @param  StartUpWasCreated  $event
     * @return void
     */
    public function handle(StartUpWasCreated $event)
    {
        $startup = $event->startup;

        Notification::create([
            'receiver_id' => $startup->author_id,
            'title' => 'New start-up',
            'message' => "Your start-up has been successfully created",
            'link' => "/startups/$startup->slug"
        ]);
    }
}
