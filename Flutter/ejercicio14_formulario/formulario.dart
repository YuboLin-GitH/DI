import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormularioRegistro(),
        ),
      ),
    );
  }
}

class FormularioRegistro extends StatefulWidget {
  @override
  _FormularioRegistroState createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: InputDecoration(labelText: "Nombre"),
            validator: (value) => value == null || value.isEmpty ? 'Introduce tu nombre' : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _correoController,
            decoration: InputDecoration(labelText: 'Correo electrónico'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Introduce tu correo electrónico';
              if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}").hasMatch(value)) {
                return 'Correo inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _contrasenaController,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) => value == null || value.isEmpty ? 'Introduce tu contraseña' : null,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('¡Formulario válido!')),
                );
              }
            },
            child: Text('Validar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }
}
