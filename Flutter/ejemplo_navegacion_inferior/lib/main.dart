import 'package:flutter/material.dart';

void main() {
  runApp(const HomeNavScreen());
}

class HomeNavScreen extends StatefulWidget {
  const HomeNavScreen({super.key});

  @override
  State<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends State<HomeNavScreen> {
  int _selectedIndex = 0; // INDICE ACTUAL DEL BOTTOM NAVIGATION BAR

  void _onItemTapped(int index) { 
    setState(() {
      _selectedIndex = index;// ACTUALIZA EL INDICE
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Negocios',),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Escuela'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
