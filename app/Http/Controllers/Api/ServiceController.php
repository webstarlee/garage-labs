<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use Illuminate\Http\Request;
use App\ServiceCategory;
use App\Service;
use App\Gallery;
use App\Package;
use App\User;
use App\PackageOrder;
use App\PackageDocument;
use App\PackageDeliveryDocument;
use App\PackageDelivery;
use App\PackageFeedback;
use App\PackageRevisionDocument;
use App\PackageRevision;
use App\ServiceMessage;
use App\ServiceMessageDocument;
use App\CreditCard;

use App\Http\Requests\Api\ServiceRequest;
use App\Http\Requests\Api\PackageDeliveryRequest;
use App\Http\Requests\Api\PackageFeedbackRequest;
use Illuminate\Database\Eloquent\Builder;
use App\Http\Requests\Api\OrderConfirmationRequest;
use App\Http\Requests\Api\StoreServiceMessageRequest;

use App\Events\PackageWasFunded;
use App\Events\PackageWasDelivered;
use App\Events\PackageWasApproved;
use App\Events\PackageWasAskedRevision;
use App\Events\ServiceMessageWasCreated;

use Carbon\Carbon;

class ServiceController extends Controller
{
    /**
     * ProjectController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only([
            'create',
            'getMyServices',
            'getPackageById',
            'doPayment',
            'addInstruction',
            'getMyOrderedServices',
            'getMySoldPackages',
            'approveDelivery',
            'feedback',
            'submitAskRevision',
            'deliveryPackage',
            'storeMessage'
        ]);
    }

     /**
     * The "booting" method of the model.
     *
     * @return void
     */
    public static function boot()
    {
        parent::boot();

        static::creating(function(Service $service) {
            $service->generateSlug();
        });
    }

