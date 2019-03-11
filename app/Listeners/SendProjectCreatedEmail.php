<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\ProjectWasCreated;
use Illuminate\Contracts\Mail\Mailer;
use App\ConfigurationUtils;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendProjectCreatedEmail implements ShouldQueue
{
    /**
     * Mailer instance
     *
     * @var Mailer
     */
    protected $mailer;

    /**
     * Create the event listener.
     * @param Mailer $mailer
     */
    public function __construct(Mailer $mailer)
    {
        $this->mailer = $mailer;
    }

    /**
     * Handle the event.
     *
     * @param  ProjectWasCreated  $event
     * @return void
     */
    public function handle(ProjectWasCreated $event)
    {
        $project = $event->project;
        $config = ConfigurationUtils::ReadEmailSection("project_was_created");

        $this->mailer->send('emails.notifications.project-was-created', ['project' => $project, 'config' => $config], function(Message $message) use ($project)
        {
            $message->to($project->author->email, $project->author->fullname);
            $message->subject('Your project has been successfully created');
        });
    }
}
