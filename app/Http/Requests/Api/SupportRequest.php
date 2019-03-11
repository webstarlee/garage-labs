<?php

namespace App\Http\Requests\Api;

use Auth;
use App\Http\Requests\Request;

class SupportRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'reason',
        'order_id',
        'service_id',
        'comment',
        'type'
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
            'reason' => 'required|in:0, 1, 2, 3',
            'comment' => 'required',
            'service_id' => 'required|integer',
            'type' => 'required|in:package,milestone'
        ];
    }
}
