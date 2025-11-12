import 'package:flutter/material.dart';

/*EJERCICIO 6:  Crea una pantalla que utilice Text, Column y Row
para organizar el contenido.
 • El Column debe alinear dos textos verticalmente, y el Row alinear dos botones
horizontalmente*/

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text('Titulo de ejecicio6')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Texto superior', style: TextStyle(fontSize: 24)),
              Text('Texto inferior', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              
              // AÑADIR UN MARGEN ENTRE COLUMNA Y FILA
              const Padding(padding: EdgeInsets.only(
                top: 40, bottom: 40,
              )),

              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: () {}, child: Text('Botón1')),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () {}, child: Text('Botón2')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
