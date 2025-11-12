import 'package:flutter/material.dart';

/*EJERCICIO 9: Crea una interfaz de perfil donde uses Stack para
superponer una imagen de fondo con un avatar redondeado y un botón
de edición sobre la imagen.
Usa los widgets Stack, Positioned, Image, CircleAvatar y Button*/

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
             Positioned(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // CONTENEDOR CIRCULAR
                  border: Border.all(
                    color: Colors.black, // COLOR BORDE
                    width: 2, // GROSOR DEL BORDE
                  )
                ),
                child: CircleAvatar(
                  radius: 100, // Ajusta el radio para que coincida con el tamaño deseado
                  backgroundColor: Colors.black, // El color de fondo del círculo
                  backgroundImage: NetworkImage('https://i.pinimg.com/236x/70/85/54/7085548f3d0372a08aea0291ddcee895.jpg'), // Imagen de fondo
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
