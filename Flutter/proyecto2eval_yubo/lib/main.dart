import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

// para varia sistema
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 异步 main 必须加这一行

  // SOLO para escritorio Windows y MacOS
  if (Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Ruta para la base de datos
  final dbPath = join(await databaseFactory.getDatabasesPath(), 'libros.db');
  final database = await databaseFactory.openDatabase(dbPath);
  // Crear tabla de nombre si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS libro (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 titulo TEXT NOT NULL,
 autor TEXT NOT NULL,
 leido INTEGER NOT NULL DEFAULT 0
 )
 ''');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BBDDProvider(database: database),
        ),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // INDICE ACTUAL DEL BOTTOM NAVIGATION BAR

  // LISTA DE WIDGETS PARA CADA PANTALLA
  final List<Widget> _screens = [
    MisLibrosScreen(),
    LibreriaScreen(),
    AjustesScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index; // ACTUALIZA EL INDICE
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

class Libro {
  String titulo;
  String autor;
  int leido;

  Libro(this.titulo, this.autor, this.leido);
}

class BBDDProvider extends ChangeNotifier {
  final Database database;

  List<Map<String, dynamic>> _libroLista = [];
  List<Map<String, dynamic>> get libroLista => _libroLista;

  BBDDProvider({required Database database}) : database = database {
    loadLibro();
  }

  Future<void> loadLibro() async {
    final libros = await database.query('libro');
    _libroLista = libros;
    notifyListeners();
  }

  Future<void> addLibro(String titulo, String autor) async {
    await database.insert('libro', {'titulo': titulo, 'autor': autor});
    await loadLibro();
  }

  Future<void> deleteLibro(String titulo, String autor) async {
    await database.delete(
      'libro',
      where: 'titulo = ? and  autor = ?',
      whereArgs: [titulo, autor],
    );
    loadLibro();
  }
}

// PANTALLAS INDIVIDUALES
class MisLibrosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Elemento $index"),
          leading: Icon(Icons.star),
          onTap: () {
            // ACCIÓN AL PULSAR UN ELEMENTO DE LA LISTA
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Elemento $index pulsado")));
          },
        );
      },
    );
  }
}

class LibreriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bbddProvider = Provider.of<BBDDProvider>(context);
    final libros = bbddProvider.libroLista;

    return Scaffold(
      appBar: AppBar(title: Text("View")),
      body: libros.isEmpty
          ? Center(child: Text("No hay datos"))
          : ListView.builder(
              itemCount: libros.length,
              itemBuilder: (context, index) {
                final libro = libros[index];
                return ListTile(
                  leading: const Icon(Icons.book), 
                  title: Text(libro['titulo']), 
                  subtitle: Text(libro['autor']), 
                  trailing: Text(libro['leido'] == 1 ? "Leído" : "Pendiente"),
                );
              },
            ),
    floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _mostrarFormulario(context, bbddProvider); 
        },
        icon: const Icon(Icons.add),
        label: const Text("Añadir Libro"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer, 
      ),
    );
  }

  void _mostrarFormulario(BuildContext context, BBDDProvider provider) {
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController autorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Añadir nuevo libro"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: autorController,
              decoration: const InputDecoration(labelText: "Autor"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          FilledButton( 
            onPressed: () {     
              if (tituloController.text.isNotEmpty && autorController.text.isNotEmpty) {
                provider.addLibro(tituloController.text, autorController.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}

class AjustesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Pantalla de Ajustes", style: TextStyle(fontSize: 24)),
    );
  }
}
