import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Formulario(),
    );
  }
}


class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child:Column(
          children: [
            Text("Nombre de usuario"),
            const SizedBox(width: 10),
            Semantics(
              label: "Campo de usuario",
              hint: 'Por favor ingresa un nombre válido',
              child: TextField(
                decoration: InputDecoration(labelText: 'Introduce tu nombre')
              ),

            ),

            const SizedBox(width: 10),

            Text("Correo de Usuario"),
            const SizedBox(width: 10),

            Semantics(
              label: "Campo de correo electrónico",
              hint: 'Por favor ingresa un correo válido',
              child: TextField(
                decoration: InputDecoration(labelText: 'Introduce tu correo electronico')
              ),

            ),
            const SizedBox(width: 10),
            Semantics(
              label: "Botón de envia",
              hint: "Pulsa para enviar el formulario",
              child: ElevatedButton(onPressed: (){}, child: Text("Enviar"),
            ),
            )
          ],
        ) 
      ),
    );
  }
}