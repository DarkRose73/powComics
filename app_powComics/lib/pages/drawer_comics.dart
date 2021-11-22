import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pow_comics/provider/powComics_provider.dart';

class DrawerComics extends StatelessWidget {
  DrawerComics({Key? key}) : super(key: key);
  PowComicsProvider provider = PowComicsProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comics'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: provider.getComics(),
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
                        title: Text(snapshot.data[index]["nombre_comic"]),
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
                child: Text('Agregar Comic'),
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
