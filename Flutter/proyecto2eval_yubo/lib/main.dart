import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// para varia sistema
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
 leido INTEGER NOT NULL DEFAULT 0,
 gusta INTEGER NOT NULL DEFAULT 0
 )
 ''');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BBDDProvider(database: database),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],

      child: MyApp(),
    ),
  );
}

/// Widget raíz de la aplicación.
///
/// Configura el tema y el modo visual.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Flutter Librería',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: Theme.of(context,).textTheme.apply(
              fontSizeFactor: themeProvider.fontSize / 12.0, 
              bodyColor: Colors.black,    
              displayColor: Colors.black,),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: Theme.of(context,).textTheme.apply(
              fontSizeFactor: themeProvider.fontSize / 12.0, 
              bodyColor: Colors.white, 
              displayColor: Colors.white,),
      ),
      themeMode: themeProvider.themeMode,
      home: const MyHomePage(),
    );
  }
}


/// Página principal que contiene la navegación inferior.
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


/// Representa el modelo de datos de un Libro.
class Libro {
  String titulo;
  String autor;
  int leido;

  Libro(this.titulo, this.autor, this.leido);
}



/// Provider encargado de gestionar la base de datos SQLite.
///
/// Se ocupa de:
/// - Cargar todos los libros desde la base de datos
/// - Insertar nuevos libros
/// - Eliminar libros existentes
/// - Cambiar el estado de lectura y favoritos
///
/// Notifica a la interfaz cuando los datos cambian.
class BBDDProvider extends ChangeNotifier {
  final Database database;

  /// Lista que contiene todos los libros de la base de datos.
  List<Map<String, dynamic>> _todoLibros = [];

  /// Lista que contiene solo los libros marcados como favoritos (gusta = 1).
  List<Map<String, dynamic>> _misLibros = [];

  List<Map<String, dynamic>> get todoLibros => _todoLibros;
  List<Map<String, dynamic>> get misLibros => _misLibros;

  BBDDProvider({required Database database}) : database = database {
    loadLibros();
  }


  /// Carga todos los libros desde la base de datos.
  ///
  /// Actualiza:
  /// - [_todoLibros] con todos los libros
  /// - [_misLibros] con los libros marcados como favoritos
  Future<void> loadLibros() async {
    _todoLibros = await database.query('libro');

    _misLibros = await database.query(
      'libro',
      where: 'gusta = ?',
      whereArgs: [1],
    );
    notifyListeners(); // Notifica la actualización a la interfaz de usuario
  }

  /// Inserta un nuevo libro en la base de datos.
  Future<void> addLibro(String titulo, String autor) async {
    await database.insert('libro', {'titulo': titulo, 'autor': autor});
    await loadLibros();
  }

  /// Elimina un libro de la base de datos según su identificador.
  Future<void> deleteLibro(int id) async {
    await database.delete('libro', where: 'id = ?', whereArgs: [id]);
    await loadLibros();
  }


  /// Alterna el estado de favorito de un libro.
  ///
  /// Si estadoGusta es 0, se marcará como favorito.
  /// Si es 1, se desmarcará.
  Future<void> toggleGusta(int id, int estadoGusta) async {
    await database.update(
      'libro',
      {'gusta': estadoGusta == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    await loadLibros();
  }

  /// Alterna el estado de lectura de un libro.
  ///
  /// Permite marcar un libro como leído o pendiente.
  Future<void> toggleLeido(int id, int estadoLeido) async {
    await database.update(
      'libro',
      {'leido': estadoLeido == 0 ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    await loadLibros();
  }
}

// PANTALLAS Mis libros

/// Pantalla que muestra los libros marcados como favoritos.
class MisLibrosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener datos del proveedor
    final bbddProvider = Provider.of<BBDDProvider>(context);
    final libros = bbddProvider.misLibros;

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Libros")),
    
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, 
          crossAxisSpacing: 10, // Espaciado izquierdo y derecho
          mainAxisSpacing: 10, // Espaciado superior e inferior
          childAspectRatio: 1.5, // altura
        ),
        itemCount: libros.length,
        itemBuilder: (context, index) {
          final libro = libros[index];
          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: const Center(child: Icon(Icons.book, size: 40)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            libro['titulo'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            libro['autor'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      bbddProvider.toggleGusta(libro['id'], libro['gusta']);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


// PANTALLAS Libreria

/// Pantalla principal de la librería.
///
/// Muestra todos los libros almacenados y permite:
/// - Marcar favoritos
/// - Cambiar estado de lectura
/// - Eliminar libros
/// - Añadir nuevos libros
class LibreriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bbddProvider = Provider.of<BBDDProvider>(context);
    final libros = bbddProvider.todoLibros;

    return Scaffold(
      appBar: AppBar(title: Text("Librería")),
      body: libros.isEmpty
          ? Center(child: Text("No hay libro"))
          : ListView.builder(
              itemCount: libros.length,
              itemBuilder: (context, index) {
                final libro = libros[index];
                return ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(libro['titulo']),
                  subtitle: Text(libro['autor']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          libro['gusta'] == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: libro['gusta'] == 1 ? Colors.red : null,
                        ),
                        onPressed: () {
                          bbddProvider.toggleGusta(libro['id'], libro['gusta']);
                        },
                      ),

                      const SizedBox(width: 10),

                      DropdownButton(
                      
                        items: const [
                          DropdownMenuItem(
                            value: 'pendiente',
                            child: Text('Pendiente'),
                          ),
                          DropdownMenuItem(
                            value: 'leido',
                            child: Text('Leído'),
                          ),
                        ],
                        onChanged: (value) {
                          // Cambio de estado del proveedor
                          bbddProvider.toggleLeido(libro['id'], libro['leido']);
                        },
                        value: libro['leido'] == 1 ? 'leido' : 'pendiente',
                      ),

                      const SizedBox(width: 10),

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => bbddProvider.deleteLibro(libro['id']),
                      ),
                    ],
                  ),
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

  /// Muestra un diálogo emergente para introducir los datos de un nuevo libro.
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
              // Validación simple: ambos campos deben tener texto
              if (tituloController.text.isNotEmpty &&autorController.text.isNotEmpty) {
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

// parte ajuste


/// Provider encargado de la configuración visual de la aplicación.
///
/// Permite:
/// - Cambiar entre tema claro y oscuro
/// - Ajustar el tamaño del texto
/// - Guardar preferencias usando SharedPreferences
class ThemeProvider extends ChangeNotifier {
  bool _esClaro = false;
  bool get esClaro => _esClaro;
  ThemeMode get themeMode => _esClaro ? ThemeMode.light : ThemeMode.dark;

  static const String _fontSizeKey = 'fontSize';
  double _fontSize = 12.0;

  double get fontSize => _fontSize;

  ThemeProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _esClaro = prefs.getBool('esClaro') ?? false;

    _fontSize = prefs.getDouble(_fontSizeKey) ?? 12.0;
    notifyListeners();
  }

  /// Cambia entre el tema claro y oscuro y guarda la preferencia.
  Future<void> toggleTheme() async {
    _esClaro = !_esClaro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('esClaro', _esClaro);
  }


  /// Establece el tamaño del texto de la aplicación.
  ///
  /// El valor se limita entre 10 y 14.
  Future<void> setFontSizeScale(double newScale) async {
    _fontSize = newScale.clamp(10, 14);

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, _fontSize);
  }
}



/// Pantalla de ajustes de la aplicación.
///
/// Permite:
/// - Cambiar el tema (claro / oscuro)
/// - Ajustar el tamaño del texto
class AjustesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final esClaro = context.watch<ThemeProvider>().esClaro;
    final currentScale = themeProvider.fontSize;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Tema claro"),
              trailing: Switch(
                onChanged: (_) => context.read<ThemeProvider>().toggleTheme(),
                value: esClaro,
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),

          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Text(
                "Tamaño de texto: ${currentScale.toStringAsFixed(1)}",
              ),
              subtitle: Slider(
                min: 10,
                max: 14,
                divisions: 4,
                value: currentScale,
                onChanged: (value) {
                  themeProvider.setFontSizeScale(value);
                },
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
