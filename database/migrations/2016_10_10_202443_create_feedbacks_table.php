<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFeedbacksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('feedbacks', function (Blueprint $table)
        {
            $table->increments('id');
            $table->integer('author_id')->unsigned()->index();
            $table->integer('receiver_id')->unsigned()->index();
            $table->integer('project_id')->unsigned()->index();
            $table->text('message');
            $table->integer('rating');
            $table->timestamps();

            $table->foreign('author_id')->references('id')->on('users');
            $table->foreign('receiver_id')->references('id')->on('users');
            $table->foreign('project_id')->references('id')->on('projects');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('feedbacks');
    }
}
