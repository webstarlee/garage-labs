<?php

namespace App\Http\Requests\Api;

use Auth;
use App\User;
use App\Project;
use App\Feedback;
use App\Http\Requests\Request;

class StoreFeedbackRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'receiver_id',
        'project_id',
        'message',
        'rating'
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

        $project = Project::findOrFail($this->project_id);

        if($project->author_id !== Auth::guard()->id()) {
            return false;
        }

        if(! $project->acceptedWorkers()->where((new User)->getTable() . '.id', $this->receiver_id)->exists()) {
            return false;
        }

        if(Feedback::where('receiver_id', $this->receiver_id)->where('project_id', $this->project_id)->exists()) {
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
            'receiver_id' => 'required|integer|exists:users,id',
            'project_id' => 'required|integer|exists:projects,id,author_id,' . Auth::guard()->id(),
            'message' => 'required|min:3|max:500',
            'rating' => 'required|integer|min:0|max:5',
        ];
    }
}
