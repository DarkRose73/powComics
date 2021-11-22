import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pow_comics/pages/drawer_arriendos.dart';
import 'package:pow_comics/pages/drawer_comics.dart';
import 'package:pow_comics/pages/drawer_usuarios.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'POW! Comics',
          style: TextStyle(
              fontFamily: 'ComicNeue',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 6, 0, 100),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: Colors.yellowAccent,
              border: Border.all(color: Colors.yellowAccent),
              borderRadius: BorderRadius.circular(10.0)),
          height: 540,
          width: 300,
          child: ListView(children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡¡Proximamente!!',
                    style: TextStyle(
                        fontFamily: 'ComicNeue',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Spacer(),
            Image(
              image: AssetImage('assets/images/spider-verse-vol-1.jpg'),
            ),
            Text(
              'Con descuento navideño.. 👀',
              style: TextStyle(
                  fontFamily: 'ComicNeue',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          ]),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                height: 150,
                width: 150,
                child: Image(
                  image: AssetImage('assets/images/pow.png'),
                ),
              ),
            ),
            ListTile(
              title: Text('Usuarios'),
              leading: Icon(Icons.people),
              onTap: () => _navegar(context, 1),
            ),
            Divider(),
            ListTile(
              title: Text('Comics'),
              leading: Icon(Icons.book),
              onTap: () => _navegar(context, 2),
            ),
            Divider(),
            ListTile(
              title: Text('Arriendos'),
              leading: Icon(MdiIcons.cashMultiple),
              onTap: () => _navegar(context, 3),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

void _navegar(BuildContext context, int pagina) {
  List<Widget> paginas = [
    DrawerUsuarios(),
    DrawerComics(),
    DrawerArriendos(),
  ];

  final route = MaterialPageRoute(builder: (context) {
    return paginas[pagina - 1];
  });

  Navigator.push(context, route);
}
