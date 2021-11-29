<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ArriendosRequest extends FormRequest
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
                'exists:App\Models\User,rut',
                'ends_with:k,0,1,2,3,4,5,6,7,8,9',
            ],
            'id_comic' => 'required|gt:0|exists:App\Models\Comic,id'
           

        ];
    }

    public function messages(){
        return [
            
            'rut.required' => 'Debe ingresar un rut',
            'rut.exists' => 'Debe existir el rut en el sistema',
            'rut.ends_with' => 'el rut debe terminar con un número o k',
            'rut.between' => 'el rut debe tener entre 9 y 10 caracteres contando el guión',
            'id_comic.required' => 'Debe ingresar un id de comic',
            'id_comic.gt' => "Debe ingresar un id de comic",
            'id_comic.exists' =>"Debe ingresar un id de comic existente",
            
            
        ];
    }
}