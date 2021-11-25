<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Comic extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'comics';
    public function users(){
        return $this.BelongsToMany(User::class, 'arriendos','id_comic', 'rut');
    }
}
