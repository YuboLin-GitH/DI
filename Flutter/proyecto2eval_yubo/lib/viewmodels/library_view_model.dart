import 'package:flutter/material.dart';
import '../models/libro_model.dart';
import '../services/database_service.dart';




/// ViewModel principal que gestiona la lógica de negocio de la librería.
///
/// Se encarga de comunicar la Vista con la Base de Datos, gestionando
/// el estado de la lista de libros, los filtros y las búsquedas.
class LibraryViewModel extends ChangeNotifier {
  List<Libro> _libros = [];

  String _filtroEstado = 'todos';   // todos, leido, pendiente
  String _filtroFavorito = 'todos'; //  todos, favoritos

  String _busqueda = ''; 
  String get busqueda => _busqueda;

  /// Devuelve la lista completa de libros sin filtrar.
  List<Libro> get libros => _libros;

  /// Devuelve el filtro de estado actual.
  String get filtroEstado => _filtroEstado;

  /// Devuelve el filtro de favoritos actual.
  String get filtroFavorito => _filtroFavorito;




  /// Devuelve la lista de libros filtrada según el estado, favoritos y búsqueda.
  ///
  /// Aplica lógica AND: deben cumplirse todas las condiciones.
  List<Libro> get librosFiltrados {
    return _libros.where((libro) {
      // Determinar el estado de lectura
      bool coincideEstado = true;
      if (_filtroEstado == 'leido') {
        coincideEstado = (libro.leido == 1);
      } else if (_filtroEstado == 'pendiente') {
        coincideEstado = (libro.leido == 0);
      }

      // Determinar si se debe guardar
      bool coincideFavorito = true;
      if (_filtroFavorito == 'favoritos') {
        coincideFavorito = (libro.gusta == 1);
      }

      bool coincideBusqueda = true;
      if (_busqueda.isNotEmpty) {
        final query = _busqueda.toLowerCase(); // Convierte a minúsculas para lograr acceso indiscriminado entre mayúsculas y minúsculas.
        coincideBusqueda = libro.titulo.toLowerCase().contains(query) ||
                           libro.autor.toLowerCase().contains(query);
      }


      //Este libro solo se mostrará si se cumplen ambas condiciones.
      return coincideEstado && coincideFavorito && coincideBusqueda;
    }).toList();
  }

// Obtener la lista de favoritos
  List<Libro> get misLibros => _libros.where((l) => l.gusta == 1).toList();

  LibraryViewModel() {
    loadLibros();
  }

  // Métodos para establecer el estado
  void setFiltroEstado(String filtro) {
    _filtroEstado = filtro;
    notifyListeners();
  }

  // Establecer método favorito
  void setFiltroFavorito(String filtro) {
    _filtroFavorito = filtro;
    notifyListeners();
  }

  /// Establece el texto de búsqueda y notifica a la vista.
  void setBusqueda(String query) {
    _busqueda = query;
    notifyListeners();
  }


  Future<void> loadLibros() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query('libro');
   // Convierte la lista de mapas en una lista de objetos de Libra
    _libros = maps.map((map) => Libro.fromMap(map)).toList();
    notifyListeners();
  }

  /// Añade un nuevo libro a la base de datos y recarga la lista.
  Future<void> addLibro(String titulo, String autor, String portada, String detalle) async {
    final db = await DatabaseService().database;
    final nuevoLibro = Libro(titulo: titulo, autor: autor, portada: portada, detalle: detalle);
    await db.insert('libro', nuevoLibro.toMap()); 
    await loadLibros();
  }



  Future<void> deleteLibro(int id) async {
    final db = await DatabaseService().database;
    await db.delete('libro', where: 'id = ?', whereArgs: [id]);
    await loadLibros();
  }

  Future<void> toggleGusta(int id, int estadoActual) async {
    final db = await DatabaseService().database;
    await db.update(
      'libro',
      {'gusta': estadoActual == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    await loadLibros();
  }

  Future<void> toggleLeido(int id, int estadoActual) async {
    final db = await DatabaseService().database;
    await db.update(
      'libro',
      {'leido': estadoActual == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    await loadLibros();
  }



Future<void> addDatosDePrueba() async {
    final List<Map<String, String>> librosEjemplo = [
      {
        "titulo": "EL JARDÍN DORMIDO",
        "autor": "Carla Gracia",
        "portada": "https://imagessl8.casadellibro.com/a/l/s7/78/9788467079678.webp",
        "detalle":"Cada flor guarda un secreto. Cada jardín, una segunda oportunidad. Brillante, sensible y profundamente humana. Carla Gracia irrumpe en el panorama literario con una novela que cautiva los sentidos y deja una huella en el corazón."
      },
      {
        "titulo": "EL PRIMER HOMBRE MALO",
        "autor": "Miranda July",
        "portada": "https://imagessl9.casadellibro.com/a/l/s7/09/9788466379809.webp",
        "detalle":"Un debut novelístico deslumbrante que te desconcertará, por una de las voces más originales del panorama actual, un icono del indie americano: Miranda July."
      },
      {
        "titulo": "LA TIERRA HERIDA",
        "autor": "Clare Leslie Hall",
        "portada": "https://imagessl7.casadellibro.com/a/l/s7/27/9788408309727.webp",
        "detalle":"Un fenómeno internacional imparable en 35 países. «Apunta directamente al corazón y da en el blanco». Delia Owens, autora de La chica salvaje."
      },
      {
        "titulo": "EL NOVIO",
        "autor": "Freida McFadden",
        "portada": "https://imagessl9.casadellibro.com/a/l/s7/19/9788410257719.webp",
        "detalle":"La autora de La asistenta vuelve con una oscura historia sobre la obsesión y las cosas que hacemos por amor. Ella busca al hombre perfecto. Él busca a la víctima perfecta."
      },
      {
        "titulo": "LA ÚLTIMA CANCIÓN DE AMOR",
        "autor": "Lucinda Riley",
        "portada": "https://imagessl6.casadellibro.com/a/l/s7/96/9788401027796.webp",
        "detalle":"Una estrella del rock desaparecida y un misterio oculto durante dos décadas, en la nueva novela de la autora best seller de la saga Las Siete Hermanas."
      },
    ];

    for (var libro in librosEjemplo) {
      await addLibro(libro["titulo"]!, libro["autor"]!, libro["portada"]!, libro["detalle"] ?? "Sin descripción disponible.");
    }
    
  }

  
}