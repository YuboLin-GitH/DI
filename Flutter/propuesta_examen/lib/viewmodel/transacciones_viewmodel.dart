import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:propuesta_examen/models/transacciones_model.dart';

/// Servicio Singleton para gestionar la conexión y operaciones con SQLite.
class DatabaseService {
  /// Instancia única de la clase (Singleton).
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  /// Constructor privado.
  DatabaseService._init();

  /// Obtiene la referencia a la base de datos. Si no existe, la inicializa.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("conversor.db");
    return _database!;
  }

  /// Inicializa la base de datos configurando FFI si es necesario (Escritorio).
  Future<Database> _initDB(String filePath) async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Crea la tabla de transacciones al crear la base de datos por primera vez.
  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      inputValue REAL,
      inputUnit TEXT,
      outputUnit TEXT,
      result REAL
    )
    ''');
  }

  /// Inserta una nueva transacción en la base de datos.
  Future<int> insertTransaction(TransaccionesModel transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  /// Recupera todas las transacciones ordenadas por ID descendente.
  Future<List<TransaccionesModel>> getAllTransactions() async {
    final db = await instance.database;
    final result = await db.query('transactions', orderBy: 'id DESC');
    return result.map((json) => TransaccionesModel.fromMap(json)).toList();
  }

  /// Elimina una transacción por su ID.
  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}