<?php

namespace App\Http\Controllers\Api;

use Auth;
use App\Notification;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    /**
     * NotificationController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api');
    }

    /**
     * Fetch notifications
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        Notification::where('receiver_id', Auth::id())->update(['is_read' => true]);

        return Notification::where('receiver_id', Auth::id())
            ->latest()
            ->take(5)
            ->get();
    }

    /**
     * Mark all notifications read
     * @return \Illuminate\Http\JsonResponse
     */
    public function read()
    {
        Notification::where('receiver_id', Auth::guard()->id())->update(['is_read' => true]);

        return response()->json(['message' => 'ok']);
    }

    /**
     * Fetching count of unread notifications
     * @return \Illuminate\Http\JsonResponse
     */
    public function unread()
    {
        return response()->json(['notifications' => Notification::whereReceiverId(Auth::id())->unread()->count()]);
    }

    public function deleteNotification(Request $request) {
        $id = $request->id;
        
        Notification::where('receiver_id', Auth::id())->where('id', $id)->delete();

        if ($request->type == 'all') {
            return $this->getNotifications();
        }

        return $this->index();
    }

    public function getNotifications() {
        return Notification::where('receiver_id', Auth::id())
            ->latest()
            ->paginate();
    }
}