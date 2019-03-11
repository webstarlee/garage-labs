<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use App\User;
use App\OtherSkill;

use Illuminate\Http\Request;
use App\Http\Requests\Api\RegisterRequest;

class AuthController extends Controller
{
    /**
     * Login request handle
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request)
    {
        $this->validate($request, [
            'email' => 'required',
            'password' => 'required'
        ]);

        if(! Auth::guard('web')->attempt($this->getCredentials($request))) {
            return response()->json(['message' => 'Wrong credentials'], 422);
        }

        $user = User::withStats(Auth::guard('web')->id())
            ->where('users.id', Auth::guard('web')->id())
            ->first();

        $user->makeVisible(['api_token']);

        return response()->json($user);
    }

    /**
     * Register request
     * @param RegisterRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(RegisterRequest $request)
    {
        if ($request->completed == 'false') {
            return response()->json(['completed' => true]);
        }

        $this->validate($request, [
            'i_am' => 'required|array|min:1',
            'i_am.*' => 'integer|in:0, 1, 2',
            'skills' => 'required|array|min:1',
            'skills.*.id' => 'required|integer|exists:skills,id',
            'linkedin_url'=> 'url',
            'country_id' => 'required|integer|exists:countries,id',
            'city_id' => 'required|integer|exists:cities,id'
        ]);

        $displayingIAms = $this->getDisplayingIAm();
        $displayIAmStr = '';

        foreach($request->i_am as $id) {
            if ($displayIAmStr == '') {
                $displayIAmStr = $displayingIAms[$id];
            } else {
                $displayIAmStr = $displayIAmStr.'|'.$displayingIAms[$id];
            }
        }

        $i_am_str = implode('_', $request->i_am);

        $user = new User($request->all());
        $user->i_am = $i_am_str;
        $user->displaying_i_am = $displayIAmStr;

        $user->password = bcrypt($request->password);

          DB::transaction(function() use ($user, $request)
        {
            $user->save();
            $user = User::find($user->id);
            $user->makeVisible(['api_token']);

            $skillArr = $this->unique_array($request->skills, 'id');

            // Save skills
            $user->skills()->attach(array_pluck($skillArr, 'id'));
            $otherSkills = [];

            foreach($request->skills as $skill) {
                if ($skill['id'] == 0 && $skill['other'] != '') {
                    array_push($otherSkills, new OtherSkill([
                        'user_id' =>  $user->id,
                        'skill' => $skill['other']
                    ]));
                }
            }
            
            if (count($otherSkills) > 0) {
                $user->other_skills()->saveMany($otherSkills);
            }
        });

        return response()->json($user);
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

    /**
     * Retrieve credentials from request
     * @param Request $request
     * @return array
     */
    private function getCredentials(Request $request)
    {
        $credentials = ['password' => $request->password];

        if(filter_var($request->email, FILTER_VALIDATE_EMAIL)) {
            $credentials['email'] = $request->email;
        } else {
            $credentials['username'] = $request->email;
        }

        return $credentials;
    }

    private function getDisplayingIAm() {
        return [
            '0' => "A provider",
            '1' => "A entrepreneur",
            '2' => "A investisseur"
        ];
    }
}