<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;

class Gallery extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'service_id',
        'filename',
        'type'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'service_id' => 'integer'
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'url',
        'embed_url',
        'video_thumbnail'
    ];

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function service()
    {
        return $this->belongsTo(Service::class);
    }

    /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getUrlAttribute()
    {
        if ($this->type =='image' && $this->filename != null) {
            return url("storage/$this->filename");
        }
        
        return null;
    }

    /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getEmbedUrlAttribute()
    {
        if ($this->type =='video' && $this->filename != null) {
            $urls = explode("?v=", $this->filename);
            return "https://www.youtube.com/embed/".$urls[sizeof($urls) - 1];
        }
        
        return null;
    }

    /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getVideoThumbnailAttribute()
    {
        if ($this->type =='video' && $this->filename != null) {
            $urls = explode("?v=", $this->filename);
            return "https://img.youtube.com/vi/".$urls[sizeof($urls) - 1]."/0.jpg";
        }
        
        return null;
    }
}