<?php

namespace App;

use File;
use Illuminate\Http\UploadedFile;

class Reference extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id',
        'title',
        'description',
        'url'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'user_id' => 'integer'
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'image_url'
    ];

    /**
     * Default image url
     * @var string
     */
    protected $defaultImageUrl = 'vendor/shots_img/1450746217_1_ggxrn_website-example-test.jpg';

    /**
     * Documents many to many morph relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function documents()
    {
        return $this->morphToMany(Document::class, 'documenttable');
    }

    /**
     * Getter for image_url attribute
     * @return string
     */
    public function getImageUrlAttribute()
    {
        return $this->image ? url("storage/$this->image") : url($this->defaultImageUrl);
    }

    /**
     * Save image
     * @param UploadedFile $file
     */
    public function saveImage(UploadedFile $file)
    {
        if($this->image) {
            File::delete(public_path("storage/$this->image"));
        }

        $filename = str_random(10) . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('storage'), $filename);

        $this->image = $filename;
    }
}