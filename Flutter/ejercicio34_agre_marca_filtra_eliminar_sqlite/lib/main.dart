import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Inicializar sqflite para escritorio
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  // Ruta para la base de datos
  final dbPath = join(await databaseFactory.getDatabasesPath(), 'tarea.db');
  final database = await databaseFactory.openDatabase(dbPath);
  // Crear tabla de tareas si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS tarea (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 titulo TEXT NOT NULL,
 descripcion TEXT NOT NULL,
 completed INTEGER NOT NULL DEFAULT 0
 )
 ''');
  runApp(Tarea(database: database));
}

class Tarea extends StatelessWidget {
  final Database database;
  const Tarea({super.key, required this.database});

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
  List<Map<String, dynamic>> _tarea = [];

  final tituloController = TextEditingController();
  final descrController = TextEditingController();
  String _filtroEstado = 'todo';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initFiltroYDatos();
  }

  Future<void> _initFiltroYDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('filtro_estado') ?? 'todo';
    _filtroEstado = saved;
    await _fitraTarea(_filtroEstado);
  }

  Future<void> _fitraTarea(String estado) async {
    List<Map<String, dynamic>> resultado;

    if (estado == "pendiente") {
      resultado = await widget.database.query(
        'tarea',
        where: 'completed = ?',
        whereArgs: [0],
      );
    } else if (estado == "completada") {
      resultado = await widget.database.query(
        'tarea',
        where: 'completed = ?',
        whereArgs: [1],
      );
    } else {
      resultado = await widget.database.query('tarea');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('filtro_estado', estado);

    setState(() {
      _filtroEstado = estado;
      _tarea = resultado;
    });
  }

  Future<void> _addTarea(String titulo, String descripcion) async {
    final tituloText = tituloController.text.trim();
    final descrText  = descrController.text.trim();
    
    await widget.database.insert('tarea', {
      'titulo': tituloText,
      'descripcion': descrText,
      'completed': 0,
    });
    tituloController.clear();
    descrController.clear();
    _fitraTarea(_filtroEstado);
  }

  Future<void> _toggleTarea(int id, int completed) async {
    await widget.database.update(
      'tarea',
      {'completed': completed == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    _fitraTarea(_filtroEstado);
  }

  Future<void> _deleteTarea(int id) async {
    await widget.database.delete('tarea', where: 'id = ?', whereArgs: [id]);
    _fitraTarea(_filtroEstado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Gestor de Tareas")),
        actions: [
          DropdownButton(
            items: const [
              DropdownMenuItem(value: 'todo', child: Text('Todos')),
              DropdownMenuItem(value: 'pendiente', child: Text('Pendiente')),
              DropdownMenuItem(value: 'completada', child: Text('Completada')),
            ],
            onChanged: (value) {
              _fitraTarea(value.toString());
            },
            value: _filtroEstado,
          ),
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,

            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: tituloController,
                    decoration: const InputDecoration(labelText: "Título"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Título no puede estar vacío';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextFormField(
                    controller: descrController,
                    decoration: const InputDecoration(labelText: "Descripción"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Descripción no puede estar vacía';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addTarea(tituloController.text, descrController.text);
                    }
                  },

                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _tarea.length,
              itemBuilder: (context, index) {
                final tareas = _tarea[index];
                return ListTile(
                  title: Text(
                    tareas['titulo'],
                    style: TextStyle(
                      decoration: tareas['completed'] == 1
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(tareas["descripcion"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: 'pendiente',
                            child: Text('Pendiente'),
                          ),
                          DropdownMenuItem(
                            value: 'completada',
                            child: Text('Completada'),
                          ),
                        ],
                        onChanged: (value) {
                          _toggleTarea(tareas['id'], tareas['completed']);
                        },
                        value: tareas['completed'] == 1
                            ? 'completada'
                            : 'pendiente',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTarea(tareas['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
