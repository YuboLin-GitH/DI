import 'package:actividad_repaso_examen_eva2_7/viewmodels/FormViewModel.dart';
import 'package:actividad_repaso_examen_eva2_7/viewmodels/LanguageViewModel.dart';
import 'package:actividad_repaso_examen_eva2_7/views/AccessibleFormScreen.dart';
import 'package:actividad_repaso_examen_eva2_7/views/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 1. 表单逻辑
        ChangeNotifierProvider(create: (_) => FormViewModel()),
        // 2. 语言逻辑 (新增!)
        ChangeNotifierProvider(create: (_) => LanguageViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageVM = context.watch<LanguageViewModel>();
    
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
      locale: languageVM.appLocale,
      home: SettingsScreen(),
      
      );
  }
}