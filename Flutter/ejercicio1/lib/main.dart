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
      title: 'Ejercicio 1 Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejercicio 1'),
        ),
        body: Center(
          child: Text('bienvenida'),
        ),
      ),
    );
  }
}
