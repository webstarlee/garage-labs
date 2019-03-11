<?php

namespace App\Http\Requests\Api;

use Auth;
use App\Http\Requests\Request;

class ServiceRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'title',
        'description',
        'category_id',
        'subcategory_id'
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
        $user = Auth::user();

        return [
            'title' => 'required|max:255',
            'description' => 'required',
            'category_id' => 'required|integer|exists:service_categories,id',
            'subcategory_id' => 'integer|exists:service_subcategories,id',
            'packages' => 'required|array|min:1',
            'packages.*.name' => 'required',
            'packages.*.description' => 'required',
            'packages.*.price' => 'required|integer',
            'packages.*.days_to_deliver' => 'required|integer',
            'packages.*.number_devisions' => 'required|integer',
            'packages.*.instruction' => 'required',
        ];
    }
}
