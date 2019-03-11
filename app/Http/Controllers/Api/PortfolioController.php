<?php

namespace App\Http\Controllers\Api;

use App\Portfolio;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests;
use Auth;

class PortfolioController extends Controller
{
	
    /**
     * AccountController constructor.
     * @param Hasher $hasher
     */
    public function __construct()
    {
        $this->middleware('auth:api');
	}
	
	/**
	 * Get Portfolios by use
	 * @param int $user_id
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function byUser($user_id)
	{
		$user = User::findOrFail($user_id);
		$portfolios = $user->portfolios();
		return Portfolio::where('user_id', $user_id)->get();
	}

	/**
	 * add Portfolio
	 * @param int $user_id
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function addItem(Request $request, $user_id)
	{
		$user = User::findOrFail($user_id);

		if ($request->title ==  null || $request->title == 'undefined') {
			abort(403, 'The Title field is required.');
		}

		if ($request->description == null || $request->description == 'undefined') {
			abort(403, 'The Description field is required.');
		}

		if ($request->id == '' && $request->file('portfolio_item') == null) {
			abort(403, 'The image is required.');
		}
		
		if ($request->id !== '') {
			$newPortfolio = Portfolio::findOrFail($request->id );
		} else {
			$newPortfolio = new Portfolio;
		}

		if ($request->file('portfolio_item') !== null) {
			$filename = $user->localSavePortfolio($request->file('portfolio_item'));
			$newPortfolio->item_path 	= $filename;
		}

		

		$newPortfolio->user_id 		= $user_id;
		$newPortfolio->title 		= $request->title;
		$newPortfolio->description 	= $request->description;


		$user->portfolios()->save($newPortfolio);

		return response()->json($user->portfolios, 200);
	}

	public function deleteItem(Request $request) {
		$portfolio = Portfolio::where('user_id', Auth::guard()->id())->where('id', $request->id)->firstOrFail();
		$portfolio->delete();

		return response()->json(["message" => "OK"], 200);
	}
}
