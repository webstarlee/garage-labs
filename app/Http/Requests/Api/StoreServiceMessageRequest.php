<?php

namespace App\Http\Requests\Api;

use App\PackageOrder;
use Auth;
use App\Http\Requests\Request;

class StoreServiceMessageRequest extends Request
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed = [
        'ordered_package_id',
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
        return Auth::check() AND PackageOrder::where('id', $this->ordered_package_id)->byRelatedUsers(Auth::id())->exists();
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
            'ordered_package_id' => 'required|integer|exists:package_orders,id',
            'text' => 'required'
        ];
    }
}
