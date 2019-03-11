<?php

namespace App\Http\Requests\Api;

use App\Http\Requests\Request;
use App\StartUp;
use Auth;

class UpdateStartUpRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
       'title',
        'finding_ids',
        'concept',
        'business_model',
        'competitors',
        'project_status_ids',
        'looking_partners',
        'website',
        'concept_video',
        'views',
        'slug',
        'id'
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

        $startup = StartUp::findOrFail($this->id);

        if($startup->author_id === Auth::id()) {
            return true;
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
            'title' => 'required',
            'categories' => 'required|array|min:1',
            'categories.*.id' => 'required|integer|exists:scategories,id',
            'finding_ids' => 'required|array|min:1',
            'finding_ids.*' => 'integer|in:0, 1',
            'project_status_ids' => 'required|array|min:1',
            'project_status_ids.*' => 'integer|in:0, 1,2,3,4',
            'skills' => 'required|array|min:1',
            'skills.*.id' => 'required|integer|exists:skills,id',
            'website' => 'url',
            'concept_video' => 'url',
            'concept' => 'required',
            'business_model' => 'required',
            'competitors' => 'required',
        ];
    }
}
