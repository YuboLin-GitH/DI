import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PantallaA(),
    );
  }
}

class PantallaA extends StatelessWidget{
  const PantallaA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla A"),),
      body: Center(
        child: ElevatedButton(onPressed:(){ 
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PantallaB()),
          );
        }, child: Text("Ir al Pantalla B")),
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