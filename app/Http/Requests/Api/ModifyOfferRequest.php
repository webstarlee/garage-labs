<?php

namespace App\Http\Requests\Api;

use App\Proposal;
use Auth;
use Illuminate\Foundation\Http\FormRequest;

class ModifyOfferRequest extends FormRequest
{
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

        $proposal = Proposal::findOrFail($this->route('id'));

        if($proposal->project->status === 'closed' || $proposal->status === 'accepted') {
            return false;
        }

        if(Auth::guard()->id() === $proposal->author_id) {
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
          "offer" => "required|integer|min:1"
        ];
    }
}
