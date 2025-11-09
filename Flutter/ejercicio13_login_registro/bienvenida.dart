import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantalla de Bienvenida',
      theme: ThemeData(primarySwatch: Colors.blue),
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
              'Esta es una aplicación de ejemplo para demostrar una pantalla de bienvenida en Flutter. Aquí puedes encontrar un texto largo para probar el desplazamiento con SingleChildScrollView.\n\n'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;'
              ' Etiam at eros vel justo bibendum tincidunt. Pellentesque ultricies posuere felis, ac ultrices felis maximus a.\n\n'
              'Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices. Suspendisse in justo eu magna luctus suscipit. Sed lectus. Integer euismod lacus luctus magna.'
              '\n\nMucho texto para comprobar el scroll...' * 5,
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
