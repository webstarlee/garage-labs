<?php

namespace App\Listeners;

use App\Events\MilestoneWasApproved;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Message;
use App\ConfigurationUtils;

class SendMilestoneApprovedEmail implements ShouldQueue
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
    public function handle(MilestoneWasApproved $event)
    {
        $milestone = $event->milestone;
        $proposal = $milestone->proposal;

        $action = 'funded';
        if(isset($milestone->action)) {
            $action = $milestone->action;
        }

        $config = ConfigurationUtils::ReadEmailSection("milestone_was_approved");

        $this->mailer->send('emails.notifications.milestone-was-approved', ['milestone' => $milestone, 'config' => $config], function(Message $message) use ($proposal, $action)
        {
            $message->to($proposal->author->email, $proposal->author->fullname);
            $message->subject('Your milestone has been '.$action);
        });
    }
}
