<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\MessageWasCreated;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\ConfigurationUtils;

class SendMessageCreatedEmail implements ShouldQueue
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
     * @param  MessageWasCreated  $event
     * @return void
     */
    public function handle(MessageWasCreated $event)
    {
        $message = $event->message;
        $sender = $message->sender;
        $config = ConfigurationUtils::ReadEmailSection("message_was_created");

        $this->mailer->send('emails.notifications.message-was-created',
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