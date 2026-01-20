import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class BBDDProvider extends ChangeNotifier {
  final Database database;

  List<Map<String, dynamic>> _todoLibros = [];
  List<Map<String, dynamic>> _misLibros = [];

  List<Map<String, dynamic>> get todoLibros => _todoLibros;
  List<Map<String, dynamic>> get misLibros => _misLibros;

  BBDDProvider({required this.database}) {
    loadLibros();
  }

  Future<void> loadLibros() async {
    _todoLibros = await database.query('libro');
    _misLibros = await database.query(
      'libro',
      where: 'gusta = ?',
      whereArgs: [1],
    );
    notifyListeners();
  }

  Future<void> addLibro(String titulo, String autor) async {
    await database.insert('libro', {'titulo': titulo, 'autor': autor});
    await loadLibros();
  }

  Future<void> deleteLibro(int id) async {
    await database.delete('libro', where: 'id = ?', whereArgs: [id]);
    await loadLibros();
  }

  Future<void> toggleGusta(int id, int estadoGusta) async {
    await database.update(
      'libro',
      {'gusta': estadoGusta == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    await loadLibros();
  }

  Future<void> toggleLeido(int id, int estadoLeido) async {
    await database.update(
      'libro',
      {'leido': estadoLeido == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    await loadLibros();
  }
}