import 'package:examen_eva2_yubo/l10n/app_localizations.dart';
import 'package:examen_eva2_yubo/views/gestion_screen.dart';
import 'package:examen_eva2_yubo/views/listado_screen.dart';
import 'package:examen_eva2_yubo/views/settings_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de pantallas
  final List<Widget> _pages = [
    GestionScreen(),
    ListadoScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Títulos dinámicos según la página seleccionada
    final List<String> _titles = [
      l10n.tituloGestion,
      l10n.tituloListado,
      l10n.tituloAjuste
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      // Drawer para navegación
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: UserAccountsDrawerHeader(accountName: Icon(Icons.person), accountEmail: Text("Library Manager")),
              
            ),
            ListTile(
              leading: Icon(Icons.library_add),
              title: Text(l10n.tituloGestion),
              onTap: () => _onItemTapped(0),
              selected: _selectedIndex == 0,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text(l10n.tituloListado),
              onTap: () => _onItemTapped(1),
              selected: _selectedIndex == 1,
            ),
            
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(l10n.tituloAjuste),
              onTap: () => _onItemTapped(2),
              selected: _selectedIndex == 2,
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Cerrar el drawer
  }
}