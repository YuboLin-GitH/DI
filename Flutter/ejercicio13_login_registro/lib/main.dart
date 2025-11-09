import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BienvenidaScreen(),
    );
  }
}

class BienvenidaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Center(
              child: Text(
                '¡Bienvenido a mi App!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Esta es una aplicación de ejemplo para demostrar una pantalla de bienvenida en Flutter. Aquí puedes encontrar un texto largo para probar el desplazamiento con SingleChildScrollView.\n'
              'Lorem ipsum dolor sit amet...'
              'Mucho texto para comprobar el scroll...' * 5,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 36),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                child: Text('Registro'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
