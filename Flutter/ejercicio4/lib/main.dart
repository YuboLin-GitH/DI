import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}


class MainApp extends StatefulWidget {
  @override
  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  String _texto = "HAHAHA";

  void _incrementCounter() {
    setState(() {
      _texto += "A";
    });
  }

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text('texto dinámico que cambie al presionar un botón')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_texto),
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
