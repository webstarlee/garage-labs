<?php

namespace App;

class Feedback extends Model
{
    protected $table = 'feedbacks';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'receiver_id',
        'project_id',
        'message',
        'rating',
        'communication',
        'skill',
        'deadline',
        'experience'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'receiver_id' => 'integer',
        'project_id' => 'integer',
        'rating' => 'integer',
        'communication' => 'integer',
        'skill' => 'integer',
        'deadline' => 'integer',
        'experience' => 'integer'
    ];

    /**
     * Author many to one
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }

    /**
     * Project many to one
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function project()
    {
       return $this->belongsTo(Project::class);
    }
}