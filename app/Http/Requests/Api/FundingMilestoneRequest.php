<?php

namespace App\Http\Requests\Api;

use App\Proposal;
use Auth;
use App\Http\Requests\Request;

class FundingMilestoneRequest extends Request
{
       /**
     * Keys for allowed array values
     * @var array
     */
     protected $allowed = [
        'proposal_id',
        'title',
        'description',
        'deadline',
        'id',
        'price'
    ];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        if(! Auth::check()) {
            return false;
        }

        $proposal = Proposal::findOrFail($this->route('id'));

        if($proposal->project->status !== 'closed' || $proposal->status !== 'accepted') {
            return false;
        }

        if(Auth::guard()->id() === $proposal->project->author_id) {
            return true;
        }

        return false;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "credit_card" => "required",
            "price" => "required|min:1",
            "fee" => "required|min:0",
            "expired" => array('required', 'regex:/([0-9]{4})\/(0[1-9]|1[012])$/'),
            "cvc" => "required|regex:/[0-9]+/",
            'attachements' => 'array',
            'deadline' => 'date',
            'title' => 'required',
            'description' => 'required'
        ];
    }
}
