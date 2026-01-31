import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/library_view_model.dart';
import 'viewmodels/settings_view_model.dart';
import 'views/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';




/// Punto de entrada principal de la aplicación.
///
/// Inicializa los bindings de Flutter, configura la ventana para entornos de escritorio
/// (Windows/Linux/MacOS), inicializa la base de datos y arranca la aplicación.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LibraryViewModel(),),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}


/// Widget raíz de la aplicación.
///
/// Configura el [MaterialApp] con:
/// * Gestión de temas (Claro/Oscuro) dinámicos.
/// * Configuración de internacionalización (Idiomas).
/// * Rutas y pantalla de inicio.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsVM = context.watch<SettingsViewModel>();
    return MaterialApp(
      title: 'Flutter Librería',
      debugShowCheckedModeBanner: false,

      locale: settingsVM.currentLocale,

      supportedLocales: const [
        Locale('es'), // Español
        Locale('en'), // English
        Locale('zh'), // Chinese
      ],

      localizationsDelegates: const [
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate, 
        GlobalWidgetsLocalizations.delegate,  
        GlobalCupertinoLocalizations.delegate, 
      ],
      // Tema Claro
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown, 
          foregroundColor: Colors.white, 
          centerTitle: true,            
        ),

        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: settingsVM.fontSize / 12.0,
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),

      // Tema Oscuro
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown[900], 
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.brown[400], 
          secondary: Colors.amber,    
          primaryContainer: Colors.brown[800], 
        ),
        
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: settingsVM.fontSize / 12.0,
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      // Modo de tema seleccionado por el usuario (Sistema/Claro/Oscuro)
      themeMode: settingsVM.themeMode,
      home: const MyHomePage(),
    );
  }
}