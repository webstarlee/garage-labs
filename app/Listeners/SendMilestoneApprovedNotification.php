<?php

namespace App\Listeners;

use App\Notification;
use App\Events\MilestoneWasApproved;

class SendMilestoneApprovedNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(MilestoneWasApproved $event)
    {
        $milestone = $event->milestone;
        $proposal = $milestone->proposal;

        $action = 'approved';
        if(isset($milestone->action)) {
            $action = $milestone->action;
        }

        Notification::create([
            'receiver_id' => $proposal->author_id,
            'title' => 'The milestone "'.$milestone->title.'" was '.$action,
            'message' => 'The milestone '.$milestone->title.' was '.$action. PHP_EOL ."Ammount: $milestone->price €",
            'link' => "/projects/milestone/management/$proposal->id"
        ]);
    }
}