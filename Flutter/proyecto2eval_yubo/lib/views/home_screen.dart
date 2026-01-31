import 'package:flutter/material.dart';
import 'package:proyecto2eval_yubo/l10n/app_localizations.dart';
import 'package:proyecto2eval_yubo/views/mis_libros_view.dart';
import 'package:proyecto2eval_yubo/views/libreria_view.dart';
import 'package:proyecto2eval_yubo/views/ajustes_view.dart';


/// Pantalla principal que contiene la estructura de navegación de la app.
///
/// Utiliza un [BottomNavigationBar] para alternar entre las tres vistas principales:
/// 1. [MisLibrosScreen]: Libros favoritos.
/// 2. [LibreriaScreen]: Todos los libros.
/// 3. [AjustesScreen]: Configuración de la app.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MisLibrosScreen(),
    LibreriaScreen(),
    AjustesScreen(),
  ];

  /// Cambia la pantalla actual al pulsar en la barra de navegación.
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: l10n.misLibros),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: l10n.libreria),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: l10n.ajustes),
        ],
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}