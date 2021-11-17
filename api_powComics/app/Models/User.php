<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class User extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'users';
    protected $primaryKey = 'rut';
    public $incrementing=false;
    protected $keyType = 'string'; 
    public function comics(){
        return $this.BelongsToMany(Comic::class, 'arriendos','rut', 'id_comic');
    }

}
