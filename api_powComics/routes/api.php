<?php

use App\Http\Controllers\ArriendosController;
use App\Http\Controllers\ComicsController;
use App\Http\Controllers\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Route::get('/comics',[ComicsController::class, 'index']);
// Route::get('/comics/{comic}',[ComicsController::class, 'show']);
// Route::post('/comics',[ComicsController::class, 'store']);

// Route::get('/arriendos', [ArriendosController::class, 'index']);
// Route::get('/users',[UsersController::class, 'index']);

Route::apiResource('/comics', ComicsController::class);
Route::apiResource('/users', UsersController::class);
Route::apiResource('/arriendos', ArriendosController::class);