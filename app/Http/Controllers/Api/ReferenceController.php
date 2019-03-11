<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use App\Document;
use App\Reference;
use Illuminate\Http\Request;
use App\Http\Requests\Api\DeleteReferenceRequest;

class ReferenceController extends Controller
{
    /**
     * ReferenceController constructor.
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only('store', 'update', 'delete');
    }

    /**
     * Fetch reference by id
     * @param string $id
     * @return mixed
     */
    public function show($id)
    {
        return Reference::where('id', $id)->with('documents')->firstOrFail();
    }

    /**
     * Storing reference
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'title' => 'required',
            'description' => 'required',
            'url' => 'url',
            'image' => 'required|image',
            'documents' => 'array',
            'documents.*.id' => 'integer|exists:documents,id'
        ]);

        $reference = new Reference($request->all());
        $reference->user_id = Auth::guard()->id();

        if($request->file('image')) {
            $reference->saveImage($request->file('image'));
        }

        DB::transaction(function() use ($reference, $request) {
            $reference->save();

            if($request->documents && count($request->documents, 'id') > 0) {
                $reference->documents()->attach(array_pluck($request->documents, 'id'));
            }
        });

        $reference->load('documents');

        return response()->json($reference, 201);
    }

    /**
     * Updating reference
     * @param $id
     * @param Request $request
     * @return mixed
     */
    public function update($id, Request $request)
    {
        $reference = Reference::findOrFail($id);

        if(Auth::guard()->id() !== $reference->user_id) {
            abort(403);
        }

        $this->validate($request, [
            'title' => 'required',
            'description' => 'required',
            'url' => 'url',
            'image' => 'image'
        ]);

        $reference->fill($request->all());

        if($request->file('image')) {
            $reference->saveImage($request->file('image'));
        }

        DB::transaction(function() use ($reference, $request) {
            $reference->save();
            $reference->documents()->sync(array_pluck($request->documents, 'id'));
        });

        $reference->load('documents');

        return $reference;
    }

    /**
     * Delete reference
     * @param DeleteReferenceRequest $request
     * @param string $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete(DeleteReferenceRequest $request, $id)
    {
        $reference = Reference::findOrFail($id);
        $reference->delete();

        return response()->json(['message' => 'Successfully deleted']);
    }

    /**
     * References by user id
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function byUserId($id)
    {
        return Reference::where('user_id', $id)->with('documents')->lastUpdated()->get();
    }

    /**
     * Get documents with specified reference id
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function documents($id)
    {
        return Document::whereReferenceId($id)->get();
    }
}