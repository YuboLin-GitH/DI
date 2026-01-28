import 'package:actividad_repaso_examen_eva2_10/views/simple_database_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo BBDD',
      theme: ThemeData(primarySwatch: Colors.blue),
      // 设置首页
      home: SimpleDatabaseScreen(),
    );
  }
}