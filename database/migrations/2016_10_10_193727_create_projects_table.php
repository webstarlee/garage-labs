<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProjectsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('projects', function (Blueprint $table)
        {
            $table->increments('id');
            $table->enum('type', ['project', 'mission'])->default('project');
            $table->enum('status', ['opened', 'closed'])->default('opened');

            $table->integer('author_id')->unsigned()->index();
            $table->string('title');
            $table->text('description');

            $table->string('slug')->unique()->index();
            $table->enum('payment_method', ['by day', 'flat price'])->nullable();
            $table->integer('budget');

            $table->date('starts_at');
            $table->date('ends_at')->nullable();
            $table->text('place')->nullable();

            $table->boolean('show_email')->default(true);
            $table->boolean('show_phone')->default(true);

            $table->string('contact_phone')->nullable();
            $table->string('contact_email')->nullable();
            $table->integer('views')->default(0);

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
        Schema::dropIfExists('projects');
    }
}