    /**
     * Fetch categories
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function loadCategories()
    {
        $categories = ServiceCategory::serviceCount()->get();
        $categories->load('subcategories');

        $categories->load(['subcategories' => function ($query) {
            $query->leftJoin('services', 'services.subcategory_id', '=', 'service_subcategories.id');
            $query->groupBy('services.subcategory_id');
            $query->addSelect(DB::raw('count(services.id) as services_count'));
        }]);

        return $categories;
    }

    /**
     * Retrieving Service
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $service = Service::filter($request->all())
            ->latest()
            ->paginate();
        
        // $service->load('galleries');
        $service->load('packages');
        $service->load('author');
        $service->load('images');
        $service->load('videos');

        return $service;
    }

    /**
     * Store new document
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadDocument(Request $request)
    {
        $this->validate($request, [
            'attachment' => 'required|file|mimes:jpeg,bmp,png,jpg'
        ]);

        $filename = str_random(10) . '.' . $request->file('attachment')->getClientOriginalExtension();
        $request->file('attachment')->move(public_path('storage/gallery'), $filename);

        return response()->json(['filename' => "gallery/$filename"], 201);
   }

    public function create(ServiceRequest $request) {
        // Update
        if ($request->id != null) {
            $service = Service::where('author_id', Auth::guard()->id())->where('id', $request->id)->firstOrFail();
            $service->fill($request->allowed());
        } else {
            $service = new Service($request->allowed());
            $service->author_id = Auth::guard()->id();
        }

        DB::transaction(function() use ($service, $request)
        {
            $service->save();

            // Update, delete old value
            if ($request->id != null) { 
                Gallery::where('service_id', $service->id)->delete();
                Package::where('service_id', $service->id)->delete();
            }

            if(is_array($request->images) && count($request->images) > 0) {
                foreach($request->images as $attachement) {
                    $gallery = new Gallery(['service_id' => $service->id, "filename" => $attachement['filename'], 'type' => 'image']);
                    $service->galleries()->save($gallery);
                }
            }

            if(is_array($request->videos) && count($request->videos) > 0) {
                foreach($request->videos as $video) {
                    $video = new Gallery(['service_id' => $service->id, "filename" => $video['filename'], 'type' => 'video']);
                    $service->galleries()->save($video);
                }
            }

            if(is_array($request->packages) && count($request->packages) > 0) {
                foreach($request->packages as $option) {
                    $package = new Package([
                    'service_id' => $service->id,
                    "author_id" => $service->author_id,
                    "name" => $option['name'],
                    "description" => $option['description'],
                    "price" => $option['price'],
                    "days_to_deliver" => $option['days_to_deliver'],
                    "number_devisions" => $option['number_devisions'],
                    "instruction" => $option['instruction'],
                    ]);

                    $service->packages()->save($package);
                }
            }
        });

        return response()->json($service, 201);
   }

   public function getMyServices() {
       $myServices = Service::withMeta()->where('author_id', Auth::guard()->id())->get();
       return $myServices;
   }

   public function getMyOrderedPackages() {
       $orderedPackges = PackageOrder::with('seller')->where('buyer_id', Auth::guard()->id())
       ->get();

       $orderedPackges->load('package.service');
       return $orderedPackges;
   }

   public function getMySoldPackages() {
        $soldPackges = PackageOrder::with('buyer')->where('seller_id', Auth::guard()->id())->get();

        $soldPackges->load('package.service');
        return $soldPackges;
   }

   public function delete(Request $request) {
        $service = Service::where('author_id', Auth::guard()->id())->where('id', $request->id)->firstOrFail();

        DB::transaction(function() use ($service, $request){
            Gallery::where('service_id', $service->id)->delete();
            Package::where('service_id', $service->id)->delete();
            $service->delete();
        });
       

        return response()->json(["message" => "OK"], 200);
   }

   public function getServiceById($id) {
        $service = Service::where('id', $id)->firstOrFail();
        $service->load('packages.feedbacks.author');
        $service->load('galleries');
        $service->load('author');

        return $service;
   }

   public function getPackageById($id) {
        $package = Package::where('id', $id)->firstOrFail();

        if ($package->author_id == Auth::guard()->id()) {
            abort(404);
        }

        $author = User::where('id', Auth::guard()->id())->firstOrFail();
        $package->load('author');
        return response()->json(['package' => $package, 'author' => $author], 201);
   }

   public function getPackageOrderById($id) {
        $packageOrder = PackageOrder::where('id', $id)->firstOrFail();
        $packageOrder->load('buyer.company');
        $packageOrder->load('seller.company');
        $packageOrder->load('package.service.author');
        $packageOrder->load('documents');
        $packageOrder->load('package_delivery.documents');
        $packageOrder->load('package_revisions.documents');

        return $packageOrder;
    }

   public function doPayment(OrderConfirmationRequest $request) {
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

    $package = Package::findOrFail($request->package_id);
    
    try {
        $totalPrice = round(round($package->price, 2) + round($package->price*3.5/100, 2), 2);
        
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

        if ($request->remember === 'true') {
            $user->save();
        }

        if ($request->remember === 'true') {
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
        }

        $packageOrder = new PackageOrder($request->allowed());
        $packageOrder->paying_date = Carbon::now();
        $packageOrder->buyer_id = Auth::guard()->id();
        $packageOrder->seller_id = $package->author_id;

        DB::transaction(function() use ($user, $request, $customer, $packageOrder, $totalPrice)
        {
            $packageOrder->save();

            \Stripe\Charge::create(array(
                "amount" => $totalPrice * 100,
                "currency" => "eur",
                "customer" => $customer->id,
                "description" => "Charge for ".$customer->email." ammount: ".$totalPrice."€"
            ));
        });

        $packageOrder->load('package.service.author');

         // Send mail and notification
         event(new PackageWasFunded($packageOrder));

        return response()->json(['card' => $user->card_id, 'package_order_id' => $packageOrder->id], 200);
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
   
    /**
     * Store new document
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadInstructionDocument(Request $request)
    {
        $this->validate($request, [
            'attachment' => 'required|file|mimes:jpeg,bmp,png,jpg,doc,docx,ppt,pptx,pdf,xls,xlsx,csv,txt,zip,rar'
        ]);

        $filename = str_random(10) . '.' . $request->file('attachment')->getClientOriginalExtension();
        $request->file('attachment')->move(public_path('storage/instruction'), $filename);

        return response()->json(['filename' => "instruction/$filename"], 201);
   }

   public function addInstruction(Request $request) {
        $this->validate($request, [
            'instruction' => 'required'
        ]);

        $packageOrder = PackageOrder::where('id', $request->package_order_id)->firstOrFail();
        $package = Package::findOrFail($packageOrder->package_id);

        $packageOrder->instruction = $request->instruction;
        $packageOrder->save();

        if(is_array($request->attachments) && count($request->attachments) > 0) {
            foreach($request->attachments as $attachement) {
                $doc = new PackageDocument(['package_order_id' => $packageOrder->id, 'package_id' => $packageOrder->package_id, "filename" => $attachement['filename']]);
                $packageOrder->documents()->save($doc);
            }
        }

        return response()->json(['package_id' => $package->id, 'ordered_package_id' => $packageOrder->id], 201);
    }

    /**
     * Store new document
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadDeliveryDocument(Request $request)
    {
        $this->validate($request, [
            'attachment' => 'required|file|mimes:jpeg,bmp,png,jpg,doc,docx,ppt,pptx,pdf,xls,xlsx,csv,txt,zip,rar'
        ]);

        $filename = str_random(10) . '.' . $request->file('attachment')->getClientOriginalExtension();
        $request->file('attachment')->move(public_path('storage/package_delivery'), $filename);

        return response()->json(['filename' => "package_delivery/$filename"], 201);
   }

   /**
     * Store new document
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadRevisionDocument(Request $request)
    {
        $this->validate($request, [
            'attachment' => 'required|file|mimes:jpeg,bmp,png,jpg,doc,docx,ppt,pptx,pdf,xls,xlsx,csv,txt,zip,rar'
        ]);

        $filename = str_random(10) . '.' . $request->file('attachment')->getClientOriginalExtension();
        $request->file('attachment')->move(public_path('storage/package_revision'), $filename);

        return response()->json(['filename' => "package_revision/$filename"], 201);
   }

   
    public function deliveryPackage(PackageDeliveryRequest $request) {
        $packageDelivery = new PackageDelivery($request->allowed());
        $packageOrder = PackageOrder::findOrFail($request->ordered_package_id);

        if ($packageOrder->seller_id !== Auth::guard()->id()) {
            abort(404);
        }

        DB::transaction(function() use ($packageOrder, $request, $packageDelivery)
        {
            $packageDelivery->save();
            if(is_array($request->attachments) && count($request->attachments) > 0) {
                foreach($request->attachments as $attachement) {
                    $pdoc = new PackageDeliveryDocument(['package_delivery_id' => $packageDelivery->id, "filename" => $attachement['filename']]);
                    $packageDelivery->documents()->save($pdoc);
                }
            }

            $packageOrder->setDelivery();
            $packageOrder->save();

            if ($request->revision_id != 'null') {
                $revision = PackageRevision::find($request->revision_id);
                if ($revision !== null) {
                    $revision->status = 'delivered';
                    $revision->save();
                }
            }
        });

        $packageOrder->load(['buyer', 'package.service.author']);

        // Send mail and notification
        event(new PackageWasDelivered($packageOrder));

        return response()->json(['status' => $packageOrder->status], 200);
   }

   public function approveDelivery(Request $request) {
        $packageOrder = PackageOrder::findOrFail($request->package_order_id);

        if ($packageOrder->buyer_id !== Auth::guard()->id()) {
            abort(404);
        }

        DB::beginTransaction();
        $packageOrder->approve();
            // Update invoice
            $invoices = $this->generateInvoiceNo($packageOrder->id, $packageOrder->seller_id, $packageOrder->buyer_id);
            $packageOrder->supplier_inv_id = $invoices['supplier'];
            $packageOrder->owner_inv_id = $invoices['owner'];
            $packageOrder->inv_created_at = Carbon::now();

            $packageOrder->save();
        DB::commit();

        $packageOrder->action = "approved";
        $packageOrder->load('package.service.author');

        // Send mail and notification
        event(new PackageWasApproved($packageOrder));

        $packageOrder->load('buyer.company');
        $packageOrder->load('seller.company');
        $packageOrder->load('documents');
        $packageOrder->load('package_delivery.documents');
        $packageOrder->load('package_revisions.documents');
        
        return $packageOrder;
   }

    public function feedback(PackageFeedbackRequest $request) {
        $author = User::findOrFail($request->seller_id);
        $author->update_rating($request->rating);
        $author->save();

        $feedback = new PackageFeedback($request->allowed());
        // $feedback->seller_id = Auth::id();

        $feedback->save();

        return response()->json($feedback, 201);
    }

    public function submitAskRevision(Request $request) {
        $this->validate($request, [
            'description' => 'required'
        ]);

        $packageOrder = PackageOrder::findOrFail($request->ordered_package_id);
        
        if ($packageOrder->buyer_id !== Auth::guard()->id()) {
            abort(404);
        }

        $package = Package::findOrFail($packageOrder->package_id);

        if ($packageOrder->asked_revisions >= $package->number_devisions) {
            abort(404);
        }

        DB::transaction(function() use ($packageOrder, $request)
        {
            $packageOrder->askRevision();
            $packageOrder->increase_asked_revisions();
            $packageOrder->save();

            $revision = new PackageRevision($request->all());
            $revision->save();

            if(is_array($request->attachments) && count($request->attachments) > 0) {
                foreach($request->attachments as $attachement) {
                    $pdoc = new PackageRevisionDocument(['package_revision_id' => $revision->id, "filename" => $attachement['filename']]);
                    $revision->documents()->save($pdoc);
                }
            }
        });

        $packageOrder->load('package.service.author');

        // Send mail and notification
        event(new PackageWasAskedRevision($packageOrder));

        return response()->json(['status' => $packageOrder->status], 200);
    }

    /**
     * Retrieve messages for conversation with person with given ID
     * @param int $id
     * @return mixed
     */
    public function conversation($id)
    {
        ServiceMessage::where('service_messages.ordered_package_id', $id)
            ->where('service_messages.receiver_id', Auth::id())
            ->update(['status' => true]);

        return ServiceMessage::conversation()
            ->with('documents')
            ->where('service_messages.ordered_package_id', $id)
            ->where('service_messages.receiver_id', Auth::id())
            ->orWhere(function ($query) use ($id) {
                $query->where('service_messages.sender_id', Auth::id())
                      ->where('service_messages.ordered_package_id', $id);
            })
            ->latest()
            ->paginate();
    }

