<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use File;

use App\Proposal;
use App\User;
use App\Milestone;
use App\MilestoneDocument;
use App\DeliveryMilestone;
use App\Revision;
use App\ProjectHistory;
use App\CreditCard;

use App\Events\ProposalWasCreated;
use App\Events\ProposalWasAccepted;
use App\Events\OfferWasUpdated;
use App\Events\MilestoneWasCreated;
use App\Events\MilestoneWasAccept;
use App\Events\MilestoneWasApproved;

use App\Http\Requests\Api\StoreProposalRequest;
use App\Http\Requests\Api\UpdateProposalRequest;
use App\Http\Requests\Api\AcceptProposalRequest;
use App\Http\Requests\Api\ApproveProposalRequest;
use App\Http\Requests\Api\ModifyOfferRequest;
use App\Http\Requests\Api\FundingMilestoneRequest;
use App\Http\Requests\Api\DeliveryMilestoneRequest;
use App\Http\Requests\Api\RevisionRequest;
use App\Http\Requests\Api\SaveMilestoneRequest;

use Illuminate\Http\Request;
use Carbon\Carbon;

class ProposalController extends Controller
{
    /**
     * ProposalController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only('show', 'store', 'accept', 'update', 'approve', 
        'modifyOffer', 'fundMilestone', 'getCardId', 'loadMilestones', 'acceptMilestone', 
        'deliveryMilestone', 'loadOwnerMilestones', 'getMilestoneNo', 'saveMilestone');
    }

    /**
     * Fetch single proposal
     * @param string $id
     * @return Proposal
     */
    public function show($id)
    {
        return Proposal::where('id', $id)
            ->with('project.feedback', 'author')
            ->firstOrFail();
    }

    /**
     * Fetch proposal
     * @param $id
     * @return mixed
     */
    public function byConversationId($id)
    {
        $proposal = Proposal::byConversationId($id)->with('project')->firstOrFail();

        if ($proposal != null) {
            $project_author = User::findOrFail($proposal->project->author_id);
            $proposal_author = User::findOrFail($proposal->author_id);
            $proposal->project_author = ["name" => $project_author->username];
            $proposal->author = ["name" => $proposal_author->username];
        }
        
        return $proposal;
    }

    /**
     * Store proposal
     * @param StoreProposalRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreProposalRequest $request)
    {
        $proposal = new Proposal($request->allowed());

        $proposal->author_id = Auth::guard()->id();
        $proposal->load('author');

        DB::beginTransaction();
            $proposal->save();
            
            $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $proposal->id, 'description'=>'']);
            $history->offer($proposal->author->username, $proposal->offer);
            $history->save();
        DB::commit();
        

        event(new ProposalWasCreated($proposal));

        return response()->json($proposal, 201);
    }

    /**
     * Update proposal
     * @param UpdateProposalRequest $request
     * @param string $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UpdateProposalRequest $request, $id)
    {
        $proposal = Proposal::where('id', $id)->where('author_id', Auth::id())->firstOrFail();
        $proposal->fill($request->allowed());
        $proposal->save();

        return response()->json($proposal);
    }

    /**
     * Accept proposal
     * @param int $id
     * @param AcceptProposalRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function accept($id, AcceptProposalRequest $request)
    {
        $proposal = Proposal::findOrFail($id);
        $proposal->load('author');

        DB::beginTransaction();

        $proposal->accept();
        $proposal->save();

        $project = $proposal->project;
        $project->close();
        $project->save();

        $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $proposal->id, 'description' => '']);
        $history->acceptOffer($proposal->author->username, $proposal->offer, Auth::user()->username);
        $history->save();

        DB::commit();

        event(new ProposalWasAccepted($proposal));

        return $proposal;
    }

    /**
     * Retrieve proposals for project with given id
     * @param $projectId
     * @return \Illuminate\Http\JsonResponse
     */
    public function forProject($projectId)
    {
        return Proposal::forProject($projectId)->get();
    }

