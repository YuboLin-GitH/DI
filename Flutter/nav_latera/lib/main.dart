import 'package:flutter/material.dart';
import 'package:nav_latera/views/MainScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lateral Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // 推荐开启 Material 3，Drawer 样式更好看
      ),
      home: const MainScreen(),
    );
  }
}