import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        body: Form(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Introduce tu nombre'),
                onChanged: (text) {
                  print('Texto introducido: $text');
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Introduce tu contraseña',
                ),
                onChanged: (password) {
                  print('Texto introducido: $password');
                },
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Introduce tu email'),
                onChanged: (email) {
                  print('Texto introducido: $email');
                },
                //validator:(value){
                 // if(value?.isEmpty ?? true){
                  //  return 'El email no puede estar vacío';
                 // }
                //}
              ),
              ElevatedButton(onPressed: (){}, child: Text('Enviar'))
            ],
          ),
        ),
      ),
    );
  }
}
