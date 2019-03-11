<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDocumenttablesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('documenttables', function (Blueprint $table)
        {
            $table->integer('document_id')->unsigned();
            $table->integer('documenttable_id')->unsigned();
            $table->string('documenttable_type');
            $table->primary(['document_id', 'documenttable_id', 'documenttable_type'], 'documenttables_primary');
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP()'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP()'));
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('documenttables');
    }
}
