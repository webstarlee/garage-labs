<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateMessagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('messages', function (Blueprint $table)
        {
            $table->increments('id');
            $table->integer('conversation_id')->unsigned()->index();
            $table->integer('sender_id')->unsigned()->index();
            $table->integer('receiver_id')->unsigned()->index();
            $table->text('text');
            $table->boolean('read')->default(false);
            $table->timestamp('updated_at')->nullable();
            $table->timestamp('created_at')->index()->nullable();

            $table->foreign('sender_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('receiver_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('messages');
    }
}
