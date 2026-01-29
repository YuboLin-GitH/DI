import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() async {
  // Inicializar sqflite para escritorio
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  // Ruta para la base de datos
  final dbPath = join(
    await databaseFactory.getDatabasesPath(),
    'gestodenero.db',
  );
  final database = await databaseFactory.openDatabase(dbPath);
  // Crear tabla de nombre si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS gestodenero (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 tipo TEXT NOT NULL,
 categoria TEXT ,
 dinero REAL NOT NULL,
 fecha TEXT NOT NULL 
 )
 ''');
  runApp(
    ChangeNotifierProvider(
      create: (context) => GestoDineroProvider(database: database),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Formulario());
  }
}

class Transaccion {
  String tipo;
  String categoria;
  double dinero;
  String fecha;

  Transaccion(this.tipo, this.categoria, this.dinero, this.fecha);
}

class GestoDineroProvider extends ChangeNotifier {
  final Database database;

  List<Map<String, dynamic>> _transacciones = [];
  List<Map<String, dynamic>> get transacciones => _transacciones;

  GestoDineroProvider({required Database database}) : database = database {
    loadDatos();
  }

  Future<void> loadDatos() async {
    final datos = await database.query('gestodenero');
    _transacciones = datos;
    notifyListeners();
  }

  Future<void> addDatos(String tipo, String categoria, double dinero) async {
    final fechaActual = DateTime.now();
    final String fechaString =
        '${fechaActual.year.toString().padLeft(4, '0')}-'
        '${fechaActual.month.toString().padLeft(2, '0')}-'
        '${fechaActual.day.toString().padLeft(2, '0')} '
        '${fechaActual.hour.toString().padLeft(2, '0')}:'
        '${fechaActual.minute.toString().padLeft(2, '0')}:'
        '${fechaActual.second.toString().padLeft(2, '0')}';

    await database.insert('gestodenero', {
      'tipo': tipo,
      'categoria': categoria,
      'dinero': dinero,
      'fecha': fechaString,
    });
    await loadDatos();
  }
}

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}




class _FormularioState extends State<Formulario> {
  final dineroController = TextEditingController();
  final List<bool> _selectedtipo = <bool>[true, false];
  String _tipoSeleccionado = 'Gasto';

  Map<String, List<String>> CATEGORIAS = {
    'Gasto': ['Comida', 'Alquiler', 'Transporte', 'Otros Gastos'],
    'Ingreso': ['Salario', 'Regalo', 'Otros Ingresos'],
  };

  String? _categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    _categoriaSeleccionada = CATEGORIAS[_tipoSeleccionado]!.first;
  }

  @override
  Widget build(BuildContext context) {
    final gestoDineroProvider = Provider.of<GestoDineroProvider>(context);

    List<Widget> tipo = <Widget>[Text('Gasto'), Text('Ingreso')];

    return Scaffold(
      appBar: AppBar(title: Text("Insertar Dato")),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                'Opciones de Usuario',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Formulario'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.info),
              title: Text('Transacciones'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Transacciones(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _selectedtipo.length; i++) {
                          _selectedtipo[i] = i == index;
                        }
                        if (index == 0) {
                          _tipoSeleccionado = 'Gasto';
                        } else {
                          _tipoSeleccionado = 'Ingreso';
                        }
                        _categoriaSeleccionada = null;
                      });
                    },
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: _selectedtipo[0]
                        ? Colors.red[300]
                        : Colors.green[300],
                    color: Colors.black,
                    constraints: BoxConstraints(
                      minHeight: 30.0,
                      minWidth: 120.0,
                    ),
                    isSelected: _selectedtipo,
                    children: tipo,
                  ),

                  const SizedBox(height: 24),

                  DropdownButton<String>(
                    value: _categoriaSeleccionada,
                    hint: Text("Selecciona categoría"),
                    items: CATEGORIAS[_tipoSeleccionado]!
                        .map(
                          (categoria) => DropdownMenuItem(
                            value: categoria,
                            child: Text(categoria),
                          ),
                        )
                        .toList(),
                    onChanged: (valor) {
                      setState(() {
                        _categoriaSeleccionada = valor;
                      });
                    },
                  ),

                  TextField(
                    controller: dineroController,
                    decoration: InputDecoration(labelText: "dinero"),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _tipoSeleccionado == 'Gasto'
                              ? Colors.red
                              : Colors.green,
                        ),

                        onPressed: () {
                          // Validar dinero
                          if (dineroController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "El campo dinero no puede estar vacío",
                                ),
                              ),
                            );
                            return;
                          }

                          // Validar número
                          final dinero = double.tryParse(dineroController.text);
                          if (dinero == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ingresa un número válido"),
                              ),
                            );
                            return;
                          }

                          if (dinero <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("El dinero debe ser mayor que 0"),
                              ),
                            );
                            return;
                          }

                          // Validar categoría
                          if (_categoriaSeleccionada == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Debes seleccionar una categoría",
                                ),
                              ),
                            );
                            return;
                          }

                          // Si todo está OK => guardar
                          gestoDineroProvider.addDatos(
                            _tipoSeleccionado,
                            _categoriaSeleccionada.toString(),
                            dinero,
                          );

                          dineroController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Guardado correctamente")),
                          );
                        },

                        child: Text("Guardar"),
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

class Transacciones extends StatefulWidget {
  const Transacciones({super.key});

  @override
  State<Transacciones> createState() => _TransaccionesState();
}

class _TransaccionesState extends State<Transacciones> {
  String formatearFecha(String fechaIso) {
    final fecha = DateTime.parse(fechaIso);
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    final anio = fecha.year.toString();
    final hora = fecha.hour.toString().padLeft(2, '0');
    final minuto = fecha.minute.toString().padLeft(2, '0');
    final segundo = fecha.minute.toString().padLeft(2, '0');

    return "$dia/$mes/$anio $hora:$minuto:$segundo";
  }

  @override
  Widget build(BuildContext context) {
    final gestoDineroProvider = Provider.of<GestoDineroProvider>(context);
    final gastoLista = gestoDineroProvider.transacciones;
    return Scaffold(
      appBar: AppBar(title: Text(" Transacciones")),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                'Opciones de Usuario',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Formulario'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Formulario()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.info),
              title: Text('Transacciones'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: gastoLista.isEmpty
          ? Center(child: Text("No hay datos"))
          : ListView.builder(
              itemCount: gastoLista.length,
              itemBuilder: (context, index) {
                final gestoDinero = gastoLista[index];
                final esGasto = gestoDinero['tipo'] == 'Gasto';

                final Color transaccionColor = esGasto
                    ? Colors.red
                    : Colors.green;
                final IconData transaccionIcon = esGasto
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded;

                return ListTile(
                  leading: Icon(transaccionIcon, color: transaccionColor),
                  title: Text(gestoDinero['dinero'].toString()),
                  subtitle: Text(
                    "${gestoDinero['tipo']} - ${gestoDinero['categoria']} ",
                  ),

                  trailing: Text(formatearFecha(gestoDinero['fecha'])),
                );
              },
            ),
    );
  }
}
