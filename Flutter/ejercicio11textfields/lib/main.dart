import 'package:flutter/material.dart';

/* EJERCICIO 11: Crea un formulario de registro que tenga TextFields para nombre, correo
electrónico y contraseña. Usa el widget Form para gestionar la validación, y
añade un botón para enviar el formulario */

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text("Formulario de Registro"),),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Introduce tu nombre'),
                validator: (value) { 
                    if (value?.isEmpty ?? true) {
                      return 'El nombre no puede estar vacío'; 
                    }
                    return null;
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Introduce tu email'),
                keyboardType: TextInputType.emailAddress,
                 validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'El email no puede estar vacío';
                    }
                    if (!value!.contains('@')) {
                      return 'El email debe contener @';
                    }
                    return null;
                  }, 
              ),
              ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate()) {
                   
                      print('✅ Formulario enviado correctamente!');
                    }
              }, child: Text('Enviar'))
            ],
          ),
        ),
      ),
    );
  }
}


class _pantalla2State extends StatefulWidget {
  const _pantalla2State({super.key});

  @override
  State<_pantalla2State> createState() => __pantalla2StateState();
}

class __pantalla2StateState extends State<_pantalla2State> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


