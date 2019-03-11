<?php

namespace App\Http\Requests\Api;

use Auth;
use App\Http\Requests\Request;

class StoreStartUpRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'title',
        'finding',
        'concept',
        'business_model',
        'competitors',
        'project_status',
        'looking_partners',
        'website',
        'concept_video',
        'author_id',
        'fonds_types_id',
        'views',
        'slug',
        'montant_recherche',
        'parts_sociales_cedees',
        'valorisation_societe',
        'montant_leve',
        'montant_utilisation',
        'logo'
        ];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return Auth::check();
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
            'finding' => 'required|array|min:1',
            'finding.*' => 'integer|in:0, 1',
            'project_status' => 'required|array|min:1',
            'project_status.*' => 'integer|in:0, 1,2,3,4',
            'skills' => 'required|array|min:1',
            'skills.*.id' => 'required|integer|exists:skills,id',
            'website' => 'url',
            'concept_video' => 'url',
            'concept' => 'required',
            'business_model' => 'required',
            'competitors' => 'required',
             'montant_recherche'=> 'nullable|numeric',
            'parts_sociales_cedees'=> 'nullable|numeric',
            'valorisation_societe'=> 'nullable|numeric',
            'montant_leve'=> 'nullable|numeric',
            'montant_utilisation'=> 'nullable|string',
            'fonds_types_id' => 'nullable|integer',
        ];
    }
}
