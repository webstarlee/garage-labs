<?php

namespace App\Http\Controllers\Api;

use App\Feedback;
use App\User;

use App\Http\Requests\Api\StoreFeedbackRequest;
use App\Http\Requests\Api\ProjectFeedbackRequest;

use Auth;

class FeedbackController extends Controller
{
    /**
     * FeedbackController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only('store, storeProjectFeedback');
    }

    /**
     * Store feedback
     * @param StoreFeedbackRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreFeedbackRequest $request)
    {
        $feedback = new Feedback($request->allowed());
        $feedback->author_id = Auth::id();
        $feedback->save();

        return response()->json($feedback, 201);
    }

    /**
     * Fetch feedbacks by user id
     * @param string $id
     * @return mixed
     */
    public function byUserId($id)
    {
        $feedbacks = Feedback::where('receiver_id', $id)
            ->with('project', 'author')
            ->latest()
            ->get();

        return response()->json([
            'meta' => [
                'count' => $feedbacks->count(),
                'average_rating' => round(Feedback::where('receiver_id', $id)->avg('rating') / 5 * 100, 2)
            ],
            'feedbacks' => $feedbacks
        ]);
    }

    public function storeProjectFeedback(ProjectFeedbackRequest $request) {
        $author = User::findOrFail($request->receiver_id);
        $author->update_rating($request->rating);
        $author->save();

        $feedback = new Feedback($request->allowed());
        $feedback->author_id = Auth::id();
        $feedback->save();

        return response()->json($feedback, 201);
    }
}