import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Ejercicio4Page(), 
    );
  }
}

class Ejercicio4Page extends StatefulWidget {
  @override
  _Ejercicio4PageState createState() => _Ejercicio4PageState();
}

class _Ejercicio4PageState extends State<Ejercicio4Page> {
 
  String _accessibilityHint = 'Por favor, empieza a escribir tu nombre';
  
  String _currentText = '';


  void _updateHint(String text) {
    setState(() {
      _currentText = text;
      
      if (text.isEmpty) {
        _accessibilityHint = 'Por favor, empieza a escribir tu nombre';
      } else {
        _accessibilityHint = 'ya has escrito: $text. Sigue así.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio 4: Hints Dinámicos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Semantics(

              hint: _accessibilityHint,
              label: 'Campo de nombre',

              value: _currentText,
              
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),

                onChanged: (value) {
                  _updateHint(value);
                },
              ),
            ),
            
            Text( _currentText.isEmpty ? 'Escribe nombre' : 'Has escribido algo'),
          ],
        ),
      ),
    );
  }
}