import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Inicializar sqflite para escritorio
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  // Ruta para la base de datos
  final dbPath = join(await databaseFactory.getDatabasesPath(), 'persona.db');
  final database = await databaseFactory.openDatabase(dbPath);
  // Crear tabla de nombre si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS persona (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 nombre TEXT NOT NULL,
 edad INTEGER NOT NULL DEFAULT 0
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Flutter 34 de Yubo',
      debugShowCheckedModeBanner: false, // quitar Debug
      theme: ThemeData.light().copyWith(
        textTheme: Theme.of(
          context,
        ).textTheme.apply(fontSizeFactor: themeProvider.fontSize/ 12.0 ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: Theme.of(
          context,
        ).textTheme.apply(fontSizeFactor: themeProvider.fontSize / 12.0 ),
      ),
      themeMode: themeProvider.themeMode,

      home: const HomeNavScreen(),
    );
  }
}

class HomeNavScreen extends StatefulWidget {
  const HomeNavScreen({super.key});

  @override
  State<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends State<HomeNavScreen> {
  int _selectedIndex = 0; // INDICE ACTUAL DEL BOTTOM NAVIGATION BAR

  // LISTA DE WIDGETS PARA CADA PANTALLA
  final List<Widget> _screens = [
    FormularioScreen(),
    ViewScreen(),
    OptionsViewOpenDirection(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // ACTUALIZA EL INDICE
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.back_hand),
            label: 'Formulario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye_rounded),
            label: 'View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Opciones',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// PANTALLAS Generar

class Persona {
  String nombre;
  int edad;

  Persona(this.nombre, this.edad);
}

class BBDDProvider extends ChangeNotifier {
  final Database database;

  List<Map<String, dynamic>> _personaLista = [];
  List<Map<String, dynamic>> get personaLista => _personaLista;

  BBDDProvider({required Database database}) : database = database {
    loadPersona();
  }

  Future<void> loadPersona() async {
    final personas = await database.query('persona');
    _personaLista = personas;
    notifyListeners();
  }

  Future<void> addPersona(String nombre, int edad) async {
    await database.insert('persona', {'nombre': nombre, 'edad': edad});
    await loadPersona();
  }

  Future<void> togglePersona(String nombre, int edad) async {
    await database.update(
      'persona',
      {'edad': edad},
      where: 'nombre = ?',
      whereArgs: [nombre],
    );
    loadPersona();
  }

  Future<void> deletePersona(String nombre, int edad) async {
    await database.delete(
      'persona',
      where: 'nombre = ? and  edad = ?',
      whereArgs: [nombre, edad],
    );
    loadPersona();
  }
}

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final nombreController = TextEditingController();
  final edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bbddProvider = Provider.of<BBDDProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(labelText: "Nombre"),
                  ),
                  TextField(
                    controller: edadController,
                    decoration: InputDecoration(labelText: "edad"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final nombre = nombreController.text;
                          final edad = int.tryParse(edadController.text) ?? 0;
                          bbddProvider.addPersona(nombre, edad);

                          nombreController.clear();
                          edadController.clear();
                        },
                        child: Text("Agregar"),
                      ),

                      // modificar edad
                      ElevatedButton(
                        onPressed: () {
                          bbddProvider.togglePersona(
                            nombreController.text,
                            int.parse(edadController.text),
                          );

                          nombreController.clear();
                          edadController.clear();
                        },
                        child: Text("Modificar Edad"),
                      ),

                      // Eliminar cuyo nombre y edad erar mismo que introducido
                      ElevatedButton(
                        onPressed: () {
                          bbddProvider.deletePersona(
                            nombreController.text,
                            int.parse(edadController.text),
                          );

                          nombreController.clear();
                          edadController.clear();
                        },
                        child: Text("Eliminar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PANTALLAS View

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bbddProvider = Provider.of<BBDDProvider>(context);
    final personas = bbddProvider.personaLista;

    return Scaffold(
      appBar: AppBar(title: Text("View")),
      body: personas.isEmpty
          ? Center(child: Text("No hay datos"))
          : ListView.builder(
              itemCount: personas.length,
              itemBuilder: (context, index) {
                final persona = personas[index];
                return ListTile(
                  leading: Text("${persona['id']}"),
                  title: Text(persona['nombre']),
                  trailing: Text("${persona['edad']} años"),
                );
              },
            ),
    );
  }
}

// PANTALLAS Opciones

class OptionsViewOpenDirection extends StatefulWidget {
  const OptionsViewOpenDirection({super.key});

  @override
  State<OptionsViewOpenDirection> createState() =>
      _OptionsViewOpenDirectionState();
}

class _OptionsViewOpenDirectionState extends State<OptionsViewOpenDirection> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final esClaro = context.watch<ThemeProvider>().esClaro;
    final currentScale = themeProvider.fontSize ;
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
              title: Text("Tamaño de texto: ${currentScale.toStringAsFixed(1)}"),
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

class ThemeProvider extends ChangeNotifier {
  bool _esClaro = false;
  bool get esClaro => _esClaro;
  ThemeMode get themeMode => _esClaro ? ThemeMode.light : ThemeMode.dark;

  static const String _fontSizeKey = 'fontSize';
  double _fontSize  = 12.0;

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

  Future<void> toggleTheme() async {
    _esClaro = !_esClaro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('esClaro', _esClaro);
  }

  Future<void> setFontSizeScale(double newScale) async {
    _fontSize  = newScale.clamp(10, 14);

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, _fontSize );
  }
}
