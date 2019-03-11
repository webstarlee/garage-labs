<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class Proposal extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'project_id',
        'offer',
        'message',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'message'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'author_id' => 'integer',
        'project_id' => 'integer',
        'offer' => 'integer'
    ];

    /**
     * Accept proposal
     * @return void
     */
    public function accept()
    {
        $this->status = 'accepted';
    }

    /**
     * Accept proposal
     * @return void
     */
     public function approve()
     {
         $this->status = 'approved';
     }

    /**
     * Reject proposal
     * @return void
     */
    public function reject()
    {
        $this->status = 'rejected';
    }

    /**
     * Filter by project_id
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function project()
    {
        return $this->belongsTo(Project::class);
    }

    /**
     * Filter by project id
     * @param Builder $query
     * @param $id
     * @return Builder $query
     */
    public function scopeForProject(Builder $query, $id)
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
        return $this->hasOne(Conversation::class);
    }

    /**
     * Fetch by conversation relation
     * @param Builder $query
     * @param int $id
     * @return Builder
     */
    public function scopeByConversationId(Builder $query, $id)
    {
        return $query->whereHas('conversation', function(Builder $query) use ($id) {
            $query->where('conversations.id', $id);
        });
    }
}