<?php

namespace App\Http\Requests\Api;

use App\PackageOrder;
use App\Proposal;
use Auth;
use App\Http\Requests\Request;

class PackageDeliveryRequest extends Request
{
       /**
     * Keys for allowed array values
     * @var array
     */
     protected $allowed = [
        'ordered_package_id',
        'description',
        'filename'
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

        $packageOrder = PackageOrder::findOrFail($this->ordered_package_id);

        if($packageOrder->status !== 'new' || Auth::guard()->id() !== $packageOrder->seller_id) {
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
            'attachements' => 'array',
            'description' => 'required'
        ];
    }
}
