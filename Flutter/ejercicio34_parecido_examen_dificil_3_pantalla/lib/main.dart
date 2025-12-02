import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';


void main() async {
  // Inicializar sqflite para escritorio
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  // Ruta para la base de datos
  final dbPath = join(await databaseFactory.getDatabasesPath(), 'nombre.db');
  final database = await databaseFactory.openDatabase(dbPath);
  // Crear tabla de nombre si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS nombre (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 nombre TEXT NOT NULL,
 edad INTEGER NOT NULL DEFAULT 0
 )
 ''');
  runApp(
    ChangeNotifierProvider(
      create: (context) => BBDDProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 34 de Yubo',
      debugShowCheckedModeBanner: false, // quitar Debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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




class BBDDProvider extends ChangeNotifier {
  int _contador = 0;

  int get contador => _contador;

  void incrementar() {
    _contador++;
    notifyListeners();
  }

  void decrementar() {
    _contador--;
    notifyListeners();
  }




  
}







class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
 

 List<Map<String, dynamic>> _nombre = [];

  final nombreController = TextEditingController();
  final edadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNombre();
  }

  Future<void> _loadNombre() async {
    final nombre = await widget.database.query('nombre');
    setState(() {
      _nombre = nombre;
    });
  }

  Future<void> _addNombre(String nombre, int edad) async {
    await widget.database.insert('nombre', {'nombre': nombre, 'edad': edad});
    nombreController.clear();
    edadController.clear();
    _loadNombre();
  }


   Future<void> _toggleNombre(String nombre, int edad) async {
    await widget.database.update(
      'nombre',
      {'edad' : edad},
      where: 'nombre = ?',
      whereArgs: [nombre],
    );
    _loadNombre();
  }


  Future<void> _deleteNombre(String nombre, int edad) async {
    await widget.database.delete('nombre', 
                                  where: 'nombre = ? and  edad = ?', 
                                  whereArgs: [nombre, edad]);
    _loadNombre();
  }



  @override
  Widget build(BuildContext context) {
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
                        onPressed: () => _addNombre(
                          nombreController.text,
                          int.parse(edadController.text),
                        ),
                        child: Text("Agregar"),
                      ),

                      // modificar edad
                      ElevatedButton(
                        onPressed: () => _toggleNombre(
                          nombreController.text,
                          int.parse(edadController.text),
                        ),
                        child: Text("Modificar Edad"),
                      ),

                      // Eliminar cuyo nombre y edad erar mismo que introducido
                      ElevatedButton(
                        onPressed: () => _deleteNombre(
                          nombreController.text,
                          int.parse(edadController.text),
                        ),
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

// PANTALLAS Feed

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View")),
      body: Center(child: Text("No hay datos")),
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
  var estadoswitch = false;
  String terminos = "espanol";
  late double valueLinea = 0;

  @override
  Widget build(BuildContext context) {
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
                onChanged: (estado) {
                  setState(() {
                    estadoswitch = estado;
                    if (estadoswitch) {
                    } else {}
                  });
                },
                value: estadoswitch,
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
              title: Text("Tamaño de texto: 1.0"),

              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