    /**
     * Store message
     * @param StoreMessageRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function storeMessage(StoreServiceMessageRequest $request)
    {
        $message = new ServiceMessage($request->allowed());
        $message->sender_id = Auth::guard()->id();

        DB::transaction(function() use ($message, $request) {
            $message->save();

            if(is_array($request->documents) && count($request->documents) > 0) {
                foreach($request->documents as $document) {
                    $mdoc = new ServiceMessageDocument(['service_message_id' => $message->id, "filename" => $document['filename']]);
                    $message->documents()->save($mdoc);
                }
            }
        });

        $message->load('sender');
        $message->load('receiver');        
        $message->load('documents');

        event(new ServiceMessageWasCreated($message));

        return response()->json($message, 201);
    }
    
    private function getStripeSecretKey() {
        return \Config::get('stripe.secret_key');
    }

    private function handleException($e) {
        $body = $e->getJsonBody();
        $err  = $body['error'];

        return response()->json(['message' => $err['message']], 402);
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

    private function generateInvoiceNo($orderedPackageId, $ownerId, $supplierId) {
        $randomStr = $this->generateRandomString();
        $now = Carbon::now()->format('dmY');
        return ['owner' => $randomStr.$orderedPackageId.$ownerId."-".$now, 'supplier' => $randomStr.$orderedPackageId.$supplierId."-".$now] ;
    }
}