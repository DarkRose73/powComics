import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

//Para ejecutar el servidor usamos:
// php artisan serve --host 0.0.0.0
class PowComicsProvider {
  final String apiURL = 'http://192.168.1.92:8000/api';
}
