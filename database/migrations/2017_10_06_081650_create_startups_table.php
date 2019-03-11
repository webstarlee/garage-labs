<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateStartupsTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('startups', function(Blueprint $table)
		{
			$table->increments('id');
			$table->string('title');
			$table->string('finding', 10);
			$table->text('concept', 65535)->nullable();
			$table->text('business_model', 65535)->nullable();
			$table->text('competitors', 65535)->nullable();
			$table->string('project_status', 20);
			$table->text('looking_partners', 65535)->nullable();
			$table->string('website');
			$table->string('concept_video');
			$table->integer('author_id')->unsigned();
			$table->integer('views')->unsigned()->default(0);
			$table->string('slug');
			$table->string('type', 10)->default('startups');
			$table->timestamps();
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('startups');
	}

}
