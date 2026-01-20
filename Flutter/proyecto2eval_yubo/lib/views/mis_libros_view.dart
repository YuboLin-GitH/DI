import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto2eval_yubo/providers/db_provider.dart';
//import 'package:proyecto2eval_yubo/providers/theme_provider.dart';



// PANTALLAS Mis libros

/// Pantalla que muestra los libros marcados como favoritos.
class MisLibrosScreen extends StatefulWidget {
  const MisLibrosScreen({super.key});

  @override
  State<MisLibrosScreen> createState() => _MisLibrosScreenState();
}

class _MisLibrosScreenState extends State<MisLibrosScreen> {
 
  @override
  Widget build(BuildContext context) {
    // Obtener datos del proveedor
    final bbddProvider = Provider.of<BBDDProvider>(context);
    final libros = bbddProvider.misLibros;

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Libros")),
    
      body: libros.isEmpty ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("No hay libros en favoritos", 
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 16),
                  Text("Ve a visitar la librería.",
                    style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          :GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
          crossAxisSpacing: 10, // Espaciado izquierdo y derecho
          mainAxisSpacing: 10, // Espaciado superior e inferior
          childAspectRatio: 0.7, // altura
        ),
        itemCount: libros.length,
        itemBuilder: (context, index) {
          final libro = libros[index];
          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: const Center(child: Icon(Icons.book, size: 40)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            libro['titulo'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            libro['autor'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      bbddProvider.toggleGusta(libro['id'], libro['gusta']);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
