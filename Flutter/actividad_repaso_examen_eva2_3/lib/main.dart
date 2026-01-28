import 'package:actividad_repaso_examen_eva2_3/viewmodels/ExceptionViewModel.dart';
import 'package:actividad_repaso_examen_eva2_3/views/ExceptionScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // 在这里注入 ViewModel
    ChangeNotifierProvider(
      create: (_) => ExceptionViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExceptionScreen(),
    );
  }
}