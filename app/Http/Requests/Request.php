<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

abstract class Request extends FormRequest
{
    /**
     * Keys for allowed array values
     * @var array
     */
    protected $allowed;

    /**
     * Retrieve only allowed params
     * @return array
     */
    public function allowed()
    {
        return array_only(parent::all(), $this->allowed);
    }
}