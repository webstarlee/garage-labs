<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use App\User;
use App\StartUp;
use App\FondsType;

use Illuminate\Http\Request;
use App\Events\StartUpWasCreated;
use App\Http\Requests\Api\StoreStartUpRequest;
use App\Http\Requests\Api\UpdateStartUpRequest;
use App\Http\Requests\Api\InvitationRequest;

class StartUpController extends Controller
{
    /**
     * StartUpController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only([
            'checkFirst',
            'store',
            'update',
            'forUser',
            'applied'
        ]);
    }

    /**
     * Validate StartUp first stage
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function checkFirst(Request $request)
    {
        $this->validate($request, [
            'title' => 'required',
            'categories' => 'required|array|min:1',
            'categories.*.id' => 'required|integer|exists:scategories,id',
            'finding' => 'required|array|min:1',
            'finding.*' => 'integer|in:0, 1',
            // 'concept' => 'required',
            // 'business_model' => 'required',
            // 'competitors' => 'required',
        ]);

        return response()->json(['message' => 'ok'], 200);
    }

    /**
     * Store StartUp
     * @param StoreStartUpRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreStartUpRequest $request)
    {
        $startUp = new StartUp($request->allowed());
        $startUp->finding = implode('_', $request->finding);
        $startUp->project_status = implode('_', $request->project_status);
        $startUp->author_id = Auth::guard()->id();

        DB::transaction(function() use ($startUp, $request)
        {
            $startUp->save();

            $categoriesArr = $this->unique_array($request->categories, 'id');
            $startUp->categories()->attach(array_pluck($categoriesArr, 'id'));

            $skillArr = $this->unique_array($request->skills, 'id');
            $startUp->skills()->attach(array_pluck($skillArr, 'id'));


            //Attach team members (id, role, desc) to the pivot table
            $tostore = [];
            

            if(is_array($request->team) && count($request->team) > 0) {
                $startUp->teams()->createMany($request->team);
            }
        });

        $startUp->load('teams');

        $startUp->load("author");

        event(new StartUpWasCreated($startUp));

        return response()->json($startUp, 201);
    }

    /**
     * Update StartUp request
     * @param UpdateStartUpRequest $request
     * @param string $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UpdateStartUpRequest $request, $id)
    {
        $startUp = StartUp::findOrFail($request->id);
        $startUp->fill($request->allowed());
        $startUp->finding = implode('_', $request->finding_ids);
        $startUp->project_status = implode('_', $request->project_status_ids);

        DB::transaction(function() use ($startUp, $request)
        {
            $startUp->save();
            $startUp->categories()->sync(array_pluck($request->categories, 'id'));

           $startUp->skills()->sync(array_pluck($request->skills, 'id'));
        });

        return response()->json($startUp);
    }

    /**
     * Retrieving StartUps
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $this->validate($request, [
            'user_id' => 'integer'
        ]);

        $startUp = StartUp::filter($request->all())
            ->latest()
            ->paginate();
        
        $startUp->load('categories');
        foreach ($startUp as $_startup) {
            $_startup->fonds_type = FondsType::where('id', $_startup->fonds_types_id)
                                        ->first();
        }

        return $startUp;
    }

    public function searchForInvestor(Request $request) 
    {
        $startUp = StartUp::byInvestor()
            ->latest()
            ->paginate();

       

        return $startUp;
    }

    /**
     * Fetch StartUps created by authenticated user
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function forUser()
    {
        return StartUp::where('startups.author_id', Auth::id())
            ->latest()
            ->get();
    }

    /**
     * Fetch StartUps by author_id
     * @param string $id
     * @return mixed
     */
    public function byUserId($id)
    {
        return StartUp::where('StartUps.author_id', $id)
            ->with('author')
            ->withProposalsCount()
            ->latest()
            ->get();
    }

