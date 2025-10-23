import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text('Hello World App - Windows')),
        body: Center(
          child: Column(
            children: [
              Text(
                'Hello, World!',
                style: TextStyle(
                  color: const Color.fromARGB(255, 173, 96, 96),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Open Sans',
                  fontSize: 24,
                ),
              ),
              Text('Hello, World!', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
