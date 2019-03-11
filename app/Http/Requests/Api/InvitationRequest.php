<?php

namespace App\Http\Requests\Api;

use App\Http\Requests\Request;
use Auth;

class InvitationRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'role',
        'email',
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
            'role' => 'required',
            'email' => 'required|email',
            'description' => 'required'
        ];
    }
}
