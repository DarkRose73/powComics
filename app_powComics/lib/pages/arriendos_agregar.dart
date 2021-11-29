import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pow_comics/provider/powComics_provider.dart';

class ArriendoAgregar extends StatefulWidget {
  ArriendoAgregar({Key? key}) : super(key: key);

  @override
  _ArriendoAgregarState createState() => _ArriendoAgregarState();
}

class _ArriendoAgregarState extends State<ArriendoAgregar> {
  int comicId = 0;
  DateTime fechaSeleccionada = DateTime.now();
  PowComicsProvider provider = PowComicsProvider();
  String arriendoId = "";
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController id_comicCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();
  String errorRut = '', errorId_comic = '';
  var TFecha = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Arriendo"),
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                controller: rutCtrl,
                decoration: InputDecoration(
                  labelText: "Rut",
                  hintText: 'Rut sin puntos, con guion y digito verificador',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  errorRut,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Container(
                child: FutureBuilder(
                  future: provider.getComics(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return DropdownButton<int>(
                      value: comicId == 0 ? null : comicId,
                      hint: Text('Comics'),
                      isExpanded: true,
                      items: snapshot.data.map<DropdownMenuItem<int>>((comic) {
                        return DropdownMenuItem<int>(
                          child: Text(comic['nombre_comic']),
                          value: comic['id'],
                        );
                      }).toList(),
                      onChanged: (comic) {
                        setState(() {
                          comicId = comic!;
                        });
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  errorId_comic,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              campoFecha(),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Text(
                    'Agregar Arriendo',
                    style: TextStyle(fontFamily: "ComicNeue"),
                  ),
                  onPressed: () async {
                    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                    String fecha = dateFormat.format(fechaSeleccionada);
                    int id_comic = comicId;
                    var respuesta = await provider.arriendosAgregar(
                      rutCtrl.text.trim(),
                      id_comic,
                      fecha,
                    );
                    print("respuesta $respuesta");
                    if (respuesta['message'] != null) {
                      var errores = respuesta['errors'];
                      print("errores: $errores");
                      setState(() {
                        errorRut =
                            errores['rut'] != null ? errores['rut'][0] : '';
                        errorId_comic = errores['id_comic'] != null
                            ? errores['id_comic'][0]
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
        ));
  }

  Widget campoFecha() {
    return Row(
      children: [
        Text(
          'Fecha termino del Arriendo: ',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          TFecha.format(fechaSeleccionada),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        TextButton(
          child: Icon(MdiIcons.calendar),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2050),
            ).then((fecha_termino) {
              setState(() {
                fechaSeleccionada =
                    fecha_termino == null ? fechaSeleccionada : fecha_termino;
              });
            });
          },
        ),
      ],
    );
  }
}
