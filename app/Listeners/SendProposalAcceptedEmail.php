<?php

namespace App\Listeners;

use App\Events\ProposalWasAccepted;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Message;
use App\ConfigurationUtils;

class SendProposalAcceptedEmail implements ShouldQueue
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
    public function handle(ProposalWasAccepted $event)
    {
        $proposal = $event->proposal;
        $conversation = $proposal->conversation;

        $action = 'accepted';
        if(isset($proposal->action)) {
            $action = $proposal->action;
        }

        $config = ConfigurationUtils::ReadEmailSection("proposal_was_accepted");

        $this->mailer->send('emails.notifications.proposal-was-accepted', ['conversation' => $conversation, 'config' => $config], function(Message $message) use ($proposal)
        {
            $message->to($proposal->author->email, $proposal->author->fullname);
            $message->subject('Your proposal has been '.$action);
        });
    }
}
