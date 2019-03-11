<?php

namespace App\Http\Requests\Api;

use App\Contact;
use Auth;
use App\Http\Requests\Request;

class StoreStartupMessageRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'contact_id',
        'receiver_id',
        'text'
    ];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return Auth::check() AND Contact::where('id', $this->contact_id)->byRelatedUsers(Auth::id())->exists();
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
            'contact_id' => 'required|integer|exists:contacts,id',
            'text' => 'required'
        ];
    }
}
