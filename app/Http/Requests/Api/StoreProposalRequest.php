<?php

namespace App\Http\Requests\Api;

use Auth;
use App\Project;
use App\Proposal;
use App\Http\Requests\Request;

class StoreProposalRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'project_id',
        'offer',
        'message'
    ];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        if(! Auth::guard()->check()) {
            return false;
        }

        $project = Project::findOrFail($this->project_id);

        if($project->author_id === Auth::guard()->id()) {
            return false;
        }

        if($project->status === 'closed') {
            return false;
        }

        if(Proposal::where('project_id', $this->project_id)->where('author_id', Auth::guard()->id())->exists()) {
            return false;
        }

        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'project_id' => 'required|integer|exists:projects,id',
            'offer' => 'required|integer',
            'message' => 'required',
        ];
    }
}
