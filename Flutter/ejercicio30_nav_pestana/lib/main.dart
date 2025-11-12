import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación con Pestañas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(), // Pantalla principal que contiene las pestañas
    );
  }
}

// Pantalla principal: incluye TabBar (pestañas superiores) y TabBarView (contenido)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// SingleTickerProviderStateMixin: necesario para manejar animaciones del TabController
class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  // Controlador de pestañas: gestiona la sincronización entre pestañas y contenido
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador con 3 pestañas (Home, Perfil, Ajustes)
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Destruye el controlador para evitar fugas de memoria
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicación con Pestañas'),
        // TabBar: pestañas en la parte inferior de la AppBar
        bottom: TabBar(
          controller: _tabController, // Asocia el controlador a las pestañas
          labelColor: Colors.white, // Color del texto de la pestaña seleccionada
          unselectedLabelColor: Colors.white70, // Color del texto de pestañas no seleccionadas
          indicatorColor: Colors.white, // Color de la línea inferior de la pestaña seleccionada
          tabs: const [
            // Cada Tab representa una opción en el menú de pestañas
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.person), text: "Perfil"),
            Tab(icon: Icon(Icons.settings), text: "Ajustes"),
          ],
        ),
      ),
      // TabBarView: área de contenido que cambia según la pestaña seleccionada
      body: TabBarView(
        controller: _tabController, // Asocia el controlador al contenido
        children: const [
          // Contenido de cada pestaña (mismos widgets que el código original)
          HomeScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}

// Pantalla Home: muestra una lista de elementos (mismo funcionalidad que antes)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20, // Número total de elementos en la lista
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Elemento $index"),
          leading: const Icon(Icons.star), // Icono a la izquierda del texto
          onTap: () {
            // Acción al pulsar un elemento: muestra un SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Elemento $index pulsado")),
            );
          },
        );
      },
    );
  }
}

// Pantalla Perfil: contenido simple centrado
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Pantalla de Perfil",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Pantalla Ajustes: contenido simple centrado
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