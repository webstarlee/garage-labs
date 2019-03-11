<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\ServiceMessageWasCreated;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\ConfigurationUtils;

class ServiceMessageWasCreatedEmail implements ShouldQueue
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
     * @param  ServiceMessageWasCreated  $event
     * @return void
     */
    public function handle(ServiceMessageWasCreated $event)
    {
        $message = $event->message;
        $sender = $message->sender;
        $config = ConfigurationUtils::ReadEmailSection("service_message_was_created");

        $this->mailer->send('emails.notifications.service-message-was-created',
            [
                '_message' => $message,
                'sender' => $sender, 
                'config' => $config
            ],
            function(Message $email) use ($message)
        {
            $email->subject('You have got new message');
            $email->to($message->receiver->email, $message->receiver->fullname);
        });
    }
}