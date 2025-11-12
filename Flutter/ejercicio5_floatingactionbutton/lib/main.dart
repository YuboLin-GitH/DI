import 'package:flutter/material.dart';

/*Ejercicio 5: Crea una aplicación básica con un Scaffold que contenga una AppBar,
un cuerpo de texto y un FloatingActionButton.
Se incrementara un contador*/
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
        appBar: AppBar(title: Text('Botón flotante')),
        body: const Center(child: Text('Hello World!')
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Hola munto');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
