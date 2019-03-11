<?php

namespace App\Http\Requests\Api;

use App\Conversation;
use Auth;
use App\Http\Requests\Request;

class StoreMessageRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'conversation_id',
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
        return Auth::check() AND Conversation::where('id', $this->conversation_id)->withMemberById(Auth::id())->exists();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'receiver_id' => 'required|integer|exists:members,user_id,conversation_id,' . $this->conversation_id,
            'conversation_id' => 'required|integer|exists:conversations,id',
            'text' => 'required'
        ];
    }
}
