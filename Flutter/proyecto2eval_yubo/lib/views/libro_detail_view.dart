import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto2eval_yubo/l10n/app_localizations.dart';
import '../models/libro_model.dart';
import '../viewmodels/library_view_model.dart';



/// Pantalla de detalle de un libro específico.
///
/// Muestra información extendida del libro como la portada en grande,
/// sinopsis, autor y permite modificar su estado (leído/favorito).
class LibroDetailScreen extends StatelessWidget {

  /// ID único del libro a mostrar.
  /// Se usa el ID en lugar del objeto completo para garantizar que los datos
  /// estén siempre sincronizados con la base de datos.
  final int libroId; 

  const LibroDetailScreen({super.key, required this.libroId});

  @override
  Widget build(BuildContext context) {

    final libraryVM = context.watch<LibraryViewModel>();
    final l10n = AppLocalizations.of(context)!;
   
    Libro libro;
    try {
      libro = libraryVM.libros.firstWhere((l) => l.id == libroId);
    } catch (e) {
      return  Scaffold(body: Center(child: Text(l10n.noHayLibros)));
    }

    return Scaffold(
      // AppBar transparente para que la imagen de portada llegue hasta arriba
      appBar: AppBar(
        title: Text(l10n.detalle),
        backgroundColor: Colors.transparent, 
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                        label: Text(libro.leido == 1 ? l10n.leidoSingular : l10n.pendienteSingular),
                      ),
                      Chip(
                        avatar: Icon(
                          Icons.favorite,
                          color: libro.gusta == 1 ? Colors.red : Colors.grey,
                        ),
                        label: Text(libro.gusta == 1 ? l10n.favoritoSingular : l10n.normal),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.bookmark_border),
                          title: Text(l10n.marcarLeido),
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
                          title: Text(libro.gusta == 1 ? l10n.quitarFavorito: l10n.anadirFavorito),
                          onTap: () => libraryVM.toggleGusta(libro.id!, libro.gusta),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    l10n.sinopsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    libro.detalle.isNotEmpty 
                        ? libro.detalle 
                        : l10n.noDescripcion,
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