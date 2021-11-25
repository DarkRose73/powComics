import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pow_comics/provider/powComics_provider.dart';
//import 'package:pow_comics/provider/powComics_provider.dart';

// ignore: must_be_immutable
class ComicsEditar extends StatefulWidget {
  int id, precio;
  String nombre, universo, edicion;
  ComicsEditar(
      {Key? key,
      this.id = 0,
      this.nombre = '',
      this.universo = "",
      this.edicion = "",
      this.precio = 0})
      : super(key: key);

  @override
  _ComicsEditarState createState() => _ComicsEditarState();
}

class _ComicsEditarState extends State<ComicsEditar> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  PowComicsProvider provider = PowComicsProvider();
  TextEditingController universoCtrl = TextEditingController();
  TextEditingController edicionCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();

  String edicionSeleccion = "", universoSeleccion = "", textError = "";
  String textErrorPrecio = "", textErrorUniverso = "", textErrorEdicion = "";

  @override
  void initState() {
    super.initState();
    idCtrl.text = widget.id.toString();
    nombreCtrl.text = widget.nombre;
    universoCtrl.text = widget.universo;
    edicionCtrl.text = widget.edicion;
    precioCtrl.text = widget.precio.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Comic"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              TextField(
                controller: nombreCtrl,
                decoration: InputDecoration(labelText: 'Nombre del comic'),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  textError,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              campoUniverso(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  textErrorUniverso,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Divider(
                color: Colors.redAccent,
                height: 30,
              ),
              campoEdicion(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  textErrorEdicion,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Divider(
                color: Colors.redAccent,
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: precioCtrl,
                decoration: InputDecoration(labelText: 'Precio'),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  textErrorPrecio,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text("Editar Comic"),
                    onPressed: () async {
                      var precio = precioCtrl.text.trim().isEmpty
                          ? 0
                          : int.parse(precioCtrl.text.trim());

                      var respuesta = await provider.comicsEditar(
                        int.parse(idCtrl.text),
                        nombreCtrl.text.trim(),
                        universoSeleccion,
                        edicionSeleccion,
                        precio,
                      );
                      if (respuesta['message'] != null) {
                        print(respuesta);
                        var errores = respuesta['errors'];
                        setState(() {
                          textError = errores['nombre_comic'] != null
                              ? errores['nombre_comic'][0]
                              : '';
                          textErrorUniverso = errores['universo'] != null
                              ? errores['universo'][0]
                              : '';
                          textErrorEdicion = errores['edicion'] != null
                              ? errores['edicion'][0]
                              : '';
                          textErrorPrecio = errores['precio'] != null
                              ? errores['precio'][0]
                              : '';
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    }),
              )
            ],
          ),
        ));
  }

  Widget campoEdicion() {
    return Column(
      children: [
        RadioListTile<String>(
          groupValue: edicionSeleccion,
          title: Text('Limitada'),
          value: 'Limitada',
          onChanged: (edicion) {
            setState(() {
              edicionSeleccion = edicion!;
            });
          },
        ),
        RadioListTile<String>(
          groupValue: edicionSeleccion,
          title: Text('Regular'),
          value: 'Regular',
          onChanged: (edicion) {
            setState(() {
              edicionSeleccion = edicion!;
            });
          },
        ),
      ],
    );
  }

  Widget campoUniverso() {
    return Column(
      children: [
        RadioListTile<String>(
          groupValue: universoSeleccion,
          title: Text('DC'),
          value: 'DC',
          onChanged: (universo) {
            setState(() {
              universoSeleccion = universo!;
            });
          },
        ),
        RadioListTile<String>(
          groupValue: universoSeleccion,
          title: Text('Marvel'),
          value: 'Marvel',
          onChanged: (universo) {
            setState(() {
              universoSeleccion = universo!;
            });
          },
        ),
      ],
    );
  }
}
