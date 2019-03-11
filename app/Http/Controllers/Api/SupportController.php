<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Events\SupportWasSent;
use App\Http\Requests\Api\SupportRequest;
use Auth;
use App\CustomerSupport;
use App\Fundraising;

class SupportController extends Controller
{
    /**
     * ProjectController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only([
            'submit',
            'submitFundraising'
        ]);
    }

    public function submit(SupportRequest $request) {
        $reasonList = array(
            "My delivery is late and the supplier is not replying",
            "I'm not satisfied with a delivery",
            "I have a general question",
            "I have a technical problem or noticed a bug"
        );

        $customerSupport = new CustomerSupport($request->allowed());
        $customerSupport->reason = $reasonList[$request->reason];
        $customerSupport->author_id = Auth::guard()->id();
        $customerSupport->save();
        $customerSupport->load('author');
        
        event(new SupportWasSent($customerSupport));

        return response()->json(['status' => "ok"], 201);
    }

    public function submitFundraising(Request $request) {
        $this->validate($request, [
            'title' => 'required',
            'firstname' => 'required',
            'name' => 'required',
            'email' => 'required|email',
            'mobile' => 'required'
        ]);

        $fund = new Fundraising($request->all());
        $fund->author_id = Auth::guard()->id();
        $fund->save();
        
        return response()->json(['status' => "ok"], 201);
    }
}