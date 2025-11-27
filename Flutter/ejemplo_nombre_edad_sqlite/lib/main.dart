import 'dart:math';

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
 CREATE TABLE IF NOT EXISTS nombre (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 nombre TEXT NOT NULL,
 edad INTEGER NOT NULL DEFAULT 0
 )
 ''');
  runApp(Formulario(database: database));
}

class Formulario extends StatefulWidget {
  final Database database;
  const Formulario({super.key, required this.database});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
final nombreController = TextEditingController();
final edadController = TextEditingController();
/*
Future<void> _loadNombre() async {
    final nombre = await widget.database.query('nombre');
    setState(() {
      _nombre = nombre;
    });
  }

*/

Future<void> _addNombre(String nombre, int edad) async {
    await widget.database.insert('nombre', {'nombre': nombreController.text, 'edad': edad});
    nombreController.clear();
    edadController.clear();
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Formulario BD")),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(labelText: "Nombre")),
                  TextField(
                    controller: edadController,
                    decoration: InputDecoration(labelText: "edad"),
                  ),
                  ElevatedButton(onPressed: () => _addNombre(nombreController.text, int.parse(edadController.text))
                    
                  , child: Text("Subir")),
                ],
              ),
            ),

            Expanded(child: 
              //TODO: para muestra nombre - edad
              ListView.builder(
                itemBuilder: (context,index){

                })
            ),
          ],
        ),
      ),
    );
  }
}
