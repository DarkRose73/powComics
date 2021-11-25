import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pow_comics/provider/powComics_provider.dart';
import 'package:pow_comics/pages/comics_agregar.dart';
import 'package:pow_comics/pages/comics_editar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// ignore: unused_import
import 'dart:math';

class DrawerComics extends StatefulWidget {
  const DrawerComics({Key? key}) : super(key: key);

  @override
  State<DrawerComics> createState() => _DrawerComicsState();
}

class _DrawerComicsState extends State<DrawerComics> {
  @override
  Widget build(BuildContext context) {
    PowComicsProvider provider = PowComicsProvider();
    return Scaffold(
      appBar: AppBar(
        title: Text('Comics'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text('ACTUALIZAR'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: provider.getComics(),
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
                        center: Text("Cargando Comics"),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var colorComic = Colors.black;
                      var iconoComic = MdiIcons.shieldStar;
                      if (snapshot.data[index]['edicion'] == 'Limitada') {
                        colorComic = Colors.amber;
                      }
                      if (snapshot.data[index]['universo'] == 'DC') {
                        iconoComic = MdiIcons.incognito;
                      }
                      return Slidable(
                        child: ListTile(
                          leading: Icon(iconoComic, color: colorComic),
                          title: Text(
                            snapshot.data[index]["nombre_comic"],
                            style: TextStyle(color: colorComic),
                          ),
                          subtitle:
                              Text('${snapshot.data[index]['precio']} CLP'),
                        ),
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                confirmDialog(context,
                                        snapshot.data[index]['nombre_comic'])
                                    .then((confirma) {
                                  if (confirma) {
                                    var nombre =
                                        snapshot.data[index]['nombre_comic'];
                                    setState(() {
                                      provider
                                          .comicsBorrar(
                                              snapshot.data[index]['id'])
                                          .then((borradoExitoso) {
                                        if (!borradoExitoso) {
                                          _showSnackbar(
                                              'Ha ocurrido un problema');
                                        } else {
                                          _showSnackbar(
                                              'El comic $nombre ha sido eliminado');
                                        }
                                      });
                                    });
                                  }
                                });
                              },
                              backgroundColor: Colors.red,
                              icon: MdiIcons.trashCan,
                              label: 'Borrar',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                MaterialPageRoute route = MaterialPageRoute(
                                    builder: (context) => ComicsEditar(
                                          id: snapshot.data[index]['id'],
                                          nombre: snapshot.data[index]
                                              ['nombre_comic'],
                                          universo: snapshot.data[index]
                                              ['universo'],
                                          edicion: snapshot.data[index]
                                              ['edicion'],
                                          precio: snapshot.data[index]
                                              ['precio'],
                                        ));
                                Navigator.push(context, route).then((value) {
                                  setState(() {});
                                });
                              },
                              backgroundColor: Colors.yellow,
                              icon: MdiIcons.pen,
                              label: 'Editar',
                            )
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
                child: Text('Agregar Comic'),
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => ComicsAgregar(),
                  );
                  Navigator.push(context, route).then((value) {
                    setState(() {});
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, String nombre_comic) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmar borrado de comic'),
            content: Text('Borrar el comic $nombre_comic?'),
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
