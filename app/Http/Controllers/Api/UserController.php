<?php

namespace App\Http\Controllers\Api;

use Auth;
use App\User;
use App\Conversation;
use App\Feedback;
use App\PackageFeedback;
use App\CreditCard;

use Illuminate\Http\Request;
use DB;

class UserController extends Controller
{
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $user = User::withMeta()
            ->where('users.id', $id)
            ->firstOrFail();

        $user->displaying_i_am = $user->getDisplayingIam('|');
        $user->full_name = $user->getFullnameAttribute();
        $user->load('startups');
        $user->load('projects');
        $user->load('portfolios');
        $user->load('skills');
        $user->projects->load('tags');


        if(Auth::check()
            && Auth::id() !== (int)$id
            && Conversation::with('project')->hasMembers([Auth::id(), $id])->exists()
        ) {
            $user->conversation_exists = true;
        }

        return $user;
    }

    /**
     * Calculate rating for user with given id
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function rating($id)
    {
        return User::where('users.id', $id)
            ->withAverageRating()
            ->firstOrFail();
    }

    public function getCofounders(Request $request) {
        return User::filter($request->all())
                    ->leftJoin('cities', 'users.city_id', '=', 'cities.id')
                    ->leftJoin('countries', 'users.country_id', '=', 'countries.id')
                    ->select(DB::raw('CONCAT(first_name, " ", last_name) AS title'), 'users.id', 'countries.name as country_name', 'cities.name as city_name')
                    ->distinct('users.id')
                    ->latest()
                    ->paginate();
    }

    public function byEmail($email) {
        $user =  User::where('email', $email)->firstOrFail();
        return response()->json($user, 201);
    }

    public function getFeedbacks($id) {
        $projectFeedbacks = Feedback::where('receiver_id', $id)->orderBy('id', 'desc')->get();
        $projectFeedbacks->load('author');
        $projectFeedbacks->load('project');

        $packageFeedbacks = PackageFeedback::where('seller_id', $id)->orderBy('id', 'desc')->get();
        $packageFeedbacks->load('author');
        $packageFeedbacks->load('package.service');

        return response()->json(['projectFeedbacks' => $projectFeedbacks, 'packageFeedbacks' => $packageFeedbacks], 201);
    }

    public function getUserRatting($id) {
        // $ratting = Feedback::where('receiver_id', $id)
        // ->select(array(DB::raw('AVG(rating) as ratings_average')
        //     ))
        // ->groupBy('receiver_id')
        // ->first();

        // return response()->json(['project' => $ratting], 201); 
    }

    public function getCreditCardsOfUser() {
        return CreditCard::where('author_id', Auth::id())->get();
    }
}