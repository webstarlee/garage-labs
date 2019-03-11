<?php

namespace App\Listeners;

use App\Notification;
use App\Events\ContactWasCreated;

class SendContactCreatedNotification
{
    /**
     * Handle the event.
     *
     * @param  ContactWasCreated  $event
     * @return void
     */
    public function handle(ContactWasCreated $event)
    {
        $contact = $event->contact;
        $startup = $contact->startup;
        $author = $contact->author;
        $conversation = $contact->message;

        Notification::create([
            'receiver_id' => $startup->author_id,
            'title' => 'New Contact to your startup',
            'message' => "$author->first_name $author->last_name:" . PHP_EOL.$conversation,
            'link' => "/startups/$startup->slug"
        ]);
    }
}