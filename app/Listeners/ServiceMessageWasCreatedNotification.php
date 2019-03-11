<?php

namespace App\Listeners;

use App\Notification;
use App\Events\ServiceMessageWasCreated;

class ServiceMessageWasCreatedNotification
{
    /**
     * Handle the event.
     *
     * @param  ServiceMessageWasCreated  $event
     * @return void
     */
    public function handle(ServiceMessageWasCreated $event)
    {
        $message = $event->message;
        $sender = $message->sender;
        $receiver = $message->receiver;

        Notification::create([
            'receiver_id' => $receiver->id,
            'title' => 'You have got new message',
            'message' => "$sender->first_name $sender->last_name: $message->text".PHP_EOL,
            'link' => "/user/ordered-contact/$message->ordered_package_id"
        ]);
    }
}
