import 'package:flutter/material.dart';

void main() {
  runApp(ConfiguracionApp());
}

// Aplicación principal con tema claro/oscuro
class ConfiguracionApp extends StatefulWidget {
  @override
  State<ConfiguracionApp> createState() => _ConfiguracionAppState();
}

class _ConfiguracionAppState extends State<ConfiguracionApp> {
  // Variable para controlar si el modo oscuro está activado
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modo Claro/Oscuro',
      // Cambia el tema según el valor del switch
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Configuración')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Cambiar entre modo claro y oscuro'),
              // Switch para activar o desactivar el modo oscuro
              Switch(
                value: darkMode,
                onChanged: (value) => setState(() => darkMode = value),
              ),
              const SizedBox(height: 20),
              // Botón de ejemplo para mostrar el cambio de tema
              ElevatedButton(
                onPressed: () {},
                child: const Text('Botón de ejemplo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}