// Pantalla Ajustes: contenido simple centrado
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Pantalla de Ajustes",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}