import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      '/': (context) => PantallaA(), 
      '/b': (context) => PantallaDosClick(),
      '/c': (context) => PantallaDerecha(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class PantallaA extends StatelessWidget {
  const PantallaA({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/b': (context) => PantallaDosClick(),},
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onDoubleTap: () {
              Navigator.pushNamed(context, '/b');
            },
            onHorizontalDragEnd: (d) {
              Navigator.pushNamed(context, '/c');
            },

            child: Container(
              color: Colors.blue,
              height: 100,
              width: 100,
              child: Center(child: Text('Toca aquí')),
            ),


          ),
        ),
      ),
    );
  }
}


class PantallaDosClick extends StatelessWidget {
  const PantallaDosClick({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla B")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Volver a Pantalla A"),
        ),
      ),
    );
  }
}


class PantallaDerecha extends StatelessWidget {
  const PantallaDerecha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla derecho")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Volver a Pantalla A"),
        ),
      ),
    );
  }
}
