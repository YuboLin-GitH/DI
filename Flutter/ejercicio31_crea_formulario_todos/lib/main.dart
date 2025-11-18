import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



/// 1. Página principal del formulario (gestiona validación y datos)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FormularioPrincipal(), // Página inicial: el formulario
    );
  }
}

/// 2. Formulario principal con validaciones y gestión de datos
class FormularioPrincipal extends StatefulWidget {
  const FormularioPrincipal({super.key});

  @override
  State<FormularioPrincipal> createState() => FormularioPrincipalState();
}

class FormularioPrincipalState extends State<FormularioPrincipal> {
  /// Clave única para el formulario (necesaria para validar y resetear)
  final formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  // Almacena los datos del formulario (se pasarán a la siguiente pantalla)
  String _email = '';
  String _login = '';
  String _contrasena = '';
  String _repetirContrasena = '';
  String _terminos = 'No Aceptar Términos'; // Valor por defecto del desplegable

  /// 3. Limpia todos los campos y errores del formulario
  void borrarFormulario() {
    formKey.currentState!.reset(); // Resetea el formulario
    _passwordController.clear();
    setState(() {
      _terminos = 'No Aceptar Términos'; // Restaura valor por defecto
    });
  }

  /// 4. Envía el formulario si todo es válido y navega a la pantalla de resultado
  /// ```dart
  ///  this.code()
  ///   .looks
  ///   .better();
  /// ```
  /// ssdasdsa
  void enviarFormulario() {
    if (formKey.currentState!.validate()) {
      /// Si pasa las validaciones, guarda los datos
      formKey.currentState!.save();
      
      /// Navega a la pantalla de resultado y pasa los datos
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PantallaResultado(
            email: _email,
            login: _login,
            contrasena: _contrasena,
            terminos: _terminos,
          ),
        ),
      );
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario Simple')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio respecto a los bordes
        child: Form(
          key: formKey, // Relaciona el formulario con la clave
          child: ListView( // ListView evita que el teclado tape los campos
            children: [
              /// 5. Campo para Email (valida formato)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress, // Teclado para email
                /// Reglas de validación: no vacío + contiene @
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email no puede estar vacío';
                  }
                  if (!value.contains('@')) { // Validación simple
                    return 'Email inválido (falta @)';
                  }
                  return null; // Válido
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),

              const SizedBox(height: 16), // Espacio entre campos

              /// 6. Campo Login (no puede ser "admin")
              TextFormField(
                decoration: const InputDecoration(labelText: 'Login'),
                // Reglas: no vacío + distinto a admin
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Login no puede estar vacío';
                  }
                  if (value == 'admin') {
                    return 'Login no puede ser "admin"';
                  }
                  return null;
                },
                onSaved: (value) {
                  _login = value!;
                },
              ),

              const SizedBox(height: 16),

              /// 7. Campo Contraseña (mínimo 8 caracteres y 1 símbolo)
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true, // Oculta la contraseña
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Contraseña no puede estar vacía';
                  }
                  if (value.length <= 8) { // Debe tener más de 8 caracteres
                    return 'Contraseña debe tener más de 8 caracteres';
                  }
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Contraseña debe tener al menos un símbolo (ej: !@#)';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contrasena = value!;
                },
              ),

              const SizedBox(height: 16),

              /// 8. Campo Repetir Contraseña (debe coincidir)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Repetir Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Repite la contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                onSaved: (value) {
                  _repetirContrasena = value!;
                },
              ),

              const SizedBox(height: 16),

              /// 9. Desplegable para aceptar términos
              DropdownButtonFormField(
                value: _terminos, // Valor actual seleccionado
                decoration: const InputDecoration(labelText: 'Términos'),
                items: const [
                  DropdownMenuItem(
                    value: 'Aceptar Términos',
                    child: Text('Aceptar Términos'),
                  ),
                  DropdownMenuItem(
                    value: 'No Aceptar Términos',
                    child: Text('No Aceptar Términos'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _terminos = value!;
                  });
                },
                validator: (value) {
                  if (value == 'No Aceptar Términos') {
                    return 'Debes aceptar los términos';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              /// 10. Botones para limpiar y enviar el formulario
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Botón para limpiar
                  ElevatedButton(
                    onPressed: borrarFormulario,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text('Borrar'),
                  ),
                  /// Botón para enviar
                  ElevatedButton(
                    onPressed: enviarFormulario,
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 11. Pantalla para mostrar los datos enviados
class PantallaResultado extends StatelessWidget {
  // Recibe datos del formulario
  final String email;
  final String login;
  final String contrasena;
  final String terminos;

  /// Se deben recibir todos los datos
  const PantallaResultado({
    super.key,
    required this.email,
    required this.login,
    required this.contrasena,
    required this.terminos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos Enviados')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Muestra cada dato recibido
            _buildDatos('Email', email),
            _buildDatos('Login', login),
            _buildDatos('Contraseña', '******'), // La contraseña no se muestra
            _buildDatos('Términos', terminos),
          ],
        ),
      ),
    );
  }

  /// Componente reutilizable para mostrar "título: valor"
  Widget _buildDatos(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
