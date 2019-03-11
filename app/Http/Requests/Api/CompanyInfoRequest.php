<?php

namespace App\Http\Requests\Api;

use Auth;
use App\Http\Requests\Request;

class CompanyInfoRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'name',
        'country_id',
        'incorporation_number',
        'vat_number'
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
            'name' => 'required',
            'country_id' => 'required|integer|exists:countries,id',
            'incorporation_number' => 'required',
            'vat_number' => 'required'
        ];
    }
}
