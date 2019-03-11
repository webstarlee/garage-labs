<?php

namespace App\Listeners;

use DB;
use App\Message;
use App\Conversation;
use App\Events\ProposalWasCreated;

class SendProposalMessage
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasCreated  $event
     * @return void
     */
    public function handle(ProposalWasCreated $event)
    {
        $proposal = $event->proposal;

        DB::beginTransaction();

        $conversation = Conversation::firstOrCreate([
            'project_id' => $proposal->project_id,
            'proposal_id' => $proposal->id
        ]);

        if($conversation->wasRecentlyCreated === true) {
            $conversation->generateMembers($proposal->project->author_id, $proposal->author_id);
        }

        Message::create([
            'conversation_id' => $conversation->id,
            'receiver_id' => $proposal->project->author_id,
            'text' => $proposal->message . PHP_EOL . " Offer is $proposal->offer" . "€",
            'sender_id' => $proposal->author_id
        ]);

        DB::commit();
    }
}
