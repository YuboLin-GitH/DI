import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('es')],

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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            Text("Nombre de usuario"),
            const SizedBox(width: 10),
            Semantics(
              label: l10n.userName,
              hint: l10n.nameHint,
              child: TextField(
                decoration: InputDecoration(labelText: l10n.userName),
              ),
            ),

            const SizedBox(width: 10),

            Text("Correo de Usuario"),
            const SizedBox(width: 10),

            Semantics(
              label: l10n.email,
              hint: l10n.emailHint,
              child: TextField(
                decoration: InputDecoration(
                  labelText: l10n.email,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Semantics(
              label: l10n.sendButton,
              hint: l10n.submitHint,
              child: ElevatedButton(onPressed: () {}, child: Text(l10n.sendButton)),
            ),
          ],
        ),
      ),
    );
  }
}
