import 'package:actividad_repaso_examen_eva2/views/CounterScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Repaso Examen EVA2',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Counterscreen(),
    );
  }
}
