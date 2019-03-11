<?php

namespace App\Http\Requests\Api;

use App\Milestone;
use App\Proposal;
use Auth;
use App\Http\Requests\Request;

class RevisionRequest extends Request
{
       /**
     * Keys for allowed array values
     * @var array
     */
     protected $allowed = [
        'milestone_id',
        'description'
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

        $milestone = Milestone::findOrFail($this->milestone_id);
        $milestone->load('proposal');

        if($milestone->proposal->status !== 'accepted' || $milestone->status !== 'submitted') {
            return false;
        }

        if(Auth::guard()->id() === $milestone->author_id) {
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
            'milestone_id' => 'required',
            'description' => 'required'
        ];
    }
}
