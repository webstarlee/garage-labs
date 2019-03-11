<?php

namespace App\Http\Controllers\Api;

use Auth;
use App\Document;
use App\MilestoneDocument;
use Illuminate\Http\Request;

class DocumentController extends Controller
{
    /**
     * DocumentController constructor.
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only('store');
    }

    /**
     * Store new document
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'attachment' => 'required|file|mimes:jpeg,bmp,png,jpg,doc,docx,ppt,pptx,pdf,xls,csv,txt'
        ]);

        $filename = str_random(10) . '.' . $request->file('attachment')->getClientOriginalExtension();
        $request->file('attachment')->move(public_path('storage'), $filename);

        $document = Document::create([
            'author_id' => Auth::guard()->id(),
            'filename' => $filename
        ]);

        return response()->json($document, 201);
    }

    /**
     * Retrieve documents for project with given id
     * @param $id
     * @return mixed
     */
    public function forProject($id)
    {
        return Document::forProject($id)->get();
    }
}