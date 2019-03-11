<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table)
        {
            $table->increments('id');
            $table->string('first_name')->nullable();
            $table->string('last_name')->nullable();

            $table->string('username')->unique();
            $table->string('email')->unique();
            $table->string('password');
            $table->char('api_token', 60)->unique();

            $table->string('phone')->nullable();
            $table->string('company_name')->nullable();
            $table->string('company_phone')->nullable();

            $table->string('address')->nullable();
            $table->string('postal_code')->nullable();
            $table->integer('country_id')->unsigned()->index()->nullable();
            $table->integer('city_id')->unsigned()->index()->nullable();

            $table->string('cover_path')->nullable();
            $table->string('avatar_path')->nullable();
            $table->string('website')->nullable();

            $table->rememberToken();
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
        Schema::drop('users');
    }
}