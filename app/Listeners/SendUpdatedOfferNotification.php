<?php

namespace App\Listeners;

use App\Notification;
use App\Events\OfferWasUpdated;

class SendUpdatedOfferNotification
{
    /**
     * Handle the event.
     *
     * @param  OfferWasUpdated  $event
     * @return void
     */
    public function handle(OfferWasUpdated $event)
    {
        $proposal = $event->proposal;
        $project = $proposal->project;
        $author = $proposal->author;

        Notification::create([
            'receiver_id' => $project->author_id,
            'title' => 'The offer was updated',
            'message' => "User $author->first_name $author->last_name has updated the offer." . PHP_EOL ."New Offer: $proposal->offer €",
            'link' => "/projects/$project->slug"
        ]);
    }
}
