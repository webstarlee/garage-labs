<?php

namespace App\Listeners;

use App\Notification;
use App\Events\MilestoneWasCreated;

class SendMilestoneCreatedNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(MilestoneWasCreated $event)
    {
        $milestone = $event->milestone;
        $proposal = $milestone->proposal;

        $action = 'funded';
        if(isset($milestone->action)) {
            $action = $milestone->action;
        }

        Notification::create([
            'receiver_id' => $proposal->author_id,
            'title' => 'New milestone "'.$milestone->title.'" was '.$action,
            'message' => 'New milestone '.$milestone->title.' was '.$action. PHP_EOL ."Ammount: $milestone->price €",
            'link' => "/projects/milestone/management/$proposal->id"
        ]);
    }
}