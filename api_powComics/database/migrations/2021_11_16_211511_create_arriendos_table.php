<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateArriendosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('arriendos', function (Blueprint $table) {
            //TODO Como hacer la clave compuesta desde 2 tablas diferentes;
            $table->id();
            $table->string('rut',10)->composite();
            $table->unsignedBigInteger('id_comic')->composite();
            $table->date('fecha_termino');
            $table->foreign('rut')->references('rut')->on('users')->onDelete('cascade');
            $table->foreign('id_comic')->references('id')->on('comics')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('arriendos');
    }
}
