import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto2eval_yubo/viewmodels/library_view_model.dart';
import 'libro_detail_view.dart';


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
    final libraryVM = Provider.of<LibraryViewModel>(context);
    final libros = libraryVM.misLibros;

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
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, 
          childAspectRatio: 0.7,   
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: libros.length,
        itemBuilder: (context, index) {
          final libro = libros[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LibroDetailScreen(libroId: libro.id!),
                ),
              );
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: "cover_${libro.id}",
                      child: libro.portada.isNotEmpty
                          ? Image.network(
                              libro.portada, 
                              fit: BoxFit.cover, // La imagen llena el espacio de arriba
                             // Si el enlace no es válido, muestra un marcador de error.
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.blueGrey[100],
                                child:  Icon(Icons.broken_image, size: 50),
                                ),
                            )
                          : Container(
                              color: Colors.blueGrey[100],
                              child: const Icon(Icons.book, size: 50),
                            ),
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                        Text(libro.titulo, 
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(libro.autor, 
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                      ),
                  ],
                
                ),
            
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      libraryVM.toggleGusta(libro.id!, libro.gusta);
                    },
                  ),
                ),
              ],
            ),
          
          )
          );
          
        },
      ),
    );
  }
}
