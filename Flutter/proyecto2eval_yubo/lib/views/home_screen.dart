import 'package:flutter/material.dart';
import 'package:proyecto2eval_yubo/views/mis_libros_view.dart';
import 'package:proyecto2eval_yubo/views/libreria_view.dart';
import 'package:proyecto2eval_yubo/views/ajustes_view.dart';



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

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Mis Libros"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Librería"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
        ],
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}