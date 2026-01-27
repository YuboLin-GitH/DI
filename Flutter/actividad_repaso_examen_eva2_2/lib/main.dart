import 'package:actividad_repaso_examen_eva2_2/models/PerfilModel.dart';
import 'package:actividad_repaso_examen_eva2_2/viewmodels/PerfilViewModel.dart';
import 'package:actividad_repaso_examen_eva2_2/views/PerfilCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_)=> PerfilViewModel(
      PerfilModel(
        name: "Jose", 
        photoUrl: "https://placehold.co/150.jpg",)
    ),
    child:MainApp(),
    ),
    
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Perfil con Stack y MVVM")),
        body: Center(
          child: PerfilCard(),
        ),
      ),
    );
  }
}