    /**
     * Fetch StartUp by slug
     * @param string $slug
     * @return StartUp
     */
    public function bySlug($slug)
    {
        $startUp = StartUp::where('startups.slug', $slug)
            ->firstOrFail();

        $startUp = $this->preprocessStartUp($startUp);

        return $startUp;
    }

    /**
     * Show single StartUp
     * @param string $id
     * @return StartUp
     */
    public function show($id)
    {
        $startUp = StartUp::withProposalSentFlag()
            ->where('startups.id', $id)
            ->firstOrFail();

        $startUp = $this->preprocessStartUp($startUp);

        return $startUp;
    }
    
     /**
     * Get projects which user with given id has applied to
     * @return \Illuminate\Http\JsonResponse
     */
    public function applied()
    {
        return StartUp::appliedBy(Auth::guard()->id())
            ->latest()
            ->get();
    }

    public function checkInvitation(InvitationRequest $request) {
        $user = User::where('email', $request->email)->first();

        return response()->json($user, 200);
    }

    /**
     * Store new document
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadDocument(Request $request)
    {
        $this->validate($request, [
            'logo' => 'required|file|mimes:jpeg,bmp,png,jpg'
        ]);

        $filename = str_random(10) . '.' . $request->file('logo')->getClientOriginalExtension();
        $request->file('logo')->move(public_path('storage/startups/logos'), $filename);

        return response()->json(['logo' => $filename], 201);
   }

   public function uploadMessageDocument(Request $request) {
        $this->validate($request, [
            'attachment' => 'required|file|mimes:jpeg,bmp,png,jpg,doc,docx,ppt,pptx,pdf,xls,csv,txt,xlsx'
        ]);

        $filename = str_random(10) . '.' . $request->file('attachment')->getClientOriginalExtension();
        $request->file('attachment')->move(public_path('storage/startup_message_documents'), $filename);

        return response()->json(['filename' => $filename], 201);
   }

    /**
     * Preprocess StartUp for single get request
     * @param StartUp $StartUp
     * @return StartUp
     */
    private function preprocessStartUp(StartUp $startUp)
    {
        $startUp->incrementViews();

        $startUp->load('skills');
        $startUp->load('categories');
        $startUp->load('contacts.author');
        $startUp->load('teams.info');

        $startUp->author = User::where('id', $startUp->author_id)
                                ->withStartupsCount($startUp->author_id)
                               ->firstOrFail();
                               
        $startUp->author->load('city.country');
        
        $startUp->fonds_type = FondsType::where('id', $startUp->fonds_types_id)
                                        ->first();

        $findingNames = $this->getFindingNames();
        $findingIds = explode('_', $startUp->finding);
        $selectedFindingNames = [];
        foreach ($findingIds as $id) {
            array_push($selectedFindingNames, $findingNames[intval($id)]);
        }

        $startUp->finding_ids = $findingIds;

        $startUp->findingNames = implode(', ', $selectedFindingNames);
        $all_selected_p_status = explode('_', $startUp->project_status);

        $startUp->selected_p_status = $this->convertSelectedStatus($all_selected_p_status);

        $startUp->project_status_ids = $all_selected_p_status;

        $startUp->num_contacts = $startUp->countContacts($startUp->id);

        return $startUp;
    }
    
    private function convertSelectedStatus($all_selected_p_status) 
    {
        $selected_p_status = [];
        
        for ($i = 0; $i < 5; $i++) {
            $belong = false;
            if (in_array(''.$i, $all_selected_p_status)) {
                $belong = true;
            }

            array_push($selected_p_status, $belong);
        }
        
        return $selected_p_status;
    }

    private function unique_array($array, $key) { 
        $temp_array = array(); 
        $added_items = array(); 
        
        foreach($array as $val) { 
            if (!in_array($val[$key], $added_items)) { 
                array_push( $temp_array, $val);
                array_push($added_items, $val[$key]);
            } 
        } 

        return $temp_array; 
    }

    private function getFindingNames() {
        return [
            0 => 'One or more associates',
            1 => 'A investisseur'
        ];
    }
}