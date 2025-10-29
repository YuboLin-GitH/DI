import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Cartas")),
        backgroundColor: Colors.grey[200],
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            CartaWidget(
              titulo: "Carta 1",
              imagenUrl: "https://placehold.co/600x400.png",
            ),
            CartaWidget(
              titulo: "Carta 2",
              imagenUrl: "https://placehold.co/600x400.png",
            ),
            CartaWidget(
              titulo: "Carta 3",
              imagenUrl: "https://placehold.co/600x400.png",
            ),
          ],
        ),
      ),
    );
  }
}

class CartaWidget extends StatelessWidget {
  final String titulo;
  final String imagenUrl;

  const CartaWidget({super.key, required this.titulo, required this.imagenUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Image.network(imagenUrl, height: 120),
        ],
      ),
    );
  }
}
