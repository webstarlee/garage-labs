<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class StartupMessageDocument extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'startup_message_id',
        'filename',
        'author_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'startup_message_id' => 'integer',
        'author_id' => 'integer'
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'url'
    ];

    /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getUrlAttribute()
    {
        return url("storage/startup_message_documents/$this->filename");
    }
}