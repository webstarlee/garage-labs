<?php

namespace App\Listeners;

use App\Events\PackageWasAskedRevision;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Message;
use App\ConfigurationUtils;

class SendPackageWasAskedRevisionEmail implements ShouldQueue
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
     * @param  PackageWasFunded  $event
     * @return void
     */
    public function handle(PackageWasAskedRevision $event)
    {
        $packageOrder = $event->packageOrder;
        $package = $packageOrder->package;
        $service = $package->service;
        $author = $service->author;
        $action = 'asked revision';
        $config = ConfigurationUtils::ReadEmailSection("package_was_funded");

        $this->mailer->send('emails.notifications.package-was-funded', ['package' => $package, 'actionName' => $action, 
        'orderedId' => $packageOrder->id, 'url' => "/user/sold-package/$packageOrder->id", 'config' => $config], function(Message $message) use ($package, $action, $author)
        {
            $message->to($author->email, $author->fullname);
            $message->subject('Your package has been '.$action);
        });
    }
}
