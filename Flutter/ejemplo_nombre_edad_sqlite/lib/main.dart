import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() async {
  // Inicializar sqflite para escritorio
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  // Ruta para la base de datos
  final dbPath = join(await databaseFactory.getDatabasesPath(), 'nombre.db');
  final database = await databaseFactory.openDatabase(dbPath);
  // Crear tabla de tareas si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS tasks (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 nombre TEXT NOT NULL,
 edad INTEGER NOT NULL DEFAULT 0
 )
 ''');
  runApp(Formulario(database: database,));
}

class Formulario extends StatefulWidget {
  final Database database;
  const Formulario({super.key, required this.database});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Formulario BD")),
        body: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Nombre")),
            TextField(decoration: InputDecoration(labelText: "Contenido")),
            ElevatedButton(onPressed: () {}, child: Text("Subir")),
          ],
        ),
      ),
    );
  }
}
