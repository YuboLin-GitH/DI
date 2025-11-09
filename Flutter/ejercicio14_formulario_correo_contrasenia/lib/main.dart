import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
      var _formKey = GlobalKey<FormState>();
    
    return MaterialApp(
      home: Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Nombre por defecto"),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nombre"),
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "El nombre no puede estar vacio";
                    }
                    return null;
                  },
                ),
                Text("Correo"),
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
                Text("Contraseña"),
                TextFormField(
                  decoration: InputDecoration(
                  labelText: 'Introduce tu contraseña',
                  ),
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "El contraseña no puede estar vacio";
                    }
                    return null;
                  },
                  
                obscureText: true,
                ),
                ElevatedButton(onPressed: (){
                  if (_formKey.currentState!.validate()) {
                   
                      print('✅ Formulario enviado correctamente!');
                    }
                }, child: Text("Validar"))
              ],
            ),
          
        )
      ),
    );
  }
}
