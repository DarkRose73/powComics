import 'package:flutter/material.dart';
import 'package:pow_comics/provider/powComics_provider.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class ArriendosDetalle extends StatefulWidget {
  int id_arriendo;
  ArriendosDetalle({Key? key, this.id_arriendo = 0}) : super(key: key);

  @override
  _ArriendosDetalleState createState() => _ArriendosDetalleState();
}

class _ArriendosDetalleState extends State<ArriendosDetalle> {
  PowComicsProvider provider = PowComicsProvider();
  var fprecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Arriendos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: FutureBuilder(
          future: provider.getArriendo(widget.id_arriendo),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LiquidCircularProgressIndicator(
                  value: 0.6,
                  valueColor: AlwaysStoppedAnimation(Colors.yellowAccent),
                  backgroundColor: Colors.orangeAccent,
                  borderColor: Colors.black,
                  borderWidth: 2.0,
                  direction: Axis.vertical,
                  center: Text("Cargando Detalle"),
                ),
              );
            }

            var arriendo = snapshot.data;
            print(arriendo);
            return Container(
              margin: EdgeInsets.only(top: 20),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(MdiIcons.bookCheck),
                      title: Text(
                        'Detalle del arriendo numero ${arriendo['id']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Nombre Usuario: ${arriendo['user'][0]['nombre_usuario']}'),
                            Text('Celular: ${arriendo['user'][0]['celular']}'),
                            Text(
                                'Nombre Comic: ${arriendo['comic'][0]['nombre_comic']}'),
                            Text(
                                'Universo: ${arriendo['comic'][0]['universo']}'),
                            Text('Edicion: ${arriendo['comic'][0]['edicion']}'),
                            Text(
                                'Fin de arriendo: ${arriendo['fecha_termino']}'),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Precio: \$',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            fprecio.format(
                              arriendo['comic'][0]['precio'],
                            ),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MdiIcons.trashCan),
                            Text('borrar'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                var arriendo = widget.id_arriendo.toString();
                                return AlertDialog(
                                  title: Text('Confirmar borrado de arriendo'),
                                  content: Text(
                                      'Borrar el arriendo numero: $arriendo?'),
                                  actions: [
                                    TextButton(
                                      child: Text('CANCELAR'),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                    ),
                                    ElevatedButton(
                                      child: Text('ACEPTAR'),
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                    ),
                                  ],
                                );
                              }).then((confirma) async {
                            if (confirma) {
                              await provider
                                  .arriendosBorrar(widget.id_arriendo);
                              Navigator.pop(context);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, int id_arriendo) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var arriendo = id_arriendo.toString();
          return AlertDialog(
            title: Text('Confirmar borrado de comic'),
            content: Text('Borrar el comic $arriendo?'),
            actions: [
              TextButton(
                child: Text('CANCELAR'),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                child: Text('ACEPTAR'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }
}
