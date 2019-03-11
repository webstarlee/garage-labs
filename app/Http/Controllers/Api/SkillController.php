<?php

namespace App\Http\Controllers\Api;

use App\Skill;

class SkillController extends Controller
{
    /**
     * Fetch categories
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function index()
    {
        return Skill::orderBy('id', 'asc')->get();
    }
}