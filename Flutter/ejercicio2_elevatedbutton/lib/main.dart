import 'package:flutter/material.dart';


/*Crea una aplicación que siga una jerarquía simple de widgets utilizando un
Column que tenga varios Text y un Button (ElevatedButton)
 • Haz que, al pulsar el botón, muestre un mensaje en la consola.*/

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
// DEFINIMOS EL ESTILO DEL TEXTO PARA REUTILIZAR
  final TextStyle textStyle = const TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text('jerarquía de Widgets')),

        body: Column(
            // LO CENTRAMOS
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Texto 1'),
            const SizedBox(height: 10), // AÑADIR ESPACIO
            Container(
              color: Colors.red,
              padding: EdgeInsets.all(10),
              child:Center(
                child: Text('Este texto2'),
              )
              
            ),
            const SizedBox(height: 10), // AÑADIR ESPACIO
            ElevatedButton(
              onPressed: () {
                print('HAHAHA');
              },
              child: Text('Soy boton', style: textStyle),
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
