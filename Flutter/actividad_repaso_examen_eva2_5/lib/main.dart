import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // Cargar el tema almacenado en SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  // Guardar el tema en SharedPreferences
  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', value);
  }

  // Alternar entre los temas
  void _toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
    _saveTheme(isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: ThemeSwitcherScreen(
        isDarkTheme: isDarkTheme,
        toggleTheme: _toggleTheme,
      ),
    );
  }
}

class ThemeSwitcherScreen extends StatelessWidget {
  final bool isDarkTheme;
  final VoidCallback toggleTheme;

  ThemeSwitcherScreen({required this.isDarkTheme, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de Tema')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isDarkTheme ? 'Tema Oscuro Activado' : 'Tema Claro Activado',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: toggleTheme, child: Text('Cambiar Tema')),
          ],
        ),
      ),
    );
  }
}
