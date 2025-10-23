import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Contador simple')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Presiona el botón: $_counter veces'),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Botón +1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
