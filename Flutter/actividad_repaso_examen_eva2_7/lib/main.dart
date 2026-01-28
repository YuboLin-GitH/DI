import 'package:actividad_repaso_examen_eva2_7/viewmodels/FormViewModel.dart';
import 'package:actividad_repaso_examen_eva2_7/views/AccessibleFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FormViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccessibleFormScreen()
      );
  }
}