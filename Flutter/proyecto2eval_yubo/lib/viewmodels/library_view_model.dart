import 'package:flutter/material.dart';
import '../models/libro_model.dart';
import '../services/database_service.dart';

class LibraryViewModel extends ChangeNotifier {
  List<Libro> _libros = [];

  String _filtroEstado = 'todos';   // 选项: todos, leido, pendiente
  String _filtroFavorito = 'todos'; // 选项: todos, favoritos

  List<Libro> get libros => _libros;
  String get filtroEstado => _filtroEstado;
  String get filtroFavorito => _filtroFavorito;




// Obtener la lista después del filtrado
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

      //Este libro solo se mostrará si se cumplen ambas condiciones.
      return coincideEstado && coincideFavorito;
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

  Future<void> loadLibros() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query('libro');
   // Convierte la lista de mapas en una lista de objetos de Libra
    _libros = maps.map((map) => Libro.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addLibro(String titulo, String autor, String portada) async {
    final db = await DatabaseService().database;
    final nuevoLibro = Libro(titulo: titulo, autor: autor, portada: portada);
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
}