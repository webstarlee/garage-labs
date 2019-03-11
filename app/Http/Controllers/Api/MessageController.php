<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use App\Message;
use App\Conversation;
use App\ServiceMessage;
use App\StartupMessage;
use Illuminate\Http\Request;
use App\Events\MessageWasCreated;
use App\Http\Requests\Api\ReadMessageRequest;
use App\Http\Requests\Api\StoreMessageRequest;

class MessageController extends Controller
{
    /**
     * MessageController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api');
    }

    /**
     * Store message
     * @param StoreMessageRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreMessageRequest $request)
    {
        $message = new Message($request->allowed());
        $message->sender_id = Auth::guard()->id();

        DB::transaction(function() use ($message, $request) {
            $message->save();

            if(count($request->documents)) {
                $message->documents()->attach(array_pluck($request->documents, 'id'));
            }
        });

        $message->load('documents');

        event(new MessageWasCreated($message));

        return response()->json($message, 201);
    }

    /**
     * Change status of read
     * @param int $id
     * @param ReadMessageRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function read($id, ReadMessageRequest $request)
    {
        $message = Message::find($id);
        $message->update(['read' => true]);

        return response()->json(['message' => 'ok'], 200);
    }

    /**
     * Fetching count of unread notifications
     * @return \Illuminate\Http\JsonResponse
     */
    public function unread()
    {
        return response()->json(['messages' => Message::forReceiver(Auth::id())->unread()->count()]);
    }

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function threads()
    {
        return Conversation::withMemberById(Auth::id())
            ->withLastMessage()
            ->get();
    }

    /**
     * Retrieve messages for conversation with person with given ID
     * @param int $id
     * @return mixed
     */
    public function conversation($id)
    {
        if(! Conversation::withMemberById(Auth::id())->where('conversations.id', $id)->exists()) {
            abort(403);
        }

        Message::where('messages.conversation_id', $id)
            ->where('messages.receiver_id', Auth::id())
            ->update(['read' => true]);

        return Message::conversation()
            ->with('documents')
            ->where('messages.conversation_id', $id)
            ->latest()
            ->paginate();
    }

    /**
     * Fetch conversations
     * @param Request $request
     */
    public function conversations(Request $request)
    {
        $this->validate($request, [
            'user_id' => 'required|integer|exists:users,id|not_in:' . Auth::id()
        ]);

        return Conversation::with('project')
            ->hasMembers([Auth::id(), $request->user_id])
            ->get();
    }

    public function serviceMessages() {
        $max_ids = DB::table('service_messages')
            ->where('service_messages.receiver_id', Auth::id())
            ->orWhere('service_messages.sender_id', Auth::id())
            ->groupBy('ordered_package_id')
            ->get([DB::raw('MAX(id) as id')]);
        $ids = [];
        if ($max_ids != null && count($max_ids) > 0) {
            foreach ($max_ids as $it) {
                $ids[] = $it->id;
            }
        }

        $messages = ServiceMessage::conversation()
            ->whereIn('service_messages.id', $ids)
            ->orderBy('service_messages.id', 'desc')
            ->get();
        
        $messages->load('ordered_package.package.service');

        return $messages;
    }

    public function startupMessages() {
        $max_ids = DB::table('startup_messages')
            ->where('startup_messages.receiver_id', Auth::id())
            ->orWhere('startup_messages.sender_id', Auth::id())
            ->groupBy('contact_id')
            ->get([DB::raw('MAX(id) as id')]);
        $ids = [];
        if ($max_ids != null && count($max_ids) > 0) {
            foreach ($max_ids as $it) {
                $ids[] = $it->id;
            }
        }

        $messages = StartupMessage::conversation()
            ->whereIn('startup_messages.id', $ids)
            ->orderBy('id', 'desc')
            ->get();
        
        $messages->load('contact.startup');

        return $messages;
    }
}