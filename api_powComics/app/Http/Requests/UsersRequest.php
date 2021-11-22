<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UsersRequest extends FormRequest
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
            'rut' => [
                'required',
                'between:9,10',
                'unique:users,rut',
                'ends_with:k,0,1,2,3,4,5,6,7,8,9',
            ],
            'nombre_usuario' => 'required|min:3|unique:users,nombre_usuario',
            'celular' => 'required|different:0|digits:9|starts_with:9|unique:users,celular',
        ];
    }

    public function messages(){
        return [
            'rut.required' => 'Debe ingresar un rut',
            'rut.ends_with' => 'el rut debe terminar con un número o k',
            'rut.between' => 'el rut debe tener entre 9 y 10 caracteres contando el guión',
            'rut.unique'=>'el rut ingresado ya existe',
            'nombre_usuario.required' => 'Debe ingresar un nombre de usuario',
            'nombre_usuario.min' => 'El nombre de usuario debe tener al menos 3 caracteres',
            'nombre_usuario.unique' => 'El nombre de usuario :input ya existe en el sistema',
            'celular.required' => 'Debe ingresar un celular',
            'celular.digits'=>'El celular debe tener 9 digitos',
            'celular.starts_with'=>'El celular debe comenzar con 9',
            'celular.unique'=>'El celular ingresado ya existe',
        ];
    }
}
