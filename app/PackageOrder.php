<?php

namespace App;

use Illuminate\Database\Eloquent\Builder;
use DB;
use Auth;

class PackageOrder extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'paying_date',
        'package_id'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'package_id' => 'integer'
    ];

    public function setDelivery() {
        $this->status = 'waiting';
    }

    public function approve() {
        $this->status = 'approved';
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function package()
    {
        return $this->belongsTo(Package::class);
    }

    public function askRevision() {
        $this->status = 'new';
    }

    public function increase_asked_revisions() {
        $this->asked_revisions = $this->asked_revisions + 1;
    }

    /**
     * Documents many to many morph relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function documents()
    {
        return $this->hasMany(PackageDocument::class, 'package_order_id');
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function buyer()
    {
        return $this->belongsTo(User::class, 'buyer_id');
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function seller()
    {
        return $this->belongsTo(User::class, 'seller_id');
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function package_delivery()
    {
        return $this->hasOne(PackageDelivery::class, 'ordered_package_id');
    }

    /**
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function package_revisions()
    {
        return $this->hasMany(PackageRevision::class, 'ordered_package_id');
    }

    /**
     * One to one relationship
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
    */
    public function conversation()
    {
        return $this->hasMany(ServiceMessage::class);
    }

    /**
    * Fetch by conversation relation
    * @param Builder $query
    * @param int $id
    * @return Builder
    */
    public function scopeByRelatedUsers(Builder $query, $userId)
    {
        return $query->where(function($query) use ($userId) {
            $query->where('seller_id', $userId);
            $query->orWhere('buyer_id', $userId);
        });
    }
}