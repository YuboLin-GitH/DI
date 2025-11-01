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
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              

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
