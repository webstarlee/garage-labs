<?php

namespace App\Listeners;

use App\Notification;
use App\Events\ProposalWasAccepted;

class SendProposalAcceptedNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasAccepted  $event
     * @return void
     */
    public function handle(ProposalWasAccepted $event)
    {
        $proposal = $event->proposal;
        $project = $proposal->project;
        $author = $project->author;
        $action = 'accepted';
        if(isset($proposal->action)) {
            $action = $proposal->action;
        }

        Notification::create([
            'receiver_id' => $proposal->author_id,
            'title' => 'Your proposal was '.$action,
            'message' => "User $author->first_name $author->last_name has ".$action." your proposal." . PHP_EOL ."Offer: $proposal->offer €",
            'link' => "/projects/$project->slug"
        ]);
    }
}
