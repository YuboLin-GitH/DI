import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text('jerarquía de Widgets')),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            Text('Texto 1'),
            Container(
              color: Colors.red,
              padding: EdgeInsets.all(10),
              child:Center(
                child: Text('Este texto2'),
              )
              
            ),
            ElevatedButton(
              onPressed: () {
                print('HAHAHA');
              },
              child: Text('Soy boton'),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 80,
          child: Center(
            child: Text("Abajo de todo"),
          ),
        ),
      ),
    );
  }
}
