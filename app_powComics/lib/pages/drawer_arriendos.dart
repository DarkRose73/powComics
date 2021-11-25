import 'package:flutter/material.dart';
import 'package:pow_comics/pages/usuarios_agregar.dart';
import 'package:pow_comics/provider/powComics_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: provider.getArriendos(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return DataTable(
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
                          child: Icon(MdiIcons.snake),
                          onPressed: () {},
                        ),
                      ),
                      DataCell(
                        Text(boleta['rut']),
                      ),
                      DataCell(
                        Text(boleta['id_comic'].toString()),
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
        backgroundColor: Colors.yellow,
        onPressed: () {},
      ),
    );
  }
}
