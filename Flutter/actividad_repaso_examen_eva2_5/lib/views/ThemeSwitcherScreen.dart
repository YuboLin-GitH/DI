import 'package:actividad_repaso_examen_eva2_5/viewsmodels/ThemeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ThemeSwitcherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. 监听状态 (watch) 用于显示文字
    final isDark = context.watch<ThemeViewModel>().isDarkTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Configuración MVVM')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isDark ? 'Tema Oscuro Activado' : 'Tema Claro Activado',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 2. 触发逻辑 (read) 用于切换
                context.read<ThemeViewModel>().toggleTheme();
              },
              child: Text('Cambiar Tema'),
            ),
          ],
        ),
      ),
    );
  }
}