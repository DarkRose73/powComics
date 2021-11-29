<?php

namespace App\Http\Controllers;

use App\Http\Requests\ArriendosRequest;
use App\Models\Arriendo;
use Illuminate\Http\Request;

class ArriendosController extends Controller
{
    public function index()
    {
        $arriendos = Arriendo::all();
        foreach($arriendos as $arriendo){
            $arriendo->load('comic');
        }
        foreach($arriendos as $arriendo){
            $arriendo->load('user');
        }
        return $arriendos;
    }

    public function store(ArriendosRequest $request)
    {
        $arriendo = new Arriendo();
        $arriendo->rut = $request->rut;
        $arriendo->id_comic = $request->id_comic;
        $arriendo->fecha_termino = $request->fecha_termino;
        $arriendo->save();
        return $arriendo;        
    }

    public function show(Arriendo $arriendo)
    {
        $arriendo->load('comic');
        $arriendo->load('user');

        return $arriendo;
    }

    public function update(Request $request, Arriendo $arriendo)
    {
        $arriendo->rut = $request->rut;
        $arriendo->id_comic = $request->id_comic;
        $arriendo->fecha_termino = $request->fecha_termino;
        $arriendo->save();
        return $arriendo;  
    }

    public function destroy(Arriendo $arriendo)
    {
        $arriendo->delete();
    }
}
