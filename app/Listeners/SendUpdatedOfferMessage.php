<?php

namespace App\Listeners;

use DB;
use App\Message;
use App\Conversation;
use App\Events\OfferWasUpdated;

class SendUpdatedOfferMessage
{
    /**
     * Handle the event.
     *
     * @param  OfferWasUpdated  $event
     * @return void
     */
    public function handle(OfferWasUpdated $event)
    {
        $proposal = $event->proposal;

        DB::beginTransaction();

        $conversation = Conversation::where('project_id', $proposal->project_id)
                                    ->where('proposal_id', $proposal->id)
                                    ->firstOrFail();

        Message::create([
            'conversation_id' => $conversation->id,
            'receiver_id' => $proposal->project->author_id,
            'text' => 'Offer was updated. Amount: ' . $proposal->offer . '€',
            'sender_id' => $proposal->author_id
        ]);

        DB::commit();
    }
}
