<?php

namespace App\Http\Requests\Api;

use App\Reference;
use Auth;
use Illuminate\Foundation\Http\FormRequest;

class DeleteReferenceRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return Auth::check() && Reference::where('user_id', Auth::id())->where('id', $this->route('id'))->exists();
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
