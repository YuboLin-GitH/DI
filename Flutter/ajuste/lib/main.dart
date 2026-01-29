import 'dart:io';
import 'package:ajuste/viewmodels/SettingsViewModel.dart';
import 'package:ajuste/views/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'l10n/app_localizations.dart';


void main() async {
  // 1. 必加：确保 Flutter 绑定初始化，否则后面 await 会报错
  WidgetsFlutterBinding.ensureInitialized();

  // 2. 考点：初始化 Windows/Desktop 数据库工厂
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // 3. 考点：在 main 里打开数据库
  final dbPath = join(await getDatabasesPath(), 'student_exam.db');
  
  final database = await openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) async {
      // 🔥 修改这里：把表名改成 students，字段改成 name 和 score
      await db.execute('''
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          score INTEGER NOT NULL
        )
      ''');
    },
  );

  runApp(
    MultiProvider(
      providers: [
        // 注册两个 ViewModel
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
    // 监听设置变化 (Theme, Locale, TextSize)
    final settings = context.watch<SettingsViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam Project',

      // 考点：多语言支持
      locale: settings.currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // 考点：明暗主题
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings.isDark ? ThemeMode.dark : ThemeMode.light,

      // 考点：MediaQuery 控制字体大小
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          // 强制覆盖整个 App 的文字缩放比例
          data: mediaQuery.copyWith(textScaler: TextScaler.linear(settings.textSize)),
          child: child!,
        );
      },
      
      home:MainScreen(),
    );
  }
}