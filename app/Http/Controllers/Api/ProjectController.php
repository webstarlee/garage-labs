<?php

namespace App\Http\Controllers\Api;

use DB;
use Auth;
use App\User;
use App\Project;
use App\Conversation;
use Illuminate\Http\Request;
use App\Events\ProjectWasCreated;
use App\Http\Requests\Api\StoreProjectRequest;
use App\Http\Requests\Api\UpdateProjectRequest;

class ProjectController extends Controller
{
    /**
     * ProjectController constructor
     */
    public function __construct()
    {
        $this->middleware('auth:api')->only([
            'applied',
            'checkFirst',
            'checkSecond',
            'store',
            'update',
            'forUser'
        ]);
    }

    /**
     * Validate project first stage
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function checkFirst(Request $request)
    {
        $this->validate($request, [
            'title' => 'required',
            'description' => 'required',
            'categories' => 'required|array|min:1',
            'categories.*.id' => 'required|integer|exists:categories,id',
            'tags' => 'array',
            'tags.*.id' => 'required|integer',
            'budget' => 'required|integer',
            'starts_at' => 'required|date',
            'ends_at' => 'date',
            'attachment' => 'file'
        ]);

        return response()->json(['message' => 'ok'], 200);
    }

    /**
     * Validate project second stage
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function checkSecond(Request $request)
    {
        $this->validate($request, [
            'contact_phone' => 'required_if:show_phone,1',
            'contact_email' => 'email|required_if:show_email,1'
        ]);

        return response()->json();
    }

    /**
     * Store project
     * @param StoreProjectRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(StoreProjectRequest $request)
    {
        $project = new Project($request->allowed());
        $project->author_id = Auth::guard()->id();

        DB::transaction(function() use ($project, $request)
        {
            $project->save();

            if(is_array($request->tags) && count($request->tags) > 0) {
                $project->tags()->attach(array_pluck($request->tags, 'id'));
            }

            if(is_array($request->attachments) && count($request->attachments) > 0) {
                $project->documents()->attach(array_pluck($request->attachments, 'id'));
            }

            $project->categories()->attach(array_pluck($request->categories, 'id'));
        });

        event(new ProjectWasCreated($project));

        return response()->json($project, 201);
    }

    /**
     * Update project request
     * @param UpdateProjectRequest $request
     * @param string $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UpdateProjectRequest $request, $id)
    {
        $project = Project::findOrFail($id);
        $project->fill($request->allowed());

        DB::transaction(function() use ($project, $request)
        {
            $project->save();
            $project->tags()->sync(array_pluck($request->tags, 'id'));
            $project->categories()->sync(array_pluck($request->categories, 'id'));

            if(is_array($request->attachments) && count($request->attachments) > 0) {
                $project->documents()->attach(array_pluck($request->attachments, 'id'));
            }
        });

        return response()->json($project);
    }

    /**
     * Retrieving projects
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $this->validate($request, [
            'budget_min' => 'integer',
            'budget_max' => 'integer',
            'user_id' => 'integer'
        ]);

        return Project::filter($request->all())
            ->withProposalsCount()
            ->withTags()
            ->latest()
            ->paginate();
    }

    /**
     * Get projects which user with given id has applied to
     * @return \Illuminate\Http\JsonResponse
     */
    public function applied()
    {
        return Project::appliedBy(Auth::guard()->id())
            ->withProposalsCount()
            ->latest()
            ->get();
    }

    /**
     * Fetch projects created by authenticated user
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function forUser()
    {
        return Project::where('projects.author_id', Auth::id())
            ->withProposalsCount()
            ->latest()
            ->get();
    }

    /**
     * Fetch projects by author_id
     * @param string $id
     * @return mixed
     */
    public function byUserId($id)
    {
        return Project::where('projects.author_id', $id)
            ->with('author')
            ->withProposalsCount()
            ->latest()
            ->get();
    }

    /**
     * Fetch project by slug
     * @param string $slug
     * @return Project
     */
    public function bySlug($slug)
    {
        $project = Project::withProposalSentFlag()
            ->where('projects.slug', $slug)
            ->firstOrFail();

        $project = $this->preprocessProject($project);

        return $project;
    }

    /**
     * Show single project
     * @param string $id
     * @return Project
     */
    public function show($id)
    {
        $project = Project::withProposalSentFlag()
            ->where('projects.id', $id)
            ->firstOrFail();

        $project = $this->preprocessProject($project);

        return $project;
    }

    /**
     * Preprocess project for single get request
     * @param Project $project
     * @return Project
     */
    private function preprocessProject(Project $project)
    {
        $project->incrementViews();

        $project->load('tags');
        $project->load('documents');
        $project->load('categories');
        $project->load('proposals.author');

        $project->attachments = [];

        if(Auth::check() AND $project->author_id === Auth::id()) {
            $project->proposals->makeVisible('message', 'offer');
        }

        $project->author = User::where('id', $project->author_id)
                               ->withStats($project->author_id)
                               ->firstOrFail();

        // if(Auth::check() AND Auth::id() !== $project->author_id) {
        if(Auth::check()) {
            $conversation = Conversation::where('project_id', $project->id)->withMemberById(Auth::id())->first();

            if(! is_null($conversation) AND $conversation->exists) {
                $project->author->contact_link = "/user/messages/thread/$conversation->id";
            }
        }

        return $project;
    }
}