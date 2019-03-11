<?php

namespace App\Http\Requests\Api;

use App\Proposal;
use Auth;
use App\Http\Requests\Request;

class SaveMilestoneRequest extends Request
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
        'price',
        'status'
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
            "price" => "required|min:0",
            "fee" => "required|min:0",
            'attachements' => 'array',
            'deadline' => 'date',
            'title' => 'required',
            'description' => 'required'
        ];
    }
}
