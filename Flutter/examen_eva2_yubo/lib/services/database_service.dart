import 'package:examen_eva2_yubo/model/libroModel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

/// Servicio singleton para manejar la base de datos SQLite.
/// Cumple con el requisito: "Crea un servicio de base de datos para reutilizar código".
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'libreria.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Crear tabla de transacciones
        await db.execute('''
          CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            genre TEXT,
            status INTEGER NOT NULL DEFAULT 0,
            date TEXT
          );
          INSERT INTO books (title, author, genre, status, date)
          VALUES
          ('title1', 'author1', 'genre1', 0, '20/1/2000'),
          ('title2', 'author2', 'genre2', 0, '20/1/2000'),
          ('title3', 'author3', 'genre3', 1, '20/1/2000'),
          ('title4', 'author4', 'genre4', 0, '20/1/2000');
        ''');
      },
    );
  }


  /// Inserta una nuevo libro en la BBDD.
  Future<int> insertLibro(Libromodel libro) async {
    final db = await database;
    // 直接调用 libro.toMap()，简单干净！
    return db.insert('books', libro.toMap());
  }


  /// Obtiene todas los libros ordenadas por ID descendente (más recientes primero).
  Future<List<Libromodel>> getLibros() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books', orderBy: 'id DESC');

    // 把 Map 列表转换成 Libromodel 列表
    return List.generate(maps.length, (i) {
      return Libromodel.fromMap(maps[i]);
    });
  }

  /// Elimina una libros por su ID.
  Future<void> deleteLibros(int id) async {
    final db = await database;
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  
  
}