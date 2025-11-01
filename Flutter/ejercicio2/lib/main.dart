import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text('jerarquía de Widgets')),
        body: Column(
          children: <Widget>[
            Text('Texto 1'),
            Container(
              color: Colors.red,
              padding: EdgeInsets.all(10),
              child: Text('Este texto2'),
            ),
            ElevatedButton(onPressed:(){
                print('HAHAHA');
            }, child: Text('Soy boton')),
          ],
        ),
      ),
    );
  }
}
