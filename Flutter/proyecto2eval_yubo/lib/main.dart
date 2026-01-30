import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/library_view_model.dart';
import 'viewmodels/settings_view_model.dart';
import 'views/home_screen.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsVM = context.watch<SettingsViewModel>();
    return MaterialApp(
      title: 'Flutter Librería',
      debugShowCheckedModeBanner: false,
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
      themeMode: settingsVM.themeMode,
      home: const MyHomePage(),
    );
  }
}