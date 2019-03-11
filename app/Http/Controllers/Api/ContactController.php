<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use App\Contact;
use App\StartupMessage;
use App\StartupMessageDocument;

use App\Events\ContactWasCreated;
use App\Http\Requests\Api\StoreContactRequest;
use App\Events\StartupMessageWasCreated;
use App\Http\Requests\Api\StoreStartupMessageRequest;

class ContactController extends Controller
{
    /**
     * ContactController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only('show', 'store');
    }

    /**
     * Fetch single Contact
     * @param string $id
     * @return Contact
     */
    public function show($id)
    {
        return Contact::where('id', $id)
            ->with('startup', 'author')
            ->firstOrFail();
    }

    /**
     * Fetch Contact
     * @param $id
     * @return mixed
     */
    public function byContactId($id)
    {
        $contact = Contact::where('id', $id)->byRelatedUsers(Auth::guard()->id())
        ->with('startup')->first();

        if ($contact == null || sizeof($contact) == 0) {
            abort(442);
        }

        return $contact;
    }

    /**
     * Store Contact
     * @param StoreContactRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreContactRequest $request)
    {
        $contact = new Contact($request->allowed());

        $contact->author_id = Auth::guard()->id();
        $contact->load('author');
        $contact->load('startup');
        $contact->save();

       event(new ContactWasCreated($contact));

        return response()->json($contact, 201);
    }

    /**
     * Retrieve Contacts for project with given id
     * @param $projectId
     * @return \Illuminate\Http\JsonResponse
     */
    public function forStartup($startupId)
    {
        return Contact::forStartup($startupId)->get();
    }

       /**
     * Retrieve messages for conversation with person with given ID
     * @param int $id
     * @return mixed
     */
     public function conversation($id)
     {
         StartupMessage::where('startup_messages.contact_id', $id)
             ->where('startup_messages.receiver_id', Auth::id())
             ->update(['status' => true]);
 
        $messages = StartupMessage::conversation()
             ->where('startup_messages.contact_id', $id)
             ->latest()
             ->paginate();
        
        $messages->load('documents');
        return $messages;
     }

    /**
     * Store message
     * @param StoreMessageRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function storeMessage(StoreStartupMessageRequest $request)
    {
        $message = new StartupMessage($request->allowed());
        $message->sender_id = Auth::guard()->id();

        DB::transaction(function() use ($message, $request) {
            $message->save();

            if(is_array($request->documents) && count($request->documents) > 0) {
                foreach($request->documents as $attachement) {
                    $doc = new StartupMessageDocument(['startup_message_id' => $message->id, 'author_id' => $message->sender_id, "filename" => $attachement['filename']]);
                    $message->documents()->save($doc);
                }
            }
        });

        $message->load('sender');
        $message->load('receiver');        
        $message->load('documents');

        event(new StartupMessageWasCreated($message));

        return response()->json($message, 201);
    }
}