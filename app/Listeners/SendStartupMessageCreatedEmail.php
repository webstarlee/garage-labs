<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\StartupMessageWasCreated;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Notification;
use App\ConfigurationUtils;

class SendStartupMessageCreatedEmail implements ShouldQueue
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
     * @param  StartupMessageWasCreated  $event
     * @return void
     */
    public function handle(StartupMessageWasCreated $event)
    {
        $message = $event->message;
        $sender = $message->sender;

        Notification::create([
            'receiver_id' =>$message->receiver->id,
            'title' => "New message from $sender->fullname",
            'message' => $message->text,
            'link' => "/user/messages/startup-thread/$message->contact_id"
        ]);
        
        $config = ConfigurationUtils::ReadEmailSection("startup_message_was_created");

        $this->mailer->send('emails.notifications.startup-message-was-created',
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