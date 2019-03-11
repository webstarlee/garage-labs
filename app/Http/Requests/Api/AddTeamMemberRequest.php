<?php

namespace App\Http\Requests\Api;

use App\Http\Requests\Request;

class AddTeamMemberRequest extends Request
{

    protected $allowed = [
        'startup_id',
        'user_id',
        'role',
        'description',
    ];
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
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
            //
        ];
    }
}
