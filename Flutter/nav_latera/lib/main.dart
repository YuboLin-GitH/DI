import 'package:flutter/material.dart';
import 'package:nav_latera/views/MainScreen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';


void main() async{
    // Inicializar sqflite para escritorio
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  // Ruta para la base de datos
  final dbPath = join(
    await databaseFactory.getDatabasesPath(),
    'ejercicioconversiones.db',
  );
  final database = await databaseFactory.openDatabase(dbPath);

   await database.execute("DROP TABLE IF EXISTS conversiones");
  // Crear tabla de nombre si no existe
  await database.execute('''
 CREATE TABLE IF NOT EXISTS conversiones (
   id INTEGER PRIMARY KEY,
  valor INTEGER,
  origen TEXT,
  destino TEXT,
  resultado REAL
 );
INSERT INTO conversiones (id, valor, origen, destino, resultado)
VALUES
(1, 50, 'Kilometros', 'Millas', 39.05),
(2, 100, 'Metros', 'Kilometros', 40.90),
(3, 200, 'Millas', 'Kilometros', 29.0),
(4, 300, 'Kilometros', 'Millas', 35.70);
''');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('es')],
      debugShowCheckedModeBanner: false,
      title: 'Lateral Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // 推荐开启 Material 3，Drawer 样式更好看
      ),
      home: const MainScreen(),
    );
  }
}