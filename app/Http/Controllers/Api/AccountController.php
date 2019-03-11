<?php

namespace App\Http\Controllers\Api;

use Auth;
use App\Http\Requests;
use Illuminate\Contracts\Hashing\Hasher;
use Illuminate\Http\Request;
use App\Http\Requests\Api\UpdateUserRequest;
use App\Http\Requests\Api\CompanyInfoRequest;
use App\Http\Requests\Api\BankInfoRequest;
use App\UserCompany;
use App\UserBank;
use App\SkillUser;
use DB;

class AccountController extends Controller
{
    /**
     * Hasher implementation
     * @var Hasher
     */
    private $hasher;

    /**
     * AccountController constructor.
     * @param Hasher $hasher
     */
    public function __construct(Hasher $hasher)
    {
        $this->hasher = $hasher;

        $this->middleware('auth:api');
    }

    /**
     * Get account info
     * @return \Illuminate\Http\JsonResponse
     */
    public function get()
    {
        return Auth::guard()->user();
    }

    /**
     * Update account
     * @param UpdateUserRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UpdateUserRequest $request)
    {
        $user = Auth::guard()->user();

        $user->fill($request->allowed());
        $user->save();
        $user->makeVisible(['api_token']);

        return response()->json($user);
    }

    /**
     * Update user avatar
     * @param Request $request
     * @return \App\User
     */
    public function updateAvatar(Request $request)
    {
        $this->validate($request, [
            'file' => 'required|image'
        ]);

        $user = Auth::user();
        $user->deleteOldAvatar();
        $user->updateAvatar($request->file('file'));

        return $user;
    }

    /**
     * Update user cover
     * @param Request $request
     * @return \App\User|null
     */
    public function updateCover(Request $request)
    {
        $this->validate($request, [
            'file' => 'required|image'
        ]);

        $user = Auth::user();
        $user->deleteOldCover();
        $user->updateCover($request->file('file'));

        return $user;
    }

    /**
     * Update user password and return json with new api token
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updatePassword(Request $request)
    {
        $this->validate($request, [
            'old_password' => 'required',
            'new_password' => 'required|min:6'
        ]);

        $user = Auth::user();

        if(! $this->hasher->check($request->old_password, $user->getAuthPassword())) {
            return response()->json(['old_password' => ['Wrong password']], 422);
        }

        $user->password = $this->hasher->make($request->new_password);
        $user->refreshApiToken();
        $user->save();

        return response()->json(['message' => 'Your password has been updated', 'api_token' => $user->api_token]);
    }

    public function updateCompany(CompanyInfoRequest $request) 
    {
        $company = UserCompany::find($request->id);
        if ($company === null)
        {
            $company = new UserCompany($request->allowed());
            $company->user_id = Auth::guard()->id();
        }
        else 
        {
            $company->fill($request->allowed());
        }

        $company->save();

        return response()->json($company, 200);
    }

    public function getCompany() 
    {
        $company = UserCompany::where('user_id', Auth::guard()->id())->first();
        return response()->json($company, 200);
    }

    public function getBank() 
    {
        $company = UserBank::where('user_id', Auth::guard()->id())->first();
        return response()->json($company, 200);
    }

    public function updateBankInfo(BankInfoRequest $request) 
    {
        $bank = UserBank::find($request->id);
        if ($bank === null)
        {
            $bank = new UserBank($request->allowed());
            $bank->user_id = Auth::guard()->id();
        }
        else 
        {
            $bank->fill($request->allowed());
        }

        $bank->save();

        return response()->json($bank, 200);
    }

    public function updateIAm(Request $request) {
        $this->validate($request, [
            'iam' => 'required|array|min:1',
            'iam.*' => 'integer|in:0, 1, 2'
        ]);

        $user = Auth::user();

        $displayingIAms = $this->getDisplayingIAm();
        $displayIAmStr = '';

        foreach($request->iam as $id) {
            if ($displayIAmStr == '') {
                $displayIAmStr = $displayingIAms[$id];
            } else {
                $displayIAmStr = $displayIAmStr.'|'.$displayingIAms[$id];
            }
        }

        $i_am_str = implode('_', $request->iam);

        if ($user !== null) {
            $user->i_am = $i_am_str;
            $user->displaying_i_am = $displayIAmStr;
            $user->save();
            $user->displaying_i_am = $user->getDisplayingIam();
        }

        return response()->json(["i_am" => $user->i_am, "displaying_i_am" => $user->displaying_i_am], 200);
    }

    public function updateLinkedin(Request $request) {
        $this->validate($request, [
            'linkedin_url' => 'required|url'
        ]);

        $user = Auth::user();

        if ($user !== null) {
            $user->linkedin_url = $request->linkedin_url;
            $user->save();
        }

        return response()->json($user->linkedin_url, 200);
    }

    public function updatePresentation(Request $request) {
        $this->validate($request, [
            'presentation' => 'required'
        ]);

        $user = Auth::user();

        if ($user !== null) {
            $user->presentation = $request->presentation;
            $user->save();
        }

        return response()->json($user->presentation, 200);
    }

    
    public function updateSkills(Request $request) {
        $this->validate($request, [
            'skills' => 'required|array|min:1',
            'skills.*.id' => 'required|integer|exists:skills,id'
        ]);

        $user = Auth::user();

        DB::transaction(function() use ($user, $request)
        {
            $skillArr = $this->unique_array($request->skills, 'id');
            
             // Delete old
             SkillUser::where('user_id', $user->id)->delete();
             
            // Save skills
            $user->skills()->attach(array_pluck($skillArr, 'id'));
        });
       
        $user->load('skills');
        // $user->displaying_i_am = $user->getDisplayingIam();
        return response()->json($user->skills, 200);
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

    private function getDisplayingIAm() {
        return [
            '0' => "A provider",
            '1' => "A entrepreneur",
            '2' => "A investor"
        ];
    }
}
