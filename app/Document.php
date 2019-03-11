<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class Document extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'author_id',
        'filename'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
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
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function projects()
    {
        return $this->morphedByMany(Project::class, 'documenttable');
    }

    /**
     * References moprh many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function references()
    {
        return $this->morphedByMany(Reference::class, 'documenttable');
    }

    /**
     * Filtering by reference id
     * @param Builder $query
     * @param $referenceId
     * @return Builder|static
     */
    public function scopeWhereReferenceId(Builder $query, $referenceId)
    {
        return $query->whereHas('references', function($query) use ($referenceId) {
            $query->where('references.id', $referenceId);
        });
    }

    /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getUrlAttribute()
    {
        return url("storage/$this->filename");
    }

    /**
     * For project with given id
     * @param Builder $query
     * @param $id
     * @return Builder|static
     */
    public function scopeForProject(Builder $query, $id)
    {
        return $query->whereHas('projects', function($query) use ($id) {
            $query->where('projects.id', $id);
        });
    }
}