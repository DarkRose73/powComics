<?php

namespace App\Http\Controllers;

use App\Models\Arriendo;
use Illuminate\Http\Request;

class ArriendosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Arriendo::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $arriendo = new Arriendo();
        $arriendo->rut = $request->rut;
        $arriendo->id_comic = $request->id_comic;
        $arriendo->fecha_inicio = $request->fecha_inicio;
        $arriendo->fecha_termino= $request->fecha_termino;
        $arriendo->save();
        return $arriendo;        
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Arriendo  $Arriendo
     * @return \Illuminate\Http\Response
     */
    public function show(Arriendo $arriendo)
    {
        return $arriendo;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Arriendo  $Arriendo
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Arriendo $arriendo)
    {
        $arriendo->rut = $request->rut;
        $arriendo->id_comic = $request->id_comic;
        $arriendo->fecha_inicio = $request->fecha_inicio;
        $arriendo->fecha_termino= $request->fecha_termino;
        $arriendo->save();
        return $arriendo;  
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Arriendo  $Arriendo
     * @return \Illuminate\Http\Response
     */
    public function destroy(Arriendo $arriendo)
    {
        $arriendo->delete();
    }
}
