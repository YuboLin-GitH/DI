import 'package:actividad_repaso_examen_eva2_7/viewmodels/FormViewModel.dart';
import 'package:actividad_repaso_examen_eva2_7/views/AccessibleFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FormViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate, // 我们生成的代理
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es'), // 西班牙语
        Locale('en'), // 英语
      ],
      home: AccessibleFormScreen(),
      locale: Locale('es'),
      );
  }
}