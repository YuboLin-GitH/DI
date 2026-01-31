import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto2eval_yubo/l10n/app_localizations.dart';
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

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final libraryVM = Provider.of<LibraryViewModel>(context);
    final libros = libraryVM.librosFiltrados;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.playlist_add_circle, color: Colors.white, size: 30),
          tooltip: l10n.cargarPrueba,
          onPressed: () async {
            bool? confirmar = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(l10n.cargarPrueba),
                content: Text(l10n.cargarPruebaDesc),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child:  Text(l10n.cancelar),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child:  Text(l10n.cargar),
                  ),
                ],
              ),
            );

            if (confirmar == true) {
              await libraryVM.addDatosDePrueba();
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(l10n.exitoCarga)),
              );
            }
          },
        ),
        
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true, 
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: l10n.buscar, 
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Búsqueda en tiempo real
                  libraryVM.setBusqueda(value);
                },
              )
            : Text(l10n.libreria),
        
        
        actions: [

          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  // Si actualmente está buscando, al hacer clic aquí se cerrará la ventana de búsqueda.
                  _isSearching = false;
                  _searchController.clear(); 
                  libraryVM.setBusqueda(''); 
                } else {
                  // Habilitar el modo de búsqueda
                  _isSearching = true;
                }
              });
            },
          ),
          const SizedBox(width: 20),
          if (!_isSearching) ...[
          // Estado de filtrado para proveedores vinculados
          DropdownButton<String>(
            value: libraryVM.filtroEstado,
            dropdownColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.filter_list, color: Colors.white),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            underline: Container(), 
            items: [
              DropdownMenuItem(value: 'todos', child: Text(l10n.todos)),
              DropdownMenuItem(value: 'leido', child: Text(l10n.leidos)),
              DropdownMenuItem(value: 'pendiente', child: Text(l10n.pendientes)),
            ],
            onChanged: (val) {
              if (val != null) libraryVM.setFiltroEstado(val);
            },
          ),

          const SizedBox(width: 15),

          DropdownButton<String>(
            value: libraryVM.filtroFavorito,
            dropdownColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.favorite, color: Colors.redAccent), 
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            underline: Container(),
            items:  [
              DropdownMenuItem(value: 'todos', child: Text(l10n.todos)),
              DropdownMenuItem(value: 'favoritos', child: Text(l10n.favoritos)),
            ],
            onChanged: (val) {
              if (val != null) libraryVM.setFiltroFavorito(val);
            },
          ),
          
          const SizedBox(width: 15),
          ]
        ],
      ),
      body: libros.isEmpty
          ? Center(child: Text(l10n.noHayLibros))
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
                      // Estado de extracción
                      DropdownButton<String>(
                        value: libro.leido == 1 ? 'leido' : 'pendiente',
                        items: [
                          DropdownMenuItem(
                            value: 'pendiente',
                            child: Text(l10n.pendienteSingular),
                          ),
                          DropdownMenuItem(
                            value: 'leido',
                            child: Text(l10n.leidoSingular),
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
        icon:  Icon(Icons.add),
        label: Text(l10n.anadirLibro),
      ),
    );
  }

  void _mostrarFormulario(BuildContext context, LibraryViewModel vm) {

    final l10n = AppLocalizations.of(context)!;

    final TextEditingController tituloController = TextEditingController();
    final TextEditingController autorController = TextEditingController();
    final TextEditingController portadaController = TextEditingController();
    final TextEditingController detalleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.anadirLibro),
              content: SizedBox(
                width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  // Entrada de título 
                    TextField(
                      controller: tituloController,
                      decoration: InputDecoration(
                        labelText: l10n.titulo,
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                  // Entrada del autor
                    TextField(
                      controller: autorController,
                      decoration: InputDecoration(
                        labelText: l10n.autor,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    //  Ingrese el enlace de la portada (con oyente)
                    TextField(
                      controller: portadaController,
                      decoration: InputDecoration(
                        labelText: l10n.portadaUrl,
                        hintText: "https://ejemplo.com/foto.jpg",
                        prefixIcon: Icon(Icons.image),
                        border: OutlineInputBorder(),
                      ),
                    // Actualice la interfaz para mostrar una imagen de vista previa mientras el usuario escribe.  
                      onChanged: (value) {
                        setState(() {}); 
                      },
                    ),
                    

                    const SizedBox(height: 10),

  
                    TextField(
                      controller: detalleController,
                      maxLines: 3, 
                      decoration: InputDecoration(
                        labelText: l10n.sinopsis,
                        alignLabelWithHint: true, 
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
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
                  child: Text(l10n.cancelar),
                ),
                FilledButton(
                  onPressed: () {
                    if (tituloController.text.isNotEmpty && autorController.text.isNotEmpty) {
                      vm.addLibro(
                        tituloController.text, 
                        autorController.text,
                        portadaController.text, //Enviar el enlace de la imagen
                        detalleController.text
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(l10n.guardar),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
