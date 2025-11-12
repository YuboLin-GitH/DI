import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PantallaPrincipal(), // Pantalla inicial que se muestra al abrir la app
    );
  }
}

// Pantalla principal: muestra el color seleccionado (pantalla anterior a SeleccionColor)
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  // Almacena el color seleccionado, inicialmente gris (valor por defecto)
  Color? _colorSeleccionado = Colors.grey;

  // Navega a la pantalla SeleccionColor y espera el color devuelto
  Future<void> _irASeleccionColor() async {
    // Usa Navigator.push para ir a la pantalla de selección y esperar el valor de retorno
    final Color? colorRecibido = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SeleccionColor()),
    );

    // Si el color recibido no es nulo, actualiza el estado para mostrarlo
    if (colorRecibido != null) {
      setState(() {
        _colorSeleccionado = colorRecibido;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla Principal")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contenedor que muestra el color seleccionado
            Container(
              width: 200,
              height: 200,
              color: _colorSeleccionado, // Vincula el color seleccionado
              margin: const EdgeInsets.only(bottom: 20),
            ),
            // Botón para ir a la pantalla de selección de color
            ElevatedButton(
              onPressed: _irASeleccionColor,
              child: const Text("Seleccionar Color"),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de selección de color: SeleccionColor (pantalla requerida en el ejercicio)
class SeleccionColor extends StatelessWidget {
  const SeleccionColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Color")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Layout de cuadrícula para mostrar varios botones de color (3 columnas)
        child: GridView.count(
          crossAxisCount: 3, // 3 botones por fila
          crossAxisSpacing: 15, // Espacio horizontal entre botones
          mainAxisSpacing: 15, // Espacio vertical entre botones
          children: [
            // Botones de color: al hacer clic, devuelven el color correspondiente
            _buildColorButton(context, Colors.red),
            _buildColorButton(context, Colors.blue),
            _buildColorButton(context, Colors.green),
            _buildColorButton(context, Colors.yellow),
            _buildColorButton(context, Colors.purple),
            _buildColorButton(context, Colors.orange),
            _buildColorButton(context, Colors.pink),
            _buildColorButton(context, Colors.black),
            _buildColorButton(context, Colors.white),
          ],
        ),
      ),
    );
  }

  // Método para crear un botón de color (reutiliza código)
  Widget _buildColorButton(BuildContext context, Color color) {
    return ElevatedButton(
      onPressed: () {
        // Clave: vuelve a la pantalla anterior y envía el color seleccionado
        Navigator.pop(context, color);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Color de fondo del botón = color seleccionado
        minimumSize: const Size(80, 80), // Tamaño mínimo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Botón con bordes redondeados
        ),
      ),
      child: const SizedBox.shrink(), // Botón sin texto (solo muestra color)
    );
  }
}