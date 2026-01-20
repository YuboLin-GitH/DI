import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _esClaro = false;
  bool get esClaro => _esClaro;
  ThemeMode get themeMode => _esClaro ? ThemeMode.light : ThemeMode.dark;

  static const String _fontSizeKey = 'fontSize';
  double _fontSize = 12.0;

  double get fontSize => _fontSize;

  ThemeProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _esClaro = prefs.getBool('esClaro') ?? false;
    _fontSize = prefs.getDouble(_fontSizeKey) ?? 12.0;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _esClaro = !_esClaro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('esClaro', _esClaro);
  }

  Future<void> setFontSizeScale(double newScale) async {
    _fontSize = newScale.clamp(10, 14);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, _fontSize);
  }
}