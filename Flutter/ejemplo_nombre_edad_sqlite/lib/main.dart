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
  // Crear tabla de nombre si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS nombre (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 nombre TEXT NOT NULL,
 edad INTEGER NOT NULL DEFAULT 0
 )
 ''');
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database;
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Formulario(database: database),
    );
  }
}

class Formulario extends StatefulWidget {
  final Database database;
  const Formulario({super.key, required this.database});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  List<Map<String, dynamic>> _nombre = [];

  final nombreController = TextEditingController();
  final edadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNombre();
  }

  Future<void> _loadNombre() async {
    final nombre = await widget.database.query('nombre');
    setState(() {
      _nombre = nombre;
    });
  }

  Future<void> _addNombre(String nombre, int edad) async {
    await widget.database.insert('nombre', {'nombre': nombre, 'edad': edad});
    nombreController.clear();
    edadController.clear();
    _loadNombre();
  }


   Future<void> _toggleNombre(String nombre, int edad) async {
    await widget.database.update(
      'nombre',
      {'edad' : edad},
      where: 'nombre = ?',
      whereArgs: [nombre],
    );
    _loadNombre();
  }


  Future<void> _deleteNombre(String nombre, int edad) async {
    await widget.database.delete('nombre', 
                                  where: 'nombre = ? and  edad = ?', 
                                  whereArgs: [nombre, edad]);
    _loadNombre();
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
                  Form(
                    child: Column(
                      children: [
                        TextField(
                          controller: nombreController,
                          decoration: InputDecoration(labelText: "Nombre"),
                        ),
                        TextField(
                          controller: edadController,
                          decoration: InputDecoration(labelText: "edad"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _addNombre(
                                nombreController.text,
                                int.parse(edadController.text),
                              ),
                              child: Text("Agregar"),
                            ),

                            // modificar edad
                            ElevatedButton(
                              onPressed: () => _toggleNombre(
                                nombreController.text,
                                int.parse(edadController.text),
                              ),
                              child: Text("Modificar Edad"),
                            ),

                            // Eliminar cuyo nombre y edad erar mismo que introducido
                            ElevatedButton(
                              onPressed: () => _deleteNombre(
                                nombreController.text,
                                int.parse(edadController.text),
                              ),
                              child: Text("Eliminar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child:
                  //TODO: para muestra nombre - edad
                  ListView.builder(
                    itemCount: _nombre.length,
                    itemBuilder: (context, index) {
                      final persona = _nombre[index];
                      return ListTile(
                        title: Text(
                          "${persona['nombre']} - ${persona['edad']}",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
