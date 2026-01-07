import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:proyecto2eval_yubo/main.dart'; 


void main() {
  late Database database;
  late BBDDProvider provider;

  // iniciar SQLite FFI para Windows
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  // Cree una base de datos antes de cada prueba.
  setUp(() async {
    database = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await database.execute('''
      CREATE TABLE libro (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        autor TEXT NOT NULL,
        leido INTEGER NOT NULL DEFAULT 0,
        gusta INTEGER NOT NULL DEFAULT 0
      )
    ''');

    provider = BBDDProvider(database: database);
  });

  tearDown(() async {
    await database.close();
  });

  test('Añadir un libro incrementa la lista de libros', () async {
    await provider.addLibro('El Quijote', 'Cervantes');

    expect(provider.todoLibros.length, 1);
    expect(provider.todoLibros.first['titulo'], 'El Quijote');
  });

  test('Marcar libro como favorito lo añade a Mis Libros', () async {
    await provider.addLibro('1984', 'George Orwell');

    final libro = provider.todoLibros.first;
    await provider.toggleGusta(libro['id'], libro['gusta']);

    expect(provider.misLibros.length, 1);
  });

  test('Cambiar estado de leído funciona correctamente', () async {
    await provider.addLibro('Clean Code', 'Robert C. Martin');

    final libro = provider.todoLibros.first;
    await provider.toggleLeido(libro['id'], libro['leido']);

    final actualizado = provider.todoLibros.first;
    expect(actualizado['leido'], 1);
  });

  test('Eliminar libro lo quita de la base de datos', () async {
    await provider.addLibro('Flutter in Action', 'Eric Windmill');

    final libro = provider.todoLibros.first;
    await provider.deleteLibro(libro['id']);

    expect(provider.todoLibros.isEmpty, true);
  });
}