    public function modifyOffer($id, ModifyOfferRequest $request) {
        $proposal = Proposal::where('project_id', $request->project_id)
                            ->where('author_id', Auth::guard()->id())
                            ->firstOrFail();
        $proposal->offer = $request->offer;

        DB::beginTransaction();
            $proposal->save();
            
            $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $proposal->id, 'description' => '']);
            $history->modifyOffer($proposal->author->username, $proposal->offer);
            $history->save();
         DB::commit();

        event(new OfferWasUpdated($proposal));

        return [];
    }

    public function fundMilestone($id, FundingMilestoneRequest $request) {
       //  $secret_key = env("TRIPE_SECRET_KEY", "");
        $secret_key = $this->getStripeSecretKey();
        $user = User::findOrFail(Auth::guard()->id());

        \Stripe\Stripe::setApiKey($secret_key);

        $expired_str = $request->expired;
        $cvc_str = $request->cvc;

        $credit = CreditCard::where('card_id', $request->credit_card)->first();
        if ($credit != null && $credit->card_id != $user->card_id) {
            $request->update_card = 'true';
            $expired_str = $credit->expired_day;
            $cvc_str = $credit->cvc;
        }

        $expireds =  explode('/', $expired_str);

        $card_info =   array( 
            "number"=> $request->credit_card, 
            "exp_month" => $expireds[1], 
            "exp_year" => $expireds[0], 
            "cvc" =>  $cvc_str,
            'object' => 'card'
        );
        
        try {
            $totalPrice = round($request->price, 2) + round($request->fee, 2);

            if ($user->customer_id != null) {
                $customer = \Stripe\Customer::retrieve($user->customer_id);
                if ($request->update_card === 'true') {
                    $customer->source = $card_info;
                    $customer->save();
                }
            } else {
                $customer = \Stripe\Customer::create(array(
                    "description" => "Customer for ".$user->email,
                    "source" => $card_info,
                    "email" => $user->email
                ));
            }

            $user->customer_id = $customer->id;
            $user->card_id = $customer->sources->data[0]->id;
            $user->card_no = substr($request->credit_card, strlen($request->credit_card) - 4, 4);
            $user->save();

            $milestone = null;

            if ($request->milestone_id != null) {
                $milestone = Milestone::find($request->milestone_id);
                $milestone->status = 'waiting';
                $milestone->price = $request->price;
            } else {
                // Update milestone info to table
                $milestone = new Milestone($request->allowed());
                $milestone->author_id = Auth::guard()->id();
            }
            
            $milestone->funding_date = Carbon::now();

            DB::transaction(function() use ($user, $request, $customer, $milestone, $totalPrice)
            {
                $milestone->save();
                if ($request->milestone_id == null) {
                    if(is_array($request->attachments) && count($request->attachments) > 0) {
                        foreach($request->attachments as $attachement) {
                            $mdoc = new MilestoneDocument(['milestone_id' => $milestone->id, "filename" => $attachement['filename']]);
                            $milestone->documents()->save($mdoc);
                        }
                    }
                }

                \Stripe\Charge::create(array(
                    "amount" => $totalPrice * 100,
                    "currency" => "eur",
                    "customer" => $customer->id,
                    "description" => "Charge for ".$customer->email." ammount: ".$totalPrice."€"
                ));
            });

            $milestone->load('proposal');
            $milestone->action = 'funded';

            $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $milestone->proposal->id, 'description' => '']);
            $history->fundMilestone($milestone->title, $request->price);
            $history->save();

            // Send mail and notification
            event(new MilestoneWasCreated($milestone));

            if ($credit == null) {
                $credit = new CreditCard(
                    ['author_id' => Auth::guard()->id(), 
                    'card_id' => $user->card_id, 
                    'customer_id' => $user->customer_id, 
                    'card_no'  => $user->card_no,
                    'cvc' => $request->cvc,
                    'expired_day' => $request->expired
                    ]);
                $credit->save();
            }
            
            return response()->json(['card' => $user->card_id, 'funding_date' => $milestone->funding_date], 200);
          } catch(\Stripe\Error\Card $e) {
            // Since it's a decline, \Stripe\Error\Card will be caught
            return $this->handleException($e);
          } catch (\Stripe\Error\RateLimit $e) {
            // Too many requests made to the API too quickly
            return $this->handleException($e);
          } catch (\Stripe\Error\InvalidRequest $e) {
            // Invalid parameters were supplied to Stripe's API
            return $this->handleException($e);
          } catch (\Stripe\Error\Authentication $e) {
            // Authentication with Stripe's API failed
            // (maybe you changed API keys recently)
            return $this->handleException($e);
          } catch (\Stripe\Error\ApiConnection $e) {
            // Network communication with Stripe failed
            return $this->handleException($e);
          } catch (\Stripe\Error\Base $e) {
            // Display a very generic error to the user, and maybe send
            // yourself an email
            return $this->handleException($e);
          } catch (Exception $e) {
            // Something else happened, completely unrelated to Stripe
            return $this->handleException($e);
          }

        return response()->json(['card' => null], 200);
    }

    public function saveMilestone($id, SaveMilestoneRequest $request) {
        $milestone = new Milestone($request->allowed());
        $milestone->author_id = Auth::guard()->id();
        $milestone->status = 'new';

        DB::transaction(function() use ($request, $milestone)
        {
            $milestone->save();

            if(is_array($request->attachments) && count($request->attachments) > 0) {
                foreach($request->attachments as $attachement) {
                    $mdoc = new MilestoneDocument(['milestone_id' => $milestone->id, "filename" => $attachement['filename']]);
                    $milestone->documents()->save($mdoc);
                }
            }

            $milestone->load('proposal');
            $milestone->action = 'created';

            $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $milestone->proposal->id, 'description' => '']);
            $history->createMilestone($milestone->title);
            $history->save();

            // Send mail and notification
            // event(new MilestoneWasCreated($milestone));
        });

        return response()->json(['proposal_id' =>  $milestone->proposal->id], 200);    
    }

    public function getCardId() {
        $user = User::findOrFail(Auth::guard()->id());

        if ($user->customer_id == null || $user->card_id == null) {
            return response()->json(['card' => null, 'card_no' => null], 200);
        }

        return response()->json(['card' =>  $user->card_id, 'card_no' => $user->card_no], 200);      
    }

     /**
     * Store new document
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
     public function uploadDocument(Request $request)
     {
         $this->validate($request, [
             'attachment' => 'required|file|mimes:jpeg,bmp,png,jpg,doc,docx,ppt,pptx,pdf,xls,xlsx,csv,txt,zip,rar'
         ]);
 
         $filename = str_random(10) . '.' . $request->file('attachment')->getClientOriginalExtension();
         $request->file('attachment')->move(public_path('storage'), $filename);
 
         return response()->json(['filename' => $filename], 201);
    }

    public function loadMilestones($id) {
        $proposal = Proposal::where('id', $id)->where('author_id', Auth::guard()->id())->firstOrFail();
        $proposal->load('project.author');
        $proposal->load('author.bank');
        $milestones = Milestone::with(['revision', 'deliveries.documents' => function ($query) {
            $query->where('milestone_documents.type', '=', 'delivery');
        },
        'documents' => function ($query) {
            $query->where('type', '=', 'milestone');
        }])->where('proposal_id', $id)->where('status', '!=', 'new')->orderBy('id', 'desc')->get();

        $histories = ProjectHistory::where('proposal_id', $proposal->id)->orderBy('updated_at', 'desc')->get();
        $bank_account = null;
        if ($proposal->author->bank != null) {
            $bank_account = $proposal->author->bank->iban;
        }

        return [
        'milestones' => $milestones, 
        'history' => ['title' => $proposal->project->title, 'owner' => $proposal->project->author->username,
         'supplier' => $proposal->author->username, 'offer'=> $proposal->offer, 
         'author_id'=> $proposal->project->author_id, 'histories' => $histories, 'account' => $bank_account],
         'company' =>  $proposal->author->company
        ];
    }

    public function loadOwnerMilestones($id) {
        $proposal = Proposal::where('id', $id)->firstOrFail();
        $proposal->load('project.author.company');
        $proposal->load('author');

        if ($proposal->project->author_id != Auth::guard()->id()) {
            abort(404);
        }

        $milestones = Milestone::with(['deliveries.documents' => function ($query) {
            $query->where('milestone_documents.type', '=', 'delivery');
        }, 'documents' => function ($query) {
            $query->where('type', '=', 'milestone');
        }])->where('proposal_id', $id)
        ->where('author_id', Auth::guard()->id())
        ->orderBy('id', 'desc')
        ->get();

        $histories = ProjectHistory::where('proposal_id', $proposal->id)->orderBy('updated_at', 'desc')->get();

        $bank_account = null;
        if ($proposal->author->bank != null) {
            $bank_account = $proposal->author->bank->iban;
        }

        return [
            'milestones' => $milestones, 
            'history' => ['title' => $proposal->project->title, 'project_id' => $proposal->project->id, 'owner' => $proposal->project->author->username, 'supplier' => $proposal->author->username, 'offer'=> $proposal->offer, 'author_id'=> $proposal->project->author_id, 'supplier_id' => $proposal->author_id, 'histories' => $histories],
            'company' => $proposal->project->author->company
        ];
    }

    public function acceptMilestone(Request $request) {
        $milestone = Milestone::findOrFail($request->milestone_id);
        $milestone->load('proposal.project.author');

        if ($milestone->proposal == null || $milestone->proposal->author_id !== Auth::guard()->id() || $milestone->status !== 'waiting') {
            abort(404);
        }

        DB::beginTransaction();
            $milestone->accept();
            $milestone->save();
            
            $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $milestone->proposal->id, 'description' => '']);
            $history->acceptMilestone($milestone->title, Auth::user()->username);
            $history->save();
        DB::commit();

        $milestone->action = 'accepted';
        
        // Send mail and notification
        event(new MilestoneWasAccept($milestone));

        return response()->json(['status' => $milestone->status], 200);
    }

    public function approveMilestone(Request $request) {
        $milestone = Milestone::findOrFail($request->milestone_id);
        $milestone->load('proposal');

        if ($milestone->proposal == null || $milestone->author_id !== Auth::guard()->id() || $milestone->status !== 'submitted') {
            abort(404);
        }

        DB::beginTransaction();
            $milestone->approve();

            // Update invoice
            $invoices = $this->generateInvoiceNo($milestone->id, $milestone->author_id, $milestone->proposal->author_id);
            $milestone->supplier_inv_id = $invoices['supplier'];
            $milestone->owner_inv_id = $invoices['owner'];
            $milestone->inv_created_at = Carbon::now();
            $milestone->save();
            
            $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $milestone->proposal->id, 'description' => '']);
            $history->approveMilestone($milestone->title, $milestone->price, Auth::user()->username);
            $history->save();
        DB::commit();

        $milestone->action = 'approved';
        
        // Send mail and notification
        event(new MilestoneWasApproved($milestone));

        return response()->json(['status' => $milestone->status, 'invoice' => $invoices['owner']], 200);
    }

    public function deliveryMilestone(DeliveryMilestoneRequest $request) {
         // Update milestone info to table
         $deliveryMilestone = new DeliveryMilestone($request->allowed());
         $milestone = Milestone::findOrFail($request->milestone_id);

         DB::transaction(function() use ($milestone, $request, $deliveryMilestone)
         {
             $deliveryMilestone->save();
             if(is_array($request->attachments) && count($request->attachments) > 0) {
                 foreach($request->attachments as $attachement) {
                     $mdoc = new MilestoneDocument(['milestone_id' => $deliveryMilestone->id, "filename" => $attachement['filename'], 'type' => 'delivery']);
                     $deliveryMilestone->documents()->save($mdoc);
                 }
             }

             $milestone->delivery();
             $milestone->save();
         });

         
         $milestone->load('proposal.project.author');

         $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $milestone->proposal->id, 'description' => '']);
         $history->submitMilestone($milestone->title, $milestone->price, Auth::user()->username);
         $history->save();

         $milestone->action = 'delivery';

         // Send mail and notification
         event(new MilestoneWasAccept($milestone));

         $milestone->load('deliveries.documents');

         return response()->json(['status' => $milestone->status, 'deliveries' => $milestone->deliveries], 200);
    }

    public function askRevision(RevisionRequest $request) {
         // Update milestone info to table
         $revision = new Revision($request->allowed());
         $milestone = Milestone::findOrFail($request->milestone_id);

         DB::transaction(function() use ($milestone, $request, $revision)
         {
             $revision->save();

             $milestone->accept();
             $milestone->save();
         });

         
         $milestone->load('proposal.project.author');

         $history = new ProjectHistory(['author_id' => Auth::guard()->id(), 'proposal_id' => $milestone->proposal->id, 'description' => '']);
         $history->askRevision($milestone->title, $milestone->price, Auth::user()->username);
         $history->save();

         $milestone->action = 'asked revision.';

         // Send mail and notification
         event(new MilestoneWasApproved($milestone));

         return response()->json(['status' => $milestone->status], 200);
    }

    public function getMilestoneNo($id) {
        $no = Milestone::where('proposal_id', $id)->where('author_id', Auth::guard()->id())->count() + 1;
        return response()->json(['no' => $no], 200);
    }

    private function handleException($e) {
        $body = $e->getJsonBody();
        $err  = $body['error'];

        return response()->json(['message' => $err['message']], 402);
    }

    private function getStripeSecretKey() {
        return \Config::get('stripe.secret_key');
    }

    private function generateRandomString($length = 6) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return strtoupper($randomString);
    }

    private function generateInvoiceNo($milestoneId, $ownerId, $supplierId) {
        $randomStr = $this->generateRandomString();
        $now = Carbon::now()->format('dmY');
        return ['owner' => $randomStr.$milestoneId.$ownerId."-".$now, 'supplier' => $randomStr.$milestoneId.$supplierId."-".$now] ;
    }
}