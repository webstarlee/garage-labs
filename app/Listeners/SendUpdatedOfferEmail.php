<?php

namespace App\Listeners;

use App\Events\OfferWasUpdated;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Message;
use App\ConfigurationUtils;

class SendUpdatedOfferEmail implements ShouldQueue
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
    public function handle(OfferWasUpdated $event)
    {
        $proposal = $event->proposal;
        $conversation = $proposal->conversation;
        $config = ConfigurationUtils::ReadEmailSection("offer_was_updated");

        $this->mailer->send('emails.notifications.offer-was-updated', ['conversation' => $conversation, 'config' => $config], function(Message $message) use ($proposal)
        {
            $message->to($proposal->project->author->email, $proposal->project->author->fullname);
            $message->subject('The offer of your proposal was updated');
        });
    }
}
