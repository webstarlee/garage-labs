<?php

namespace App\Http\Requests\Api;

use App\Http\Requests\Request;
use App\Project;
use Auth;

class UpdateProjectRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'type',
        'title',
        'description',
        'categories',
        'payment_method',
        'budget',
        'starts_at',
        'ends_at',
        'place',
        'show_email',
        'show_phone',
        'contact_phone',
        'contact_email',
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

        $project = Project::findOrFail($this->route('id'));

        if($project->author_id === Auth::id()) {
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
            'type' => 'in:project,mission',
            'tags.*.id' => 'required|integer|exists:tags,id',
            'categories' => 'required|array|min:1',
            'categories.*.id' => 'required|integer|exists:categories,id',
            'attachements' => 'array',
            'attachments.*.id' => 'required|integer|exists:documents,id',
            'title' => 'required',
            'description' => 'required',
            'payment_method' => 'in:by day,flat price',
            'budget' => 'required|integer',
            'starts_at' => 'required|date',
            'ends_at' => 'date',
            'contact_phone' => 'required_if:show_phone,1,true',
            'contact_email' => 'required_if:show_email,1,true',
        ];
    }
}
