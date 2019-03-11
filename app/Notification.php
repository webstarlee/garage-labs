<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class Notification extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'receiver_id',
        'title',
        'message',
        'link',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'receiver_id' => 'integer',
        'is_read' => 'boolean'
    ];

    /**
     * Fetching unread notifications
     * @param Builder $query
     * @return Builder
     */
    public function scopeUnread(Builder $query)
    {
        return $query->where('is_read', false);
    }
}