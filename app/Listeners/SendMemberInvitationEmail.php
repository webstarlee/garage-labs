<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\StartUpWasCreated;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\ConfigurationUtils;

class SendMemberInvitationEmail implements ShouldQueue
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
        $teams = $startup->teams;
        $config = ConfigurationUtils::ReadEmailSection("member_invitation");

        foreach($teams as  $member) {
            if ($member->active === 0) {
                $this->mailer->send('emails.notifications.member-invitation',['member' => $member, 
                'title' =>  $startup->title, 'slug' => $startup->slug, 
                'authorname' => $startup->author->fullname, 'config' => $config],
                function(Message $message) use ($member, $startup)
               {
                   $message->to($member->email, $member->name);
                   $message->subject($startup->author->fullname.' is inviting to join"'.$startup->title.'"as "'.$member->role.'"');
               });
            }
        }
    }
}
