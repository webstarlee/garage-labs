<?php

namespace App\Http\Requests\Api;

use App\Package;
use Auth;
use App\Http\Requests\Request;

class OrderConfirmationRequest extends Request
{
       /**
     * Keys for allowed array values
     * @var array
     */
     protected $allowed = [
        'price',
        'credit_card',
        'expired',
        'cvc',
        'package_id'
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

        $package = Package::findOrFail($this->package_id);

        if(Auth::guard()->id() === $package->author_id) {
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
            "credit_card" => "required",
            "price" => "required|min:1",
            "expired" => array('required', 'regex:/([0-9]{4})\/(0[1-9]|1[012])$/'),
            "cvc" => "required|regex:/[0-9]+/"
        ];
    }
}
