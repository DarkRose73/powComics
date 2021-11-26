import 'package:flutter/material.dart';
import 'package:pow_comics/pages/arriendos_detalle.dart';
import 'package:pow_comics/pages/usuarios_agregar.dart';
import 'package:pow_comics/provider/powComics_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class DrawerArriendos extends StatefulWidget {
  const DrawerArriendos({Key? key}) : super(key: key);

  @override
  State<DrawerArriendos> createState() => _DrawerArriendosState();
}

class _DrawerArriendosState extends State<DrawerArriendos> {
  PowComicsProvider provider = PowComicsProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arriendos'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text('ACTUALIZAR'),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: provider.getArriendos(),
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
                    center: Text("Cargando Arriendos"),
                  ),
                );
              }
              return DataTable(
                columnSpacing: 10,
                columns: [
                  DataColumn(label: Text('Detalle')),
                  DataColumn(label: Text('Usuario')),
                  DataColumn(label: Text('Cómic')),
                ],
                rows: snapshot.data.map<DataRow>((boleta) {
                  return DataRow(
                    cells: [
                      DataCell(
                        OutlinedButton(
                          child: Icon(MdiIcons.bookInformationVariant,
                              color: Colors.orange),
                          onPressed: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => ArriendosDetalle(
                                id_arriendo: boleta['id'],
                              ),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ),
                      DataCell(
                        Text(
                          boleta['user'][0]['nombre_usuario'],
                          style: TextStyle(fontFamily: 'ComicNeue'),
                        ),
                      ),
                      DataCell(
                        Text(
                          boleta['comic'][0]['nombre_comic'],
                          style: TextStyle(fontFamily: 'ComicNeue'),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: () {},
      ),
    );
  }
}
