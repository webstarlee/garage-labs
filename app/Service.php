<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class Service extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'title',
        'description',
        'price',
        'category_id',
        'subcategory_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'author_id' => 'integer',
        'category_id' => 'integer',
        'subcategory_id' => 'integer'
    ];

    /**
     * The "booting" method of the model.
     *
     * @return void
     */
    public static function boot()
    {
        parent::boot();

        static::creating(function(Service $service) {
            $service->generateSlug();
        });
    }

    /**
     * Generating slug
     * @return void
     */
    public function generateSlug()
    {
        $title = $this->slugify($this->title);
        $this->slug = $title . '-' . rand(100, 999);
    }

    /**
     * Slugify string
     * @param string $text
     * @return string
     */
    protected function slugify($text)
    {
        // replace non letter or digits by -
        $text = preg_replace('~[^\pL\d]+~u', '-', $text);
        // transliterate
        $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);
        // remove unwanted characters
        $text = preg_replace('~[^-\w]+~', '', $text);
        // trim
        $text = trim($text, '-');
        // remove duplicate -
        $text = preg_replace('~-+~', '-', $text);
        // lowercase
        $text = strtolower($text);

        return $text;
    }

    /**
     * Many to many relationship with Category entities
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function category()
    {
        return $this->belongsTo(ServiceCategory::class);
    }

    /**
     * Filtering projects
     * @param Builder $query
     * @param array $data
     * @return Builder
     */
    public function scopeFilter(Builder $query, array $data = [])
    {
        // if(array_get($data, 'categories') && is_array(array_get($data, 'categories'))) {
        //     $query->byCategoryIds($data['categories']);
        // }

        if(array_get($data, 'category_id')) {
            $query->byCategoryId($data['category_id']);
        }

        if(array_get($data, 'subcategory_id')) {
            $query->bySubCategoryId($data['subcategory_id']);
        }

        if(array_get($data, 'keyword')) {
            $query->byKeyword($data['keyword']);
        }

        return $query;
    }

    /**
     * Filter by category ids many to many relationship
     * @param Builder $query
     * @param array $ids
     * @return Builder
     */
    public function scopeByCategoryId(Builder $query, $id)
    {
        // return $query->whereIn('category_id', $ids);
        return $query->where('category_id', $id);
    }

    public function scopeBySubCategoryId(Builder $query, $id)
    {
        return $query->where('subcategory_id', $id);
    }

    /**
     * Author many to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }

    /**
     * Documents many to many  relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function galleries()
    {
        return $this->hasMany(Gallery::class, 'service_id');
    }

    /**
     * Documents many to many  relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function images()
    {
        return $this->hasMany(Gallery::class, 'service_id')->where('type', 'image');
    }

     /**
     * Documents many to many  relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function videos()
    {
        return $this->hasMany(Gallery::class, 'service_id')->where('type', 'video');
    }

      /**
     * Documents many to many  relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function packages()
    {
        return $this->hasMany(Package::class, 'service_id');
    }

    /**
     * Search by keyword
     * @param Builder $query
     * @param string $keyword
     * @return Builder
     */
    public function scopeByKeyword(Builder $query, $keyword)
    {
        return $query->where(function($query) use ($keyword) {
            $query->where('services.title', 'LIKE', "%$keyword%");
            $query->orWhere('services.description', 'LIKE', "%$keyword%");
        });
    }

    /**
     * With meta information
     * @param Builder $query
     * @return Builder
     */
    public function scopeWithMeta(Builder $query)
    {
        $query->addSelect([
            DB::raw('(select count(packages.id) from `packages` where  `packages`.service_id = `services`.id and `packages`.author_id='.Auth::id().') as number_packages')
        ]);

        return $query;
    }
}