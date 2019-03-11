<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array
     */
    protected $listen = [
        'App\Events\ProposalWasCreated' => [
            'App\Listeners\SendProposalMessage',
            'App\Listeners\SendProposalCreatedNotification',
            'App\Listeners\SendProposalCreatedEmail'
        ],
        'App\Events\ProposalWasAccepted' => [
            'App\Listeners\SendProposalAcceptedMessage',
            'App\Listeners\SendProposalAcceptedNotification',
            'App\Listeners\SendProposalAcceptedEmail'
        ],
        'App\Events\ProjectWasCreated' => [
            'App\Listeners\SendProjectCreatedNotification',
            'App\Listeners\SendProjectCreatedEmail'
        ],
        'App\Events\MessageWasCreated' => [
            'App\Listeners\SendMessageCreatedEmail'
        ],
        'App\Events\StartUpWasCreated' => [
            'App\Listeners\SendStartUpCreatedNotification',
            'App\Listeners\SendStartUpCreatedEmail',
            'App\Listeners\SendMemberInvitationEmail'
        ],
        'App\Events\ContactWasCreated' => [
            'App\Listeners\SendContactCreatedNotification',
            'App\Listeners\SendContactCreatedEmail'
        ],
        'App\Events\StartupMessageWasCreated' => [
            'App\Listeners\SendStartupMessageCreatedEmail'
        ],
        'App\Events\OfferWasUpdated' => [
            'App\Listeners\SendUpdatedOfferMessage',
            'App\Listeners\SendUpdatedOfferNotification',
            'App\Listeners\SendUpdatedOfferEmail'
        ],
        'App\Events\MilestoneWasCreated' => [
            'App\Listeners\SendMilestoneCreatedNotification',
            'App\Listeners\SendMilestoneCreatedEmail'
        ],
        'App\Events\MilestoneWasAccept' => [
            'App\Listeners\SendMilestoneAcceptNotification',
            'App\Listeners\SendMilestoneAcceptEmail'
        ],
        'App\Events\MilestoneWasApproved' => [
            'App\Listeners\SendMilestoneApprovedNotification',
            'App\Listeners\SendMilestoneApprovedEmail'
        ],
        'App\Events\JoinTeam' => [
            'App\Listeners\JoinTeamNotification',
        ],
        'App\Events\PackageWasFunded' => [
            'App\Listeners\SendPackageWasFundedNotification',
            'App\Listeners\SendPackageWasFundedEmail'
        ],
        'App\Events\PackageWasDelivered' => [
            'App\Listeners\SendPackageWasDeliveredNotification',
            'App\Listeners\SendPackageWasDeliveredEmail'
        ],
        'App\Events\PackageWasApproved' => [
            'App\Listeners\SendPackageWasApprovedNotification',
            'App\Listeners\SendPackageWasApprovedEmail'
        ],
        'App\Events\PackageWasAskedRevision' => [
            'App\Listeners\SendPackageWasAskedRevisionNotification',
            'App\Listeners\SendPackageWasAskedRevisionEmail'
        ],
        'App\Events\ServiceMessageWasCreated' => [
            'App\Listeners\ServiceMessageWasCreatedNotification',
            'App\Listeners\ServiceMessageWasCreatedEmail'
        ],
        'App\Events\SupportWasSent' => [
            'App\Listeners\SendCustomerSupportEmail'
        ]
    ];

    /**
     * Register any events for your application.
     *
     * @return void
     */
    public function boot()
    {
        parent::boot();

        //
    }
}
