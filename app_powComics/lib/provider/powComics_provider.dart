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

  Future<LinkedHashMap<String, dynamic>> usuariosEditar(
      String rut, String nombre_usuario, int celular) async {
    var uri = Uri.parse('$apiURL/users/$rut');
    var respuesta = await http.put(
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

  Future<List<dynamic>> getArriendos() async {
    var uri = Uri.parse('$apiURL/arriendos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> getArriendo(int id) async {
    var uri = Uri.parse('$apiURL/arriendos/$id');
    var respuesta = await http.get(uri);
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> arriendosAgregar(String rut,
      int id_comic, String fecha_inicio, String fecha_termino) async {
    var uri = Uri.parse('$apiURL/arriendos');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          'rut': rut,
          'id_comic': id_comic,
          'fecha_inicio': fecha_inicio,
          'fecha_termino': fecha_termino,
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  arriendosBorrar(int id) async {
    var uri = Uri.parse('$apiURL/arriendos/$id');
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

  Future<LinkedHashMap<String, dynamic>> comicsAgregar(
      String nombreComic, String universo, String edicion, int precio) async {
    //, String universo, int precio, String edicion
    var url = Uri.parse('$apiURL/comics');
    var respuesta = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'nombre_comic': nombreComic,
          'universo': universo,
          'edicion': edicion,
          'precio': precio,
        }));
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> comicsEditar(int id,
      String nombreComic, String universo, String edicion, int precio) async {
    var uri = Uri.parse('$apiURL/comics/$id');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'nombre_comic': nombreComic,
        'universo': universo,
        'edicion': edicion,
        'precio': precio,
      }),
    );

    return json.decode(respuesta.body);
  }

  comicsBorrar(int id) async {
    var uri = Uri.parse('$apiURL/comics/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
