import 'package:actividad_repaso_examen_eva2_4/viewmodels/NumbersViewModel.dart';
import 'package:actividad_repaso_examen_eva2_4/views/EvenNumbersScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NumbersViewModel(), // 注入 ViewModel
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: EvenNumbersScreen());
  }
}