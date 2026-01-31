import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/libro_model.dart';
import '../viewmodels/library_view_model.dart';

class LibroDetailScreen extends StatelessWidget {
  final int libroId; 

  const LibroDetailScreen({super.key, required this.libroId});

  @override
  Widget build(BuildContext context) {

    final libraryVM = context.watch<LibraryViewModel>();
    
   
    Libro libro;
    try {
      libro = libraryVM.libros.firstWhere((l) => l.id == libroId);
    } catch (e) {
      return const Scaffold(body: Center(child: Text("Libro no encontrado")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles"),
        backgroundColor: Colors.transparent, 
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. 顶部大图封面
            Hero(
              tag: "cover_${libro.id}", 
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(libro.portada),
                    fit: BoxFit.cover,
                    onError: (e, s) {}, 
                  ),
                  color: Colors.grey[800],
                ),
                child: libro.portada.isEmpty 
                  ? const Icon(Icons.book, size: 80, color: Colors.white54)
                  : null,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    libro.titulo,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    libro.autor,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),


                  Wrap(
                    spacing: 10,
                    children: [
                      Chip(
                        avatar: Icon(
                          libro.leido == 1 ? Icons.check_circle : Icons.hourglass_empty,
                          color: libro.leido == 1 ? Colors.green : Colors.orange,
                        ),
                        label: Text(libro.leido == 1 ? "Leído" : "Pendiente"),
                      ),
                      Chip(
                        avatar: Icon(
                          Icons.favorite,
                          color: libro.gusta == 1 ? Colors.red : Colors.grey,
                        ),
                        label: Text(libro.gusta == 1 ? "Favorito" : "Normal"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.bookmark_border),
                          title: const Text("Marcar como Leído/Pendiente"),
                          trailing: Switch(
                            value: libro.leido == 1,
                            onChanged: (_) => libraryVM.toggleLeido(libro.id!, libro.leido),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(
                            libro.gusta == 1 ? Icons.favorite : Icons.favorite_border,
                            color: libro.gusta == 1 ? Colors.red : null,
                          ),
                          title: Text(libro.gusta == 1 ? "Quitar de Favoritos" : "Añadir a Favoritos"),
                          onTap: () => libraryVM.toggleGusta(libro.id!, libro.gusta),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  const Text(
                    "Sinopsis",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    libro.detalle.isNotEmpty 
                        ? libro.detalle 
                        : "No hay descripción disponible para este libro.",
                    style: const TextStyle(
                      height: 1.5, 
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}