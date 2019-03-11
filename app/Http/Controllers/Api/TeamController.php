<?php

namespace App\Http\Controllers\Api;

use DB;
use Illuminate\Http\Request;
use App\User;
use App\StartUp;
use App\StartupMember;
use App\Http\Requests\Api\InvitationRequest;
use Auth;
use App\Events\StartUpWasCreated;
use App\Events\JoinTeam;
use Carbon\Carbon;

class TeamController extends Controller
{
	/**
     * Validate StartUp first stage
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function addTeamMember(InvitationRequest $request)
    {
        $startup = StartUp::findOrFail($request->startup_id);
        $member = User::where('email', '=', $request->email)->first();
        $addingMem = $request->all();
        if ($member != null) {
            $addingMem["user_id"] = $member->id;
            $addingMem["avatar_path"] = $member->avatar_path;
            $addingMem["name"] = $member->first_name.' '.$member->last_name; 
        }

        $newMember = $startup->teams()->create($addingMem);

        // $author = User::findOrFail($startup->author_id);
        $startup->teams = [$newMember];
        $startup->load("author");

        event(new StartUpWasCreated($startup));
        return response()->json($newMember, 200);
    }

    public function editTeamMember(Request $request)
    {
        if ($request->role === null || $request->role === '' || 
        $request->description === null || $request->description === '') {
            return response()->json(["message"=>"Invalid description or role information."], 400);
        }

        $startup = StartUp::findOrFail($request->start_up_id);

        if ($startup->author_id !== Auth::guard()->id()) {
            return response()->json(["message"=>"You are not the author of this startup."], 400);
        }

        $startup->teams()->where('user_id', '=', $request->user_id)->update(['role' => $request->role, 'description' => $request->description]);

        return response()->json(["message"=>"OK"],200);
    }

    public function deleteMember(Request $request)
    {
        $startup = StartUp::findOrFail($request->start_up_id);
        $startup->load('author');

        if ($request->email === $startup->author->email) {
            return response()->json(["message"=>"You cannot delete yourself."], 400);
        }

        $startup->teams()->where('email', '=', $request->email)->delete();
        return response()->json(["message"=>$request->email],200);
    }

    public function joinTeam(Request $request) {
        $startup = StartUp::findOrFail($request->start_up_id);
        $currentUser = User::findOrFail(Auth::id());
        $member = $startup->teams()->where('email', '=',  $currentUser->email)->where('link', '=',  $request->token)->firstOrFail();
        if ($member != null && $member->active === 0) {
            $member->link = null;
            $member->active = 1;
            $member->user_id = $currentUser->id;
            $member->name = $currentUser->first_name.' '.$currentUser->last_name;
            $member->avatar_path = $currentUser->avatar_path;
            $member->joined_at = Carbon::now();

            $member->save();

            $startup->joiningMember = $member;
            // Notify to owner
            event(new JoinTeam($startup));
        }
        return response()->json(["member"=> $member],200);
    }
}
