import 'package:flutter/material.dart';

void main() {
  runApp(ListaTareasApp());
}

// Aplicación principal
class ListaTareasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListaTareasPage(),
    );
  }
}

// Página principal con la lista de tareas
class ListaTareasPage extends StatefulWidget {
  @override
  State<ListaTareasPage> createState() => _ListaTareasPageState();
}

class _ListaTareasPageState extends State<ListaTareasPage> {
  // Lista de tareas (cada tarea tiene texto y un estado "completada")
  final List<Map<String, dynamic>> tareas = [];

  // Controlador para leer el texto del campo de entrada
  final TextEditingController _controller = TextEditingController();

  // Función para agregar una nueva tarea a la lista
  void _agregarTarea() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        tareas.add({'texto': _controller.text, 'completada': false});
        _controller.clear(); // Limpia el campo de texto
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de tareas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Formulario para añadir tareas ---
            Row(
              children: [
                // Campo de texto
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Nueva tarea'),
                  ),
                ),
                // Botón para agregar tarea
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _agregarTarea,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // --- Lista de tareas con Checkbox ---
            Expanded(
              child: ListView.builder(
                itemCount: tareas.length,
                itemBuilder: (context, index) {
                  final tarea = tareas[index];
                  return CheckboxListTile(
                    title: Text(
                      tarea['texto'],
                      // Cambia color y estilo si la tarea está completada
                      style: TextStyle(
                        color: tarea['completada'] ? Colors.grey : null,
                        decoration: tarea['completada']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    // Checkbox muestra el estado actual
                    value: tarea['completada'],
                    // Cuando cambia, actualiza el valor
                    onChanged: (valor) {
                      setState(() => tarea['completada'] = valor);
                    },
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