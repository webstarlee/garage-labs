<?php

namespace App\Listeners;

use App\Events\PackageWasDelivered;
use Illuminate\Contracts\Mail\Mailer;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Message;
use App\ConfigurationUtils;

class SendPackageWasDeliveredEmail implements ShouldQueue
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
     * @param  PackageWasDelivered  $event
     * @return void
     */
    public function handle(PackageWasDelivered $event)
    {
        $packageOrder = $event->packageOrder;
        $buyer = $packageOrder->buyer;
        $package = $packageOrder->package;
        $service = $package->service;
        $action = 'delivered';
        $config = ConfigurationUtils::ReadEmailSection("package_was_funded");

        $this->mailer->send('emails.notifications.package-was-funded', ['package' => $package, 'actionName' => $action, 
        'orderedId' => $packageOrder->id, 'url' => "/user/sold-package/$packageOrder->id", 'config' => $config], function(Message $message) use ($package, $action, $buyer)
        {
            $message->to($buyer->email, $buyer->fullname);
            $message->subject('Your package has been '.$action);
        });
    }
}
