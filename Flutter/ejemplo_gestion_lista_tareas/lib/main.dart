import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() async {
  // Inicializar sqflite para escritorio
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  // Ruta para la base de datos
  final dbPath = join(await databaseFactory.getDatabasesPath(), 'tasks.db');
  final database = await databaseFactory.openDatabase(dbPath);
  // Crear tabla de tareas si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS tasks (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 title TEXT NOT NULL,
 completed INTEGER NOT NULL DEFAULT 0
 )
 ''');
  runApp(TaskApp(database: database));
}

class TaskApp extends StatelessWidget {
  final Database database;
  TaskApp({required this.database});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TaskScreen(database: database));
  }
}

class TaskScreen extends StatefulWidget {
  final Database database;
  TaskScreen({required this.database});
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, dynamic>> _tasks = [];
  final _taskController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }
 
  Future<void> _loadTasks() async {
    final tasks = await widget.database.query('tasks');
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _addTask(String title) async {
    await widget.database.insert('tasks', {'title': title, 'completed': 0});
    _taskController.clear();
    _loadTasks();
  }

  Future<void> _toggleTask(int id, int completed) async {
    await widget.database.update(
      'tasks',
      {'completed': completed == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    _loadTasks();
  }

  Future<void> _deleteTask(int id) async {
    await widget.database.delete('tasks', where: 'id = ?', whereArgs: [id]);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tareas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(hintText: 'Nueva tarea'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTask(_taskController.text),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: task['completed'] == 1
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          task['completed'] == 1
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () =>
                            _toggleTask(task['id'], task['completed']),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(task['id']),
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
