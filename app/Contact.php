<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class Contact extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'start_up_id',
        'message',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'author_id' => 'integer',
        'start_up_id' => 'integer'
    ];

    /**
     * Filter by project_id
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function startup()
    {
        return $this->belongsTo(StartUp::class, 'start_up_id');
    }

    /**
     * Filter by project id
     * @param Builder $query
     * @param $id
     * @return Builder $query
     */
    public function scopeForStartUp(Builder $query, $id)
    {
        return $query->where($this->getTable(). '.id', $id);
    }

    /**
     * Many to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function author()
    {
        return $this->belongsTo(User::class, 'author_id')->withAverageRating();
    }

     /**
     * One to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
     public function conversation()
     {
         return $this->hasMany(StartupMessage::class);
     }
     
    /**
    * Fetch by conversation relation
    * @param Builder $query
    * @param int $id
    * @return Builder
    */
    public function scopeByContactId(Builder $query, $id, $userId)
    {
        return $query->whereHas('conversation', function(Builder $query) use ($id) {
            $query->where('conversations.contact_id', $id);
        });
    }

    /**
    * Fetch by conversation relation
    * @param Builder $query
    * @param int $id
    * @return Builder
    */
    public function scopeByContactIdAndRelatedUsers(Builder $query, $id, $userId)
    {
        return $query->where(function($query) use ($id, $userId) {
            $query->where('id', $id);
            $query->where('author_id', $userId);

            $query->orWhereHas('startup', function($query) use ($userId) {
                $query->where('startups.author_id', $userId);
            });
        });
    }

    
    /**
    * Fetch by conversation relation
    * @param Builder $query
    * @param int $id
    * @return Builder
    */
    public function scopeByRelatedUsers(Builder $query, $userId)
    {
        return $query->where(function($query) use ($userId) {
            $query->where('author_id', $userId);

            $query->orWhereHas('startup', function($query) use ($userId) {
                $query->where('startups.author_id', $userId);
            });
        });
    }
}