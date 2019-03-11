<?php

namespace App\Listeners;

use App\Events\MilestoneWasAccept;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Message;
use App\ConfigurationUtils;

class SendMilestoneAcceptEmail implements ShouldQueue
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
     * @param  ProposalWasAccepted  $event
     * @return void
     */
    public function handle(MilestoneWasAccept $event)
    {
        $milestone = $event->milestone;
        $proposal = $milestone->proposal;

        $action = 'accept';
        if(isset($milestone->action)) {
            $action = $milestone->action;
        }

        $config = ConfigurationUtils::ReadEmailSection("milestone_was_accept");

        $this->mailer->send('emails.notifications.milestone-was-accept', ['milestone' => $milestone, 'config' => $config], function(Message $message) use ($proposal, $action)
        {
            $message->to($proposal->project->author->email, $proposal->project->author->fullname);
            $message->subject('Your milestone has been '.$action);
        });
    }
}
