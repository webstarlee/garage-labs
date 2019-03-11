<?php

namespace App\Listeners;

use App\Notification;
use App\Events\MilestoneWasAccept;

class SendMilestoneAcceptNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(MilestoneWasAccept $event)
    {
        $milestone = $event->milestone;
        $proposal = $milestone->proposal;
        $project = $proposal->project;

        $action = 'accept';
        if(isset($milestone->action)) {
            $action = $milestone->action;
        }

        Notification::create([
            'receiver_id' => $project->author_id,
            'title' => 'The milestone "'.$milestone->title.'" was '.$action,
            'message' => 'The milestone '.$milestone->title.' was '.$action. PHP_EOL ."Ammount: $milestone->price €",
            'link' => "/projects/milestone/owner/management/$proposal->id"
        ]);
    }
}