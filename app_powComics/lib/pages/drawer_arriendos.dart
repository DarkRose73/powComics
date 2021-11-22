import 'package:flutter/material.dart';

class DrawerArriendos extends StatefulWidget {
  const DrawerArriendos({Key? key}) : super(key: key);

  @override
  State<DrawerArriendos> createState() => _DrawerArriendosState();
}

class _DrawerArriendosState extends State<DrawerArriendos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arriendos'),
      ),
    );
  }
}
