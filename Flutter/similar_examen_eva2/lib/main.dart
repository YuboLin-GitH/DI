import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:similar_examen_eva2/l10n/app_localizations.dart';
import 'package:similar_examen_eva2/services/database_service.dart';
import 'package:similar_examen_eva2/views/home_screen.dart';


import 'viewmodels/settings_view_model.dart';
import 'viewmodels/converter_view_model.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().database;
  runApp(
    // Requisito: Usa MultiProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => ConverterViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Escuchar cambios de configuración
    final settings = context.watch<SettingsViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen Conversor',
      
      // Configuración de Idioma (intl)
      locale: settings.appLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Configuración de Tema (Claro/Oscuro)
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

      // Requisito: Centraliza cambios de escala con MediaQuery
      builder: (context, child) {
        return MediaQuery(
          // Sobrescribe el textScaler globalmente
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(settings.textScaleFactor),
          ),
          child: child!,
        );
      },

      home: HomeScreen(),
    );
  }
}