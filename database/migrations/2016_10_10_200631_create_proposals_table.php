<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProposalsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('proposals', function (Blueprint $table)
        {
            $table->increments('id');
            $table->integer('author_id')->unsigned()->index();
            $table->integer('project_id')->unsigned()->index();

            $table->integer('offer');
            $table->text('message');
            $table->enum('status', ['waiting', 'accepted', 'rejected'])->default('waiting');

            $table->unique(['author_id', 'project_id']);

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
        Schema::dropIfExists('proposals');
    }
}
