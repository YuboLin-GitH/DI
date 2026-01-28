import 'package:flutter/material.dart';
import 'package:similar_examen_eva2/l10n/app_localizations.dart';
import 'package:similar_examen_eva2/views/converter_screen.dart';
import 'package:similar_examen_eva2/views/settings_screen.dart';
import 'package:similar_examen_eva2/views/transactions_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de pantallas
  final List<Widget> _pages = [
    ConverterScreen(),
    TransactionsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Títulos dinámicos según la página seleccionada
    final List<String> _titles = [
      l10n.menuConverter,
      l10n.menuTransactions,
      l10n.menuSettings
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      // Drawer para navegación
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.swap_horiz),
              title: Text(l10n.menuConverter),
              onTap: () => _onItemTapped(0),
              selected: _selectedIndex == 0,
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text(l10n.menuTransactions),
              onTap: () => _onItemTapped(1),
              selected: _selectedIndex == 1,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(l10n.menuSettings),
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