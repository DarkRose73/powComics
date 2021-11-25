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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: provider.getArriendos(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(MdiIcons.book),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data[index]["rut"],
                            ),
                            Text(snapshot.data[index]['id_comic'].toString()),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.all(7),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontFamily: 'ComicNeue', fontWeight: FontWeight.bold),
                ),
                child: Text('Agregar arriendo'),
                onPressed: () {
                  // MaterialPageRoute route = MaterialPageRoute(
                  //   builder: (context) => UsuariosAgregar(),
                  // );
                  // Navigator.push(context, route).then((value) {
                  //   setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
