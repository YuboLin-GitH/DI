import 'dart:io';
import 'package:path/path.dart' as p; 
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseService {
  // 单例模式
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
    // 针对桌面端的初始化 (Windows/Linux/Mac)
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final databasePath = await getDatabasesPath();
    // 使用 p.join 避免冲突
    final path = p.join(databasePath, 'ejemplo.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tabla_ejemplo (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            valor REAL
          )
        ''');
      },
    );
  }

  // 插入数据
  Future<int> insertValue(double value) async {
    final db = await database;
    return await db.insert('tabla_ejemplo', {'valor': value});
  }

  // 获取最后一条数据
  Future<double?> getLastValue() async {
    final db = await database;
    final result = await db.query(
      'tabla_ejemplo',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first['valor'] as double;
    }
    return null;
  }
}