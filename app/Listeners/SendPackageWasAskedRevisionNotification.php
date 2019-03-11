<?php

namespace App\Listeners;

use App\Notification;
use App\Events\PackageWasAskedRevision;

class SendPackageWasAskedRevisionNotification
{
    /**
     * Handle the event.
     *
     * @param  PackageWasAskedRevision  $event
     * @return void
     */
    public function handle(PackageWasAskedRevision $event)
    {
        $packageOrder = $event->packageOrder;
        $package = $packageOrder->package;
        $service = $package->service;

        $action = 'asked revision';

        Notification::create([
            'receiver_id' => $package->author_id,
            'title' => 'The package '.' was '.$action,
            'message' => 'The package of your service "'.$service->title.'" was '.$action. PHP_EOL ."Ammount: $package->price €",
            'link' => "/user/sold-package/$packageOrder->id"
        ]);
    }
}