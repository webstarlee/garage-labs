<?php

namespace App;

use DB;
use File;
use Illuminate\Http\UploadedFile;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'first_name',
        'last_name',
        'username',
        'email',
        'phone',
        'company_name',
        'company_phone',
        'address',
        'postal_code',
        'country_id',
        'city_id',
        'cover_path',
        'avatar_path',
        'website',
        'linkedin_url',
        'i_am',
        'presentation'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'country_id' => 'integer',
        'city_id' => 'integer',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
        'api_token',
        // 'displaying_i_am'
    ];

    /**
     * Default avatar_path value
     *
     * @var string
     */
    protected $default_avatar_path = 'vendor/avatar/default.jpg';

    /**
     * Default cover_path value
     *
     * @var string
     */
    protected $default_cover_path = '/vendor/cover/cover_shotpro_27eyr2d.jpg';

    /**
     * The "booting" method of the model.
     *
     * @return void
     */
    public static function boot()
    {
        parent::boot();

        static::addGlobalScope('selectAll', function(Builder $query) {
            $query->addSelect('users.*');
        });

        static::creating(function(User $user) {
            $user->refreshApiToken();
        });
    }

    /**
     * Refresh api token
     * @return void
     */
    public function refreshApiToken()
    {
        $this->api_token = str_random(60);
    }

    /**
     * Default avatar path
     * @return string
     */
    public function getDefaultAvatarPath()
    {
        return url($this->default_avatar_path);
    }

    /**
     * Default cover path
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getDefaultCoverPath()
    {
        return url($this->default_cover_path);
    }

    /**
     * Delete old cover file if one exists
     * @return void
     */
    public function deleteOldCover()
    {
        if($this->getOriginal('cover_path')) {
            File::delete(public_path('storage/' . $this->cover_filename));
        }
    }

    /**
     * Update cover, move file to public and update db record
     * @param \Illuminate\Http\UploadedFile $file
     * @return void
     */
    public function updateCover(UploadedFile $file)
    {
        $filename = str_random(10) . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('storage'), $filename);

        $this->cover_path = url("storage/$filename");
        $this->save();
    }

    /**
     * Delete old avatar file if one exists
     * @return void
     */
    public function deleteOldAvatar()
    {
        if($this->getOriginal('avatar_path')) {
            File::delete(public_path('storage/' . $this->avatar_filename));
        }
    }

    /**
     * Update avatar, move file to public storage and save db record
     * @param \Illuminate\Http\UploadedFile $file
     * @return void
     */
    public function updateAvatar(UploadedFile $file)
    {
        $filename = str_random(10) . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('storage'), $filename);

        $this->avatar_path = url("storage/$filename");
        $this->save();
    }

     public function localSavePortfolio(UploadedFile $file)
    {
        $filename = str_random(10) . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('storage/portfolio'), $filename);  
        return url("storage/portfolio/$filename");     
    }

    /**
     * Feedbacks one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function feedbacks()
    {
        return $this->hasMany(Feedback::class, 'receiver_id');
    }

    /**
     * References one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function references()
    {
        return $this->hasMany(Reference::class);
    }

    /**
     * Portfolio one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany 
    */
    public function portfolios()
    {
        return $this->hasMany(Portfolio::class);
    }

    public function company() {
        return $this->hasOne(UserCompany::class, 'user_id');
    }

    /**
     * @param Builder $query
     * @return mixed
     */
    public function scopeWithAverageRating(Builder $query)
    {
        $query->leftJoin('feedbacks', 'feedbacks.receiver_id', '=', 'users.id')
            ->groupBy('users.id')
            ->addSelect(DB::raw('avg(feedbacks.rating) as rating'));
    }

    /**
     * Default cover path url
     * @param $value
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getCoverPathAttribute($value)
    {
        return $value ?: $this->getDefaultCoverPath();
    }

    /**
     * Setter for cover_path attribute
     * @param $value
     */
    public function setCoverPathAttribute($value)
    {
        $this->attributes['cover_path'] = ($value === $this->getDefaultCoverPath()) ? null : $value;
    }

    /**
     * For login query
     * @param Builder $query
     * @param int $userId
     * @return Builder
     */
    public function scopeWithStats(Builder $query, $userId)
    {
        return $query->withProposalsCount($userId)
            ->withWonProposalsCount($userId)
            ->withProjectsCount($userId)
            ->with('country', 'city');
    }

    /**
     * With user projects count
     * @param Builder $query
     * @param $userId
     * @return mixed
     */
    public function scopeWithProjectsCount(Builder $query, $userId)
    {
        return $query->addSelect(DB::raw("(select count(projects.id) from projects where projects.author_id = $userId) as projects"));
    }

    /**
     * With user projects count
     * @param Builder $query
     * @param $userId
     * @return mixed
     */
    public function scopeWithStartupsCount(Builder $query, $userId)
    {
        return $query->addSelect(DB::raw("(select count(startups.id) from startups where startups.author_id = $userId) as startups"));
    }

    /**
     * Projects one to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function projects()
    {
        return $this->hasMany(Project::class, 'author_id');
    }

    /**
     * With won proposals count
     * @param Builder $query
     * @param $userId
     * @return Builder
     */
    public function scopeWithWonProposalsCount(Builder $query, $userId)
    {
        return $query->addSelect(
            DB::raw("(select count(proposals.id) from proposals where proposals.author_id = $userId AND proposals.status = 'accepted') as proposals_won")
        );
    }

    /**
     * With total proposals count
     * @param Builder $query
     * @param int $userId
     * @return Builder $query
     */
    public function scopeWithProposalsCount(Builder $query, $userId)
    {
        return $query->addSelect(DB::raw("(select count(proposals.id) from proposals where proposals.author_id = $userId) as proposals"));
    }

    /**
     * Accessor for avatar_path attribute
     * @param $value
     * @return \Illuminate\Contracts\Routing\UrlGenerator|string
     */
    public function getAvatarPathAttribute($value)
    {
        return is_null($value) ? url('vendor/avatar/default.jpg') : url($value);
    }

    /**
     * Setter for avatar_path attribute
     * @param $value
     */
    public function setAvatarPathAttribute($value)
    {
        $this->attributes['avatar_path'] = ($value === $this->getDefaultAvatarPath()) ? null : $value;
    }

    /**
     * Get avatar filename
     * @return string
     */
    public function getAvatarFilenameAttribute()
    {
        if($this->getOriginal('avatar_path') === null) {
            return null;
        }

        $pieces = explode('/', $this->avatar_path);

        return end($pieces);
    }

    /**
     * Get avatar filename
     * @return string
     */
    public function getCoverFilenameAttribute()
    {
        if($this->getOriginal('cover_path') === null) {
            return null;
        }

        $pieces = explode('/', $this->cover_path);

        return end($pieces);
    }

    /**
     * One to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function country()
    {
        return $this->belongsTo(Country::class);
    }

    /**
     * One to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function city()
    {
        return $this->belongsTo(City::class);
    }

     /**
     * Many to many relationship with Skill entities
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function skills()
    {
        return $this->belongsToMany(Skill::class);
    }

     /**
     * Many to many relationship with Skill entities
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function other_skills()
    {
        return $this->hasMany(OtherSkill::class);
    }

    /**
     * Many to many relationship with Startup entities
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function startups()
    {
        return $this->belongsToMany(StartUp::class, 'startup_members')
                    ->withPivot('role','description');
    }

    /**
     * One to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function bank()
    {
        return $this->hasOne(UserBank::class, 'user_id');
    }

    /**
     * Many to many relationship with Startup entities
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function credit_cards()
    {
        return $this->hasMany(CreditCard::class, 'author_id');
    }

    /**
     * Getter for full name
     * @return string
     */
    public function getFullnameAttribute()
    {
        return $this->first_name . ' ' . $this->last_name;
    }
    /**
     * Getter Displaying I am 
     * @return array
     */
    public function getDisplayingIam()
    {
        return explode('|', $this->displaying_i_am);
    }

    /**
     * With meta information
     * @param Builder $query
     * @return Builder
     */
    public function scopeWithMeta(Builder $query)
    {
        $query->addSelect([
            DB::raw('(select count(*) from `references` where `references`.user_id = users.id) as references_count'),
            DB::raw('(select count(*) from projects where projects.author_id = users.id) as projects_count'),
            DB::raw('(select count(*) from feedbacks where feedbacks.receiver_id = users.id) as feedbacks_count'),
            DB::raw('(select count(*) from startup_members where startup_members.user_id = users.id) as startups_count'),
            DB::raw('(select count(*) from portfolios where portfolios.user_id = users.id) as portfolio_count')

        ]);

        $query->with('city', 'country');

        return $query;
    }

        /**
     * With meta information
     * @param Builder $query
     * @return Builder
     */
    // public function scopeWithRatting(Builder $query)
    // {
    //     $query->addSelect([
    //         DB::raw('(select count(*), AVG(rating) from `feedbacks` where `feedbacks`.receiver_id = users.id order by receiver_id) as avg_ratting'),
    //         // DB::raw('(select count(*) from projects where projects.author_id = users.id) as projects_count'),
    //     ]);

    //     return $query;
    // }

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
 
         if(array_get($data, 'i_am')) {
             $size = sizeof($data['i_am']);
             if ($size < 1) {
                 return $query;
             }
 
             $query->where('i_am', 'like', '%'.$data['i_am'][0].'%');
 
             for ($i = 1; $i < $size; $i++) {
                 $query->orWhere('i_am', 'like', '%'.$data['i_am'][$i].'%');
             }
         } else {
            $query->where('i_am', 'like', '%1%');
            $query->orWhere('i_am', 'like', '%2%');
         }
 
         return $query;
    }

    public function update_rating($rating) {
        $this->num_reviews = $this->num_reviews + 1;

        if ($this->num_reviews == 1) {
            $this->avg_stars = $rating;
        } else {
            $this->avg_stars = round(($this->avg_stars + $rating) / 2);
        }
    }

}