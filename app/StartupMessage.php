<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class StartupMessage extends Model
{
    protected $table = "startup_messages";

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'contact_id',
        'text',
        'status',
        'sender_id',
        'receiver_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'contact_id' => 'integer',
        'status' => 'boolean',
        'sender_id',
        'receiver_id'
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'incoming'
    ];

    /**
     * Accessor for appended attribute incoming
     * @return bool
     */
    public function getIncomingAttribute()
    {
        return $this->receiver_id === Auth::guard()->id();
    }

    /**
     * Retrieve messages with user with given id
     * @param Builder $query
     * @return Builder
     */
    public function scopeConversation(Builder $query)
    {
        $query->addSelect([
            'sender.username as sender_username',
            'sender.avatar_path as sender_avatar_path'
        ]);

        $query->join(DB::raw('users as sender'), 'sender.id', '=', 'sender_id');

        return $query;
    }

    /**
     * Fetching messages by user id
     * @param Builder $query
     * @param $id
     * @return $this
     */
    public function scopeForUser(Builder $query, $id)
    {
        return $query->where(function($query) use ($id) {
            $query->where('messages.receiver_id', $id);
            $query->orWhere('messages.sender_id', $id);
        });
    }

    /**
     * Fetching messages for receiver with given id
     * @param Builder $query
     * @param $id
     * @return $this
     */
    public function scopeForReceiver(Builder $query, $id)
    {
        return $query->where('messages.receiver_id', $id);
    }

    /**
     * Fetch only unread messages
     * @param Builder $query
     * @return $this
     */
    public function scopeUnread(Builder $query)
    {
        return $query->where('messages.status', false);
    }

    /**
     * Accessor for avatar attribute
     * @param $value
     * @return \Illuminate\Contracts\Routing\UrlGenerator|null|string
     */
    public function getSenderAvatarPathAttribute($value)
    {
        return parent::getAvatarPathAttribute($value);
    }

    /**
     * Accessor for avatar attribute
     * @param $value
     * @return \Illuminate\Contracts\Routing\UrlGenerator|null|string
     */
    public function getReceiverAvatarPathAttribute($value)
    {
        return parent::getAvatarPathAttribute($value);
    }

    /**
     * Many to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function sender()
    {
        return $this->belongsTo(User::class, 'sender_id');
    }

    /**
     * Many to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function receiver()
    {
        return $this->belongsTo(User::class, 'receiver_id');
    }

    public function contact() {
        return $this->belongsTo(Contact::class, 'contact_id');
    }

    /**
     * Documents many to many morph relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function documents()
    {
        return $this->hasMany(StartupMessageDocument::class, 'startup_message_id');
    }
}