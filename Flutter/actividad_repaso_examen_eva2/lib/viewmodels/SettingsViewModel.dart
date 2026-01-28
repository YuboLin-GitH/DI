import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel para gestionar ajustes (Tema, Idioma, Tamaño texto).
/// 考点：DartDoc 文档注释
class SettingsViewModel extends ChangeNotifier {
  bool _isDark = false;
  double _textSize = 1.0;
  Locale _currentLocale = const Locale('es'); // 默认西班牙语

  bool get isDark => _isDark;
  double get textSize => _textSize;
  Locale get currentLocale => _currentLocale;

  SettingsViewModel() {
    _loadSettings();
  }

  // 加载设置 (SharedPreferences)
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? false;
    _textSize = prefs.getDouble('textSize') ?? 1.0;
    String langCode = prefs.getString('language') ?? 'es';
    _currentLocale = Locale(langCode);
    notifyListeners();
  }

  // 切换主题
  void toggleTheme(bool value) async {
    _isDark = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', value);
  }

  // 切换字体大小
  void changeTextSize(double value) async {
    _textSize = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textSize', value);
  }

  // 切换语言
  void changeLanguage(String code) async {
    _currentLocale = Locale(code);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', code);
  }
}