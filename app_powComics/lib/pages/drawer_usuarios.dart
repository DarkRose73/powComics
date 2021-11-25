import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pow_comics/pages/usuarios_agregar.dart';
import 'package:pow_comics/pages/usuarios_editar.dart';
import 'package:pow_comics/provider/powComics_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DrawerUsuarios extends StatefulWidget {
  const DrawerUsuarios({Key? key}) : super(key: key);

  @override
  State<DrawerUsuarios> createState() => _DrawerUsuariosState();
}

class _DrawerUsuariosState extends State<DrawerUsuarios> {
  @override
  Widget build(BuildContext context) {
    PowComicsProvider provider = PowComicsProvider();
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: provider.getUsers(),
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
                    return Slidable(
                      child: ListTile(
                        leading: Icon(Icons.people_alt_outlined),
                        title: Text(snapshot.data[index]['nombre_usuario']),
                      ),
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              confirmDialog(context,
                                      snapshot.data[index]['nombre_usuario'])
                                  .then((confirma) {
                                if (confirma) {
                                  var nombre =
                                      snapshot.data[index]['nombre_usuario'];
                                  setState(() {
                                    provider
                                        .usuariosBorrar(
                                            snapshot.data[index]['rut'])
                                        .then((borradoExitoso) {
                                      if (!borradoExitoso) {
                                        _showSnackbar(
                                            'Ha ocurrido un problema');
                                      } else {
                                        _showSnackbar(
                                            'Usuario $nombre ha sido eliminado');
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
                                builder: (context) => UsuariosEditar(
                                  rut: snapshot.data[index]['rut'],
                                  nombre_usuario: snapshot.data[index]
                                      ['nombre_usuario'],
                                  celular: snapshot.data[index]['celular'],
                                ),
                              );
                              Navigator.push(context, route)
                                  .then((value) => {setState(() {})});
                            },
                            backgroundColor: Color(0xFFB8DB1D),
                            icon: MdiIcons.update,
                            label: 'Editar',
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
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
                child: Text('Agregar Usuario'),
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => UsuariosAgregar(),
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

  Future<dynamic> confirmDialog(BuildContext context, String nombre) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmar borrado de usuario'),
            content: Text('Borrar el usuario $nombre?'),
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
