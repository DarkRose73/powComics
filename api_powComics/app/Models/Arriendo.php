<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Arriendo extends Model
{
    use HasFactory;
    protected $table = 'arriendos';
    public $incrementing=false;
    public $timestamps = false;

    public function comic(){
        return $this->hasMany(Comic::class, 'id', 'id_comic');
    }

    public function user(){
        return $this->hasMany(User::class, 'rut', 'rut');
    }
}
