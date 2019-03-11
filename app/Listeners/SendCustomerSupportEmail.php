<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\SupportWasSent;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendCustomerSupportEmail implements ShouldQueue
{
    /**
     * Mailer contract implementation
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
     * @param  SupportWasSent  $event
     * @return void
     */
    public function handle(SupportWasSent $event)
    {
        $customerSupport = $event->customerSupport;

        $this->mailer->send('emails.notifications.support-was-sent', ['support' => $customerSupport, 'userid' => $customerSupport->author->id], function(Message $message) use ($customerSupport)
        {
            $message->to("support@thegaragelabs.com", $customerSupport->author->fullname);
            $message->subject('Customer Support');
        });
    }
}
