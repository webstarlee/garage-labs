<?php

namespace App\Listeners;

use App\Events\JoinTeam;
use App\Notification;

class JoinTeamNotification
{
    /**
     * Handle the event.
     *
     * @param  StartUpWasCreated  $event
     * @return void
     */
    public function handle(JoinTeam $event)
    {
        $startup = $event->startup;
        $joiningMember = $startup->joiningMember;

        Notification::create([
            'receiver_id' => $startup->author_id,
            'title' => 'New member has joined your team',
            'message' => $joiningMember->username.' accepted to join your team.',
            'link' => "/startups/$startup->slug"
        ]);
    }
}
