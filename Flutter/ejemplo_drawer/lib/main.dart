import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('App con Drawer')),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Encabezado del Drawer'),
              ),
              ListTile(leading: Icon(Icons.message),title: Text('Elemento 1'), onTap: () {}),
              ListTile(leading: Icon(Icons.zoom_in),title: Text('Elemento 2'), onTap: () {}),
            ],
          ),
        ),
        body: Center(child: Text('Pantalla principal')),
      ),
    );
  }
}
