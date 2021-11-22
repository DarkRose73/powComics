import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pow_comics/provider/powComics_provider.dart';

class UsuariosAgregar extends StatefulWidget {
  UsuariosAgregar({Key? key}) : super(key: key);

  @override
  _UsuariosAgregarState createState() => _UsuariosAgregarState();
}

class _UsuariosAgregarState extends State<UsuariosAgregar> {
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController celularCtrl = TextEditingController();
  PowComicsProvider provider = PowComicsProvider();
  String textoErrorRut = '', textoErrorNombre = '', textoErrorCelular = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: rutCtrl,
              decoration: InputDecoration(
                labelText: 'Rut',
                hintText: 'Rut sin puntos, con guion y digito verificador',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                textoErrorRut,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
                hintText: 'Nombre del usuario dentro de la aplicacion',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                textoErrorNombre,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: celularCtrl,
              decoration: InputDecoration(
                labelText: 'Celular',
                hintText: 'Celular del usuario agregando 9 al comienzo',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                textoErrorCelular,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontFamily: 'ComicNeue', fontWeight: FontWeight.bold),
                ),
                child: Text('Agregar Usuario'),
                onPressed: () async {
                  var celular = celularCtrl.text.trim().isEmpty
                      ? 0
                      : int.parse(celularCtrl.text.trim());
                  var respuesta = await provider.usuariosAgregar(
                    rutCtrl.text.trim(),
                    nombreCtrl.text.trim(),
                    celular,
                  );
                  if (respuesta['message'] != null) {
                    var errores = respuesta['errors'];
                    setState(() {
                      textoErrorNombre = errores['nombre_usuario'] != null
                          ? errores['nombre_usuario'][0]
                          : '';
                      textoErrorRut =
                          errores['rut'] != null ? errores['rut'][0] : '';
                      textoErrorCelular = errores['celular'] != null
                          ? errores['celular'][0]
                          : '';
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
