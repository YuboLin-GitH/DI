import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/': (context) => PantallaA(), '/b': (context) => PantallaB(),},
      debugShowCheckedModeBanner: false,
    );
  }
}

class PantallaA extends StatelessWidget {
  const PantallaA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla A")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("PantallaA"),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/b');
            },
            child: Text("B"),
          ),
        ],
      ),
    );
  }
}

class PantallaB extends StatelessWidget {
  const PantallaB({super.key});

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
