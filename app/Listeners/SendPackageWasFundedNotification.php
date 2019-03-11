<?php

namespace App\Listeners;

use App\Notification;
use App\Events\PackageWasFunded;

class SendPackageWasFundedNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(PackageWasFunded $event)
    {
        $packageOrder = $event->packageOrder;
        $package = $packageOrder->package;
        $service = $package->service;

        $action = 'ordered';

        Notification::create([
            'receiver_id' => $package->author_id,
            'title' => 'New package '.' was '.$action,
            'message' => 'New package of your service "'.$service->title.'" was '.$action. PHP_EOL ."Ammount: $package->price €",
            'link' => "/user/sold-package/$packageOrder->id"
        ]);
    }
}