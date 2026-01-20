import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'dart:io';


import 'providers/db_provider.dart';
import 'providers/theme_provider.dart';
import 'views/home_screen.dart';

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Flutter Librería',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: themeProvider.fontSize / 12.0,
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: themeProvider.fontSize / 12.0,
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      themeMode: themeProvider.themeMode,
      home: const MyHomePage(),
    );
  }
}