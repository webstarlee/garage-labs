<?php

namespace App\Listeners;

use App\Notification;
use App\Events\PackageWasApproved;

class SendPackageWasApprovedNotification
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(PackageWasApproved $event)
    {
        $packageOrder = $event->packageOrder;
        $package = $packageOrder->package;
        $service = $package->service;

        $action = 'approved';

        Notification::create([
            'receiver_id' => $package->author_id,
            'title' => 'The package '.' was '.$action,
            'message' => 'The package of your service "'.$service->title.'" was '.$action. PHP_EOL ."Ammount: $package->price €",
            'link' => "/user/sold-package/$packageOrder->id"
        ]);
    }
}