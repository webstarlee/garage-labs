<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class Project extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'type',
        'status',
        'author_id',
        'title',
        'description',
        'payment_method',
        'starts_at',
        'budget',
        'ends_at',
        'place',
        'show_email',
        'show_phone',
        'contact_phone',
        'contact_email',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'applied' => 'boolean',
        'author_id' => 'integer',
        'show_email' => 'boolean',
        'show_phone' => 'boolean',
        'views' => 'integer'
    ];

    /**
     * The "booting" method of the model.
     *
     * @return void
     */
    public static function boot()
    {
        parent::boot();

        static::creating(function(Project $project) {
            $project->generateSlug();
        });
    }

    /**
     * Set status to closed
     * @return void
     */
    public function close()
    {
        $this->status = 'closed';
    }

    /**
     * Increment views
     * @param bool $save
     * @return void
     */
    public function incrementViews($save = true)
    {
        $this->views++;

        if($save === true) {
            $this->save();
        }
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
    public function categories()
    {
        return $this->belongsToMany(Category::class);
    }

    /**
     * Documents many to many morph relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function documents()
    {
        return $this->morphToMany(Document::class, 'documenttable');
    }

    /**
     * Proposals one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function proposals()
    {
        return $this->hasMany(Proposal::class);
    }

    /**
     * Users who work on this project
     * @return \Illuminate\Database\Eloquent\Relations\HasManyThrough
     */
    public function workers()
    {
        return $this->belongsToMany(User::class, (new Proposal)->getTable(), 'project_id', 'author_id');
    }

    /**
     * Get accepted workers
     * @return mixed
     */
    public function acceptedWorkers()
    {
        return $this->workers()->where((new Proposal)->getTable() . '.status', 'accepted');
    }

    /**
     * Tags many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function tags()
    {
        return $this->belongsToMany(Tag::class);
    }

    /**
     * Filtering projects
     * @param Builder $query
     * @param array $data
     * @return Builder
     */
    public function scopeFilter(Builder $query, array $data = [])
    {
        if(array_get($data, 'categories') && is_array(array_get($data, 'categories'))) {
            $query->byCategoryIds($data['categories']);
        }

        if(array_get($data, 'budget_min')) {
            $query->where('budget', '>=', $data['budget_min']);
        }

        if(array_get($data, 'budget_max')) {
            $query->where('budget', '<=', $data['budget_max']);
        }

        if(array_get($data, 'user_id')) {
            $query->where('author_id', $data['user_id']);
        }

        if(array_get($data, 'type')) {
            $query->whereIn('type', $data['type']);
        }

        if(array_get($data, 'tag')) {
            $query->whereHas('tags', function($query) use ($data) {
                $query->where('name', 'LIKE', '%' . $data['tag'] . '%');
            });
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
    public function scopeByCategoryIds(Builder $query, array $ids)
    {
        return $query->whereHas('categories', function($query) use ($ids) {
            return $query->whereIn('id', $ids);
        });
    }

    /**
     * Fetching projects only for user who applied to those projects
     * @param Builder $query
     * @param int $id
     * @return Builder
     */
    public function scopeAppliedBy(Builder $query, $id)
    {
        return $query->whereHas('proposals', function($query) use ($id) {
            $query->where('author_id', $id);
        });
    }

    /**
     * With proposals count
     * @param Builder $query
     * @return Builder
     */
    public function scopeWithProposalsCount(Builder $query)
    {
        $query->leftJoin('proposals', 'proposals.project_id', '=', 'projects.id');
        $query->groupBy('projects.id');
        $query->addSelect(DB::raw('count(proposals.id) as proposals_count'));

        return $query;
    }

    /**
     * With tags
     * @param Builder $query
     * @return Builder
     */
    public function scopeWithTags(Builder $query)
    {
        return $query->with('tags');
    }

    /**
     * Create/move documents and link to current project
     * @param array $documents
     */
    public function uploadAndaddDocuments(array $documents)
    {
        $result = [];

        foreach($documents as $document) {
            $filename = str_random(10) . '.' .$document->getClientOriginalExtension();
            $document->move(public_path('storage'), $filename);

            array_push($result, new Document([
                'author_id' => $this->author_id,
                'filename' => $filename
            ]));
        }

        $this->documents()->saveMany($result);
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
     * Applied flag
     * @param Builder $query
     * @return Builder
     */
    public function scopeWithProposalSentFlag(Builder $query)
    {
        if(Auth::guard()->check()) {
            $query->addSelect(DB::raw(
                '(select count(*) > 0 from proposals where proposals.project_id = projects.id AND proposals.author_id = ' . Auth::id() . ') as applied'
            ));
        } else {
            $query->addSelect(DB::raw('0 as applied'));
        }

        return $query;
    }

    /**
     * Setting show_email attribute
     * @param $value
     * @return void
     */
    public function setShowEmailAttribute($value)
    {
        $this->attributes['show_email'] = (int)parent::castBooleanAttribute($value);
    }

    /**
     * Setting show_phone attribute
     * @param $value
     * @return void
     */
    public function setShowPhoneAttribute($value)
    {
        $this->attributes['show_phone'] = (int)parent::castBooleanAttribute($value);
    }

    /**
     * Setter for payment_method attribute
     * @param $value
     * @return void
     */
    public function setPaymentMethodAttribute($value)
    {
        $this->attributes['payment_method'] = $value ?: null;
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
            $query->where('projects.title', 'LIKE', "%$keyword%");
            $query->orWhere('projects.description', 'LIKE', "%$keyword%");

            $query->orWhereHas('tags', function($query) use ($keyword) {
                $query->where('name', 'LIKE', "%$keyword%");
            });
        });
    }

    /**
     * Feedback one to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function feedback()
    {
        return $this->hasOne(Feedback::class);
    }
}