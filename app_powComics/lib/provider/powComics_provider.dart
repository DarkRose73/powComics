import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pow_comics/pages/usuarios_agregar.dart';

//Para ejecutar el servidor usamos:
// php artisan serve --host 0.0.0.0
class PowComicsProvider {
  final String apiURL = 'http://192.168.1.92:8000/api';

  Future<List<dynamic>> getUsers() async {
    var uri = Uri.parse('$apiURL/users');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> usuariosAgregar(
      String rut, String nombre_usuario, int celular) async {
    var uri = Uri.parse('$apiURL/users');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          'rut': rut,
          'nombre_usuario': nombre_usuario,
          'celular': celular,
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  usuariosBorrar(String rut) async {
    var uri = Uri.parse('$apiURL/users/$rut');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<List<dynamic>> getComics() async {
    var uri = Uri.parse('$apiURL/comics');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }
}
