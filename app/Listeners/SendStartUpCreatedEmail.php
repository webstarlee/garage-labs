<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\StartUpWasCreated;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\ConfigurationUtils;

class SendStartUpCreatedEmail implements ShouldQueue
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
     * @param  startupWasCreated  $event
     * @return void
     */
    public function handle(StartUpWasCreated $event)
    {
        $startup = $event->startup;
        $config = ConfigurationUtils::ReadEmailSection("startup_was_created");

        $this->mailer->send('emails.notifications.startup-was-created', ['startup' => $startup, 'config' => $config], 
        function(Message $message) use ($startup)
        {
            $message->to($startup->author->email, $startup->author->fullname);
            $message->subject('Your startup has been successfully created');
        });
    }
}
