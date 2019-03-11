<?php

namespace App;

use DB;
use Auth;
use Illuminate\Database\Eloquent\Builder;

class CreditCard extends Model
{
    protected $table = 'credit_cards';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'author_id',
        'card_id',
        'customer_id',
        'card_no',
        'cvc',
        'expired_day'
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
     * Projects morph many to many relationship
     * @return \Illuminate\Database\Eloquent\Relations\MorphToMany
     */
    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }
}