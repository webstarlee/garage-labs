<?php

namespace App\Listeners;

use Illuminate\Mail\Message;
use App\Events\ProposalWasCreated;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\ConfigurationUtils;

class SendProposalCreatedEmail implements ShouldQueue
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
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(ProposalWasCreated $event)
    {
        $proposal = $event->proposal;
        $project = $proposal->project;
        $config = ConfigurationUtils::ReadEmailSection("proposal_was_created");

        $this->mailer->send('emails.notifications.proposal-was-created', ['project' => $project, 'config' => $config], function(Message $message) use ($project)
        {
            $message->to($project->author->email, $project->author->fullname);
            $message->subject('New proposal has been submitted to your project');
        });
    }
}
