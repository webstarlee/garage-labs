<?php

namespace App\Http\Controllers\Api;

use App\Category;
use App\SCategory;

class CategoryController extends Controller
{
    /**
     * Fetch categories
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function index()
    {
        return Category::all();
    }

     /**
     * Fetch startup categories
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function getStartUpCategories()
    {
        return SCategory::all();
    }
}