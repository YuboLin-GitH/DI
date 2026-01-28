import 'package:actividad_repaso_examen_eva2_5/views/ThemeSwitcherScreen.dart';
import 'package:actividad_repaso_examen_eva2_5/viewsmodels/ThemeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    // 在最顶层注入 ViewModel
    ChangeNotifierProvider(
      create: (_) => ThemeViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 监听 ViewModel，因为这里决定了整个 App 是黑还是白
    final themeVM = context.watch<ThemeViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 根据 ViewModel 的值动态切换 Theme
      theme: themeVM.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: ThemeSwitcherScreen(),
    );
  }
}