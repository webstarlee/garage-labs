<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class StartUp extends Model
{
     /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'startups';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'title',
        'finding',
        'concept',
        'business_model',
        'competitors',
        'looking_partners',
        'website',
        'concept_video',
        'author_id',
        'type',
        'fonds_types_id',
        'montant_recherche',
        'parts_sociales_cedees',
        'valorisation_societe',
        'montant_leve',
        'montant_utilisation',
        'logo'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'author_id' => 'integer',
        'fonds_types_id' => 'integer'
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'logo_url'
    ];

    /**
     * The "booting" method of the model.
     *
     * @return void
     */
    public static function boot()
    {
        parent::boot();

        static::creating(function(StartUp $startup) {
            $startup->generateSlug();
        });
    }

    /**
     * Proposals one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function contacts()
    {
        return $this->hasMany(Contact::class);
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
        return $this->belongsToMany(SCategory::class, 'category_startup');
    }

    /**
     * Many to many relationship with MemberTeam entities
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function teams()
    {
        return $this->hasMany(StartupMember::class, 'start_up_id');
    }

     /**
     * A many to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function fonds()
    {
        return $this->belongsTo(FondsType::class);
    }

    /**
     * Skills required for this StartUp
     * @return \Illuminate\Database\Eloquent\Relations\HasManyThrough
     */
    public function skills()
    {
        return $this->belongsToMany(Skill::class, 'skill_startup');
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
     * Filtering projects
     * @param Builder $query
     * @param array $data
     * @return Builder
     */
    public function scopeFilter(Builder $query, array $data = [])
    {
        if(array_get($data, 'skills') && is_array(array_get($data, 'skills'))) {
            $query->bySkillIds($data['skills']);
        }

        if(array_get($data, 'project_status')) {
            $size = sizeof($data['project_status']);
            if ($size < 1) {
                return $query;
            }

            $query->where('project_status', 'like', '%'.$data['project_status'][0].'%');

            for ($i = 1; $i < $size; $i++) {
                $query->orWhere('project_status', 'like', '%'.$data['project_status'][$i].'%');
            }
        }

        return $query;
    }

     /**
     * Filter by skills ids many to many relationship
     * @param Builder $query
     * @param array $ids
     * @return Builder
     */
     public function scopeBySkillIds(Builder $query, array $ids)
     {
         return $query->whereHas('skills', function($query) use ($ids) {
             return $query->whereIn('id', $ids);
         });
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
            $query->where('StartUps.title', 'LIKE', "%$keyword%");
            $query->orWhere('StartUps.description', 'LIKE', "%$keyword%");

            $query->orWhereHas('tags', function($query) use ($keyword) {
                $query->where('name', 'LIKE', "%$keyword%");
            });
        });
    }

     /**
     * Fetching startups only for user who applied to those startups
     * @param Builder $query
     * @param int $id
     * @return Builder
     */
    public function scopeAppliedBy(Builder $query, $id)
    {
        return $query->whereHas('contacts', function($query) use ($id) {
            $query->where('author_id', $id);
        });
    }

    /**
     * Fetching startups only for investor
     * @param Builder $query
     * @return Builder
     */
     public function scopeByInvestor(Builder $query)
     {
        return $query->whereHas('author', function($query) {
            $query->where('i_am', 'like', '%2%');
        });
     }

    /**
     * Fetching startups only for investor
     * @param Builder $query
     * @return Builder
     */
     public function scopeWithNumberContacts(Builder $query)
     {
        $query->addSelect(DB::raw(
            '(select count(distinct author_id) > 0 from contacts where contacts.start_up_id = startups.id) as num_contacts'
        ));

        return $query;
     }


    public function countContacts($startup_id) {
        return DB::table('contacts')
                ->where('start_up_id','=',$startup_id)
                ->distinct('author_id')
                ->count('author_id');
    }

     /**
     * Getter for url attribute
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getLogoUrlAttribute()
    {
        return url("storage/startups/logos/$this->logo");
    }
}