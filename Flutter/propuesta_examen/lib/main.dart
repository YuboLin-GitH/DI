import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:propuesta_examen/l10n/app_localizations.dart';

import 'package:propuesta_examen/viewmodel/theme_provider.dart';
// Importamos el nuevo ViewModel
import 'package:propuesta_examen/viewmodel/conversor_viewmodel.dart';
import 'package:propuesta_examen/views/conversor_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Añadimos el provider del conversor
        ChangeNotifierProvider(create: (_) => ConversorViewModel()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          locale: themeProvider.locale,

          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: [Locale("es"), Locale("en")],
          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(themeProvider.textSize),
              ),
              child: child!,
            );
          },
          home: Conversor(),
        );
      },
    );
  }
}
