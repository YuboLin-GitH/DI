import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto2eval_yubo/viewmodels/library_view_model.dart';

// PANTALLAS Libreria

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
    final libraryVM = Provider.of<LibraryViewModel>(context);
// Utilice el nuevo getter que escribimos en el proveedor
    final libros = libraryVM.librosFiltrados;

    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Librería"),
        actions: [
          // Estado de filtrado para proveedores vinculados
          DropdownButton<String>(
            value: libraryVM.filtroEstado,
            dropdownColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.filter_list, color: Colors.white),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            underline: Container(), 
            items: const [
              DropdownMenuItem(value: 'todos', child: Text('Todos')),
              DropdownMenuItem(value: 'leido', child: Text('Leídos')),
              DropdownMenuItem(value: 'pendiente', child: Text('Pendientes')),
            ],
            onChanged: (val) {
              if (val != null) libraryVM.setFiltroEstado(val);
            },
          ),

          const SizedBox(width: 10),

          DropdownButton<String>(
            value: libraryVM.filtroFavorito,
            dropdownColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.favorite, color: Colors.redAccent), 
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            underline: Container(),
            items: const [
              DropdownMenuItem(value: 'todos', child: Text('Todos')),
              DropdownMenuItem(value: 'favoritos', child: Text('Favoritos')),
            ],
            onChanged: (val) {
              if (val != null) libraryVM.setFiltroFavorito(val);
            },
          ),
          
          const SizedBox(width: 15),

        ],
      ),
      body: libros.isEmpty
          ? const Center(child: Text("No hay libros"))
          : ListView.builder(
              itemCount: libros.length,
              itemBuilder: (context, index) {
                final libro = libros[index];
                return ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(libro.titulo), 
                  subtitle: Text(libro.autor),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     // Botón favorito
                      IconButton(
                        icon: Icon(
                          libro.gusta == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: libro.gusta == 1 ? Colors.red : null,
                        ),
                        onPressed: () {
                          //valores nulos porque id es un int.
                          if (libro.id != null) {
                            libraryVM.toggleGusta(libro.id!, libro.gusta);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      // 状态下拉
                      DropdownButton<String>(
                        value: libro.leido == 1 ? 'leido' : 'pendiente',
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
                          if (libro.id != null) {
                            libraryVM.toggleLeido(libro.id!, libro.leido);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      // Botón eliminar
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          if (libro.id != null) {
                            libraryVM.deleteLibro(libro.id!);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormulario(context, libraryVM),
        icon: const Icon(Icons.add),
        label: const Text("Añadir Libro"),
      ),
    );
  }

  void _mostrarFormulario(BuildContext context, LibraryViewModel vm) {
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController autorController = TextEditingController();
    final TextEditingController portadaController = TextEditingController();


    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Añadir nuevo libro"),
              content: SizedBox(
                width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  // Entrada de título 
                    TextField(
                      controller: tituloController,
                      decoration: const InputDecoration(
                        labelText: "Título",
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                  // Entrada del autor
                    TextField(
                      controller: autorController,
                      decoration: const InputDecoration(
                        labelText: "Autor",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    //  Ingrese el enlace de la portada (con oyente)
                    TextField(
                      controller: portadaController,
                      decoration: const InputDecoration(
                        labelText: "URL de Portada (Imagen)",
                        hintText: "https://ejemplo.com/foto.jpg",
                        prefixIcon: Icon(Icons.image),
                        border: OutlineInputBorder(),
                      ),
                    // Actualice la interfaz para mostrar una imagen de vista previa mientras el usuario escribe.  
                      onChanged: (value) {
                        setState(() {}); 
                      },
                    ),
                    
                    const SizedBox(height: 15),

                   // Área de vista previa de la imagen
                    Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: portadaController.text.isNotEmpty
                          ? Image.network(
                              portadaController.text,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.broken_image, color: Colors.red),
                                  Text("Error URL", style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image_search, size: 40, color: Colors.grey),
                                Text("Sin imagen", style: TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                    ),
                  ],
                ),
              ),),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                FilledButton(
                  onPressed: () {
                    if (tituloController.text.isNotEmpty && autorController.text.isNotEmpty) {
                      vm.addLibro(
                        tituloController.text, 
                        autorController.text,
                        portadaController.text //Enviar el enlace de la imagen
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Guardar"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
