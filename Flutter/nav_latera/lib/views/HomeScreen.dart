import 'package:flutter/material.dart';
import 'package:nav_latera/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            Text("Nombre de usuario"),
            const SizedBox(width: 10),
            Semantics(
              label: l10n.userName,
              hint: l10n.nameHint,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Introduce tu nombre'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "El nombre no puede estar vacio";
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(width: 10),

            Text("Correo de Usuario"),
            const SizedBox(width: 10),

            Semantics(
              label: l10n.email,
              hint: l10n.emailHint,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Introduce tu correo electronico',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un email';
                  }
                  // Expresión regular simple para validar email
                  final emailRegExp = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (!emailRegExp.hasMatch(value)) {
                    return 'Introduce un correo electrónico válido';
                  }
                  return null; // Si todo está bien, devuelve null
                },
              ),
            ),
            const SizedBox(width: 10),
            Semantics(
              label: l10n.sendButton,
              hint: l10n.submitHint,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(' Formulario enviado correctamente!');
                  }
                },
                child: Text("Enviar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
