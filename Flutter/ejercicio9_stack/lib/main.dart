import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        body: Stack(
          children: [
            Image.network(
              'https://placehold.co/600x300.png',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 32,
              bottom: 32,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://placehold.co/600x400/000000/FFFFFF.png',
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: 40,
              child: IconButton(
                icon: Icon(Icons.edit, size: 32, color: Colors.blue),
                onPressed: () {},
                tooltip: 'editar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
