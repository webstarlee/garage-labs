<?php

namespace App\Listeners;

use App\Notification;
use App\Events\PackageWasDelivered;

class SendPackageWasDeliveredNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(PackageWasDelivered $event)
    {
        $packageOrder = $event->packageOrder;
        $buyer = $packageOrder->buyer;
        $package = $packageOrder->package;
        $service = $package->service;

        $action = 'delivered';

        Notification::create([
            'receiver_id' => $buyer->id,
            'title' => 'The package '.' was '.$action,
            'message' => 'The package of your service "'.$service->title.'" was '.$action. PHP_EOL ."Ammount: $package->price €",
            'link' => "/user/ordered-package/$packageOrder->id"
        ]);
    }
}