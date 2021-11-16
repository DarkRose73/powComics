<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class usersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $ruts = ['12345678-5','98765432-1','7654321-2'];

        for($i=0;$i<3;$i++){
            $user = new User();
            $user->rut=$ruts[$i];
            $user->nombre_usuario="test_user no. ". strval($i);
            $user->celular=123456789;
            $user->save();
        }
    }
}
