import 'package:actividad5_5_1_accesible_xidioma/viewmodels/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:actividad5_5_1_accesible_xidioma/views/formulario_view.dart';
import 'package:provider/provider.dart';
import 'package:actividad5_5_1_accesible_xidioma/models/formulario_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormularioViewmodel(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), // Ingles 
                          Locale('es') // Español
                          ],
      //tengo que cambiar
      title: "Formulario Contacto",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Formulario(),
    )
    );
  }
}

