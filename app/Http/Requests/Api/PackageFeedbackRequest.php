<?php

namespace App\Http\Requests\Api;

use Auth;
use App\User;
use App\Package;
use App\PackageFeedback;
use App\Http\Requests\Request;

class PackageFeedbackRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'seller_id',
        'buyer_id',
        'package_id',
        'message',
        'rating',
        'ordered_package_id'
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

        // if($this->buyer_id !== Auth::guard()->id()) {
        //     return false;
        // }

        if(PackageFeedback::where('buyer_id', $package->buyer_id)->where('ordered_package_id', $this->ordered_package_id)->exists()) {
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
            'buyer_id' => 'required|integer|exists:users,id',
            'package_id' => 'required|integer',
            'message' => 'min:1|max:500',
            'rating' => 'required|integer|min:0|max:5',
        ];
    }
}
