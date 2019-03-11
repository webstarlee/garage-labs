<?php

namespace App\Http\Requests\Api;

use Auth;
use App\StartUp;
use App\Contact;
use App\Http\Requests\Request;

class StoreContactRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'start_up_id',
        'message'
    ];

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        if(!Auth::guard()->check()) {
            return false;
        }

        $startUp = StartUp::findOrFail($this->start_up_id);

        if($startUp->author_id === Auth::guard()->id()) {
            return false;
        }

        // if(Contact::where('start_up_id', $this->start_up_id)->where('author_id', Auth::guard()->id())->exists()) {
        //     return false;
        // }

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
            'start_up_id' => 'required|integer|exists:startups,id',
            'message' => 'required',
        ];
    }
}
