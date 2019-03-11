<?php

namespace App\Http\Controllers\Api;

use App\City;
use App\Country;

class CountryController extends Controller
{
    /**
     * Fetch all countries
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function index()
    {
        return Country::all();
    }

    /**
     * Fetch cities by countryId GET param
     * @param int $countryId
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function cities($countryId)
    {
        return City::where('country_id', $countryId)->get();
    }
}