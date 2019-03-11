<?php

namespace App\Http\Requests\Api;

use Auth;
use App\Http\Requests\Request;

class UpdateUserRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'first_name',
        'last_name',
        'username',
        'email',
        'phone',
        'company_name',
        'company_phone',
        'address',
        'postal_code',
        'country_id',
        'city_id',
        'cover_path',
        'avatar_path',
        'website'
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
            'first_name' => 'required',
            'last_name' => 'required',
            'username' => 'required|unique:users,username,' . $user->id,
            'email' => 'required|email|unique:users,email,' .$user->id,
            'country_id' => 'required|integer|exists:countries,id',
            'city_id' => 'required|integer|exists:cities,id,country_id,' . $this->country_id
        ];
    }
}
