<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ComicsRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'nombre_comic' => 'required|min:3|unique:comics,nombre_comic|max:100',
            'precio' => 'required|min:4|max:6',
            'universo' => 'required',
            'edicion' => 'required'
        ];
    }
    public function messages(){
        return[
            'nombre_comic.required' => 'Debe ingresar el nombre del comic pajaron',
            'nombre_comic.min'=>'Debe tener minimo de 3 caracteres pelmazo',
            'nombre_comic.unique' => 'El nombre del comic :input ya existe en el sistema ridiculo',
            'nombre_comic.max'=>'Debe tener maximo de 100 caracteres',
            'precio.required' => 'Debe ingresar el precio del comic pajaron',
            'precio.min'=>'Debe tener minimo de 4 digitos pelmazo',
            'precio.max'=>'Debe tener maximo de 6 digitos, no infle precios',
            'universo.required' => 'Debe ingresar a que universo pertenece',
            'edicion.required' => 'Debe ingresar el tipo de edicion es el comic',
        ];
    }
}
