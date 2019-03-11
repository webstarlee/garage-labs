<?php

namespace App\Http\Controllers\Api;


use App\FondsType;

class FondsController extends Controller
{
   
    /**
     * Fetch Fonds types
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function index()
    {
        return FondsType::all();
    }

    public function fondsById($id){
    	return FondsType::where('id', $id)->firstOrFail();
    }
}
