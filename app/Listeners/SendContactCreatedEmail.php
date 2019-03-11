<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;

use App\Events\ContactWasCreated;
use App\ConfigurationUtils;

class SendContactCreatedEmail implements ShouldQueue
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
     * @param  ContactWasCreated  $event
     * @return void
     */
    public function handle(ContactWasCreated $event)
    {
        $contact = $event->contact;
        $startup = $contact->startup;
        $config = ConfigurationUtils::ReadEmailSection("contact_was_created");

        $this->mailer->send('emails.notifications.contact-was-created', ['startup' => $startup, 'config' => $config], function(Message $message) use ($startup)
        {
            $message->to($startup->author->email, $startup->author->fullname);
            $message->subject('New contact has been submitted to your startup');
        });
    }
}
