// PANTALLAS Libreria

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto2eval_yubo/providers/db_provider.dart';
/// Pantalla principal de la librería.
///
/// Muestra todos los libros almacenados y permite:
/// - Marcar favoritos
/// - Cambiar estado de lectura
/// - Eliminar libros
/// - Añadir nuevos libros


class LibreriaScreen extends StatefulWidget {
  const LibreriaScreen({super.key});

  @override
  State<LibreriaScreen> createState() => _LibreriaScreenState();
}

class _LibreriaScreenState extends State<LibreriaScreen> {
  @override
  Widget build(BuildContext context) {
    final bbddProvider = Provider.of<BBDDProvider>(context);
    final libros = bbddProvider.todoLibros;

    return Scaffold(
      appBar: AppBar(title: Text("Librería")),
      body: libros.isEmpty
          ? Center(child: Text("No hay libro"))
          : ListView.builder(
              itemCount: libros.length,
              itemBuilder: (context, index) {
                final libro = libros[index];
                return ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(libro['titulo']),
                  subtitle: Text(libro['autor']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          libro['gusta'] == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: libro['gusta'] == 1 ? Colors.red : null,
                        ),
                        onPressed: () {
                          bbddProvider.toggleGusta(libro['id'], libro['gusta']);
                        },
                      ),

                      const SizedBox(width: 10),

                      DropdownButton(
                      
                        items: const [
                          DropdownMenuItem(
                            value: 'pendiente',
                            child: Text('Pendiente'),
                          ),
                          DropdownMenuItem(
                            value: 'leido',
                            child: Text('Leído'),
                          ),
                        ],
                        onChanged: (value) {
                          // Cambio de estado del proveedor
                          bbddProvider.toggleLeido(libro['id'], libro['leido']);
                        },
                        value: libro['leido'] == 1 ? 'leido' : 'pendiente',
                      ),

                      const SizedBox(width: 10),

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => bbddProvider.deleteLibro(libro['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _mostrarFormulario(context, bbddProvider);
        },
        icon: const Icon(Icons.add),
        label: const Text("Añadir Libro"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }

  /// Muestra un diálogo emergente para introducir los datos de un nuevo libro.
  void _mostrarFormulario(BuildContext context, BBDDProvider provider) {
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController autorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Añadir nuevo libro"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: autorController,
              decoration: const InputDecoration(labelText: "Autor"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () {
              // Validación simple: ambos campos deben tener texto
              if (tituloController.text.isNotEmpty &&autorController.text.isNotEmpty) {
                provider.addLibro(tituloController.text, autorController.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
