<?php

namespace App\Listeners;

use App\Notification;
use App\Events\ProposalWasCreated;

class SendProposalCreatedNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(ProposalWasCreated $event)
    {
        $proposal = $event->proposal;
        $project = $proposal->project;
        $author = $proposal->author;
        $conversation = $proposal->conversation;

        Notification::create([
            'receiver_id' => $project->author_id,
            'title' => 'New proposal to your project',
            'message' => "User $author->first_name $author->last_name has made proposal to your project." . PHP_EOL ."Offer: $proposal->offer €",
            'link' => "/user/messages/thread/$conversation->id"
        ]);
    }
}