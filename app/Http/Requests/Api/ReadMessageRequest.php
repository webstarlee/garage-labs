<?php

namespace App\Http\Requests\Api;

use App\Message;
use Auth;
use Illuminate\Foundation\Http\FormRequest;

class ReadMessageRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        if(! Auth::guard()->check()) {
            return false;
        }

        $message = Message::findOrFail($this->route('id'));

        if($message->receiver_id === Auth::guard()->id()) {
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
            //
        ];
    }
}
