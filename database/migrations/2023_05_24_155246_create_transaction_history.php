<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTransactionHistory extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transaction_histories', function (Blueprint $table) {
            $table->id();
            
            $table->bigInteger('project_id');
            $table->string('from_account_no');
            $table->string('to_account_no');
            $table->double('transaction_amount');
            $table->double('transaction_date');
            $table->double('opening_balance');
            $table->double('closing_balance');
            $table->enum('payment_status',['A','P','R']);
            $table->timestamps();
            $table->index('project_id');
            $table->foreign('project_id')->references('id')->on('project_masters')->onDelete('cascade');


        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transaction_history');
    }
}
