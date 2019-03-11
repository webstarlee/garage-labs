<?php

namespace App\Listeners;

use App\Events\ProjectWasCreated;
use App\Notification;

class SendProjectCreatedNotification
{
    /**
     * Handle the event.
     *
     * @param  ProjectWasCreated  $event
     * @return void
     */
    public function handle(ProjectWasCreated $event)
    {
        $project = $event->project;

        Notification::create([
            'receiver_id' => $project->author_id,
            'title' => 'New project',
            'message' => "Your project has been successfully created",
            'link' => "/projects/$project->id"
        ]);
    }
}
