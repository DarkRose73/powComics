import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pow_comics/provider/powComics_provider.dart';
//import 'package:pow_comics/provider/powComics_provider.dart';

class ComicsAgregar extends StatefulWidget {
  ComicsAgregar({Key? key}) : super(key: key);

  @override
  _ComicsAgregarState createState() => _ComicsAgregarState();
}

class _ComicsAgregarState extends State<ComicsAgregar> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController universoCtrl = TextEditingController();
  TextEditingController edicionCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();

  String edicionSeleccion = "", universoSeleccion = "", textError = "";
  String textErrorPrecio = "", textErrorUniverso = "", textErrorEdicion = "";
  PowComicsProvider provider = PowComicsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Comic"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
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
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Text("Agregar Comic"),
                  onPressed: () async {
                    var precio = precioCtrl.text.trim().isEmpty
                        ? 0
                        : int.parse(precioCtrl.text.trim());
                    var respuesta = await provider.comicsAgregar(
                      nombreCtrl.text.trim(),
                      universoSeleccion,
                      edicionSeleccion,
                      precio,
                    );
                    if (respuesta['message'] != null) {
                      var errores = respuesta['errors'];
                      setState(() {
                        textError = errores['nombre_comic'] != null
                            ? errores['nombre_comic'][0]
                            : '';
                        textErrorPrecio = errores['precio'] != null
                            ? errores['precio'][0]
                            : '';
                        textErrorUniverso = errores['universo'] != null
                            ? errores['universo'][0]
                            : '';
                        textErrorEdicion = errores['edicion'] != null
                            ? errores['edicion'][0]
                            : '';
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
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
