<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Query\JoinClause;

class Conversation extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'project_id',
        'proposal_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'project_id' => 'integer',
        'proposal_id' => 'integer'
    ];

    /**
     * Members one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function members()
    {
        return $this->belongsToMany(User::class, 'members');
    }

    /**
     * Many to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function proposal()
    {
        return $this->belongsTo(Proposal::class);
    }

    /**
     * Many to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function project()
    {
        return $this->belongsTo(Project::class);
    }

    /**
     * Generate members child table records
     * @param array $ids
     * @return null
     */
    public function generateMembers($ids)
    {
        $ids = is_array($ids) ? $ids : func_get_args();

        $this->members()->sync($ids);
    }

    /**
     * Fetch conversations for user
     * @param Builder $query
     * @param int $id
     * @return Builder
     */
    public function scopeWithMemberById(Builder $query, $id)
    {
        return $query->whereHas('members', function(Builder $query) use ($id) {
            $query->where('users.id', $id);
        });
    }

    /**
     * Join last message
     * @param Builder $query
     * @return Builder
     */
    public function scopeWithLastMessage(Builder $query)
    {
        $query->addSelect(
            'users.id as user_id',
            'users.username as user_username',
            'users.avatar_path as user_avatar_path',
            'messages.text',
            'messages.created_at as created_at',
            'messages.updated_at as updated_at',
            'messages.read',
            'projects.title as project_title',
            'projects.budget as project_budget',
            DB::raw('(messages.receiver_id = ' . Auth::id() . ') as incoming'),
            DB::raw('(messages.read = 1' . ') as status')
        );

        $query->join('projects', 'projects.id', '=', 'conversations.project_id');
        $query->join('messages','messages.id', '=', DB::raw("(SELECT max(messages.id) from messages where messages.conversation_id = conversations.id)"));
        $query->join('members', function(JoinClause $join) {
            $join->on('members.conversation_id', '=', 'conversations.id');
            $join->where('members.user_id', '!=', Auth::id());
        });
        $query->join('users', 'users.id', '=', 'members.user_id');
        $query->orderBy('messages.created_at', 'desc');

        return $query;
    }

    /**
     * Filter conversation with members with ids
     * @param Builder $query
     * @param array $ids
     * @return Builder
     */
    public function scopeHasMembers(Builder $query, array $ids)
    {
        foreach($ids as $id) {
            $query->whereHas('members', function($query) use ($id) {
                $query->where('members.user_id', $id);
            });
        }

        return $query;
    }
}
