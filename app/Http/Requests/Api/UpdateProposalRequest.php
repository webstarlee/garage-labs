<?php

namespace App\Http\Requests\Api;

use Auth;
use App\Http\Requests\Request;

class UpdateProposalRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = ['offer'];

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
            'offer' => 'required|integer|min:1'
        ];
    }
}
