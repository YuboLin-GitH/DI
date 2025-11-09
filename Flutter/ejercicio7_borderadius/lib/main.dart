import 'package:flutter/material.dart';


/*
7. Diseña una tarjeta dentro de un Container con un color blanco de fondo, 
bordes y relleno personalizado. Utiliza las propiedades de margin, 
padding y borderRadius de Container para realizarlo.
 */
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      theme: ThemeData(  // tema oscuro
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange,
              

            ),
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child: Card(
              color: Colors.cyanAccent,
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text('Hola ahahahahaha'),
              ),
              
            ),
          ),
            
        ),
      ),
    );
  }
}
