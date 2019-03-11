<?php

namespace App\Http\Controllers\Api;

use App\Tag;
use Illuminate\Http\Request;

class TagController extends Controller
{
    /**
     * Store resource
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|unique:tags,name'
        ]);

        $tag = Tag::create($request->all());

        return response()->json($tag, 201);
    }

    /**
     * Search tags by keyword
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request)
    {
        if(is_null($request->keyword) OR (is_string($request->keyword) AND strlen($request->keyword) < 3)) {
            return response()->json(['message' => 'Keyword should be at least 3 letters length'], 422);
        }

        return response()->json(Tag::where('name', 'like', "%$request->keyword%")->get());
    }
}