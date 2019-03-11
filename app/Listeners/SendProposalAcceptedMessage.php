<?php

namespace App\Listeners;

use DB;
use App\Message;
use App\Conversation;
use App\Events\ProposalWasAccepted;

class SendProposalAcceptedMessage
{
    /**
     * Handle the event.
     *
     * @param  ProposalWasAccepted  $event
     * @return void
     */
    public function handle(ProposalWasAccepted $event)
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

        $action = 'accepted';
        if(isset($proposal->action)) {
            $action = $proposal->action;
        }

        Message::create([
            'conversation_id' => $conversation->id,
            'receiver_id' => $proposal->author_id,
            'text' => 'Proposal was '.$action.'. Amount: ' . $proposal->offer . '€',
            'sender_id' => $proposal->project->author_id
        ]);

        DB::commit();
    }
}
