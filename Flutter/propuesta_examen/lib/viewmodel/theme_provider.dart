import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider que gestiona la configuración global de la aplicación.
///
/// Controla el tema (Claro/Oscuro), el tamaño del texto y el idioma,
/// persistiendo los datos con [SharedPreferences].
class ThemeProvider extends ChangeNotifier {
  final String _key = 'isDark';
  final String _keyText = "textSize";
  final String _keyLang = "language";
  Locale _locale = Locale("es");
  bool _isDark = false;
  double _textSize = 1.0;

  bool get isDark => _isDark;
  double get textSize => _textSize;
  Locale get locale => _locale;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_key) ?? false;
    _textSize = prefs.getDouble(_keyText) ?? 1.0;
    String? langCode = prefs.getString(_keyLang);
    if (langCode != null) {
      _locale = Locale(langCode);
    }
    notifyListeners();
  }
/// Cambia y guarda el tamaño del texto.
  Future<void> setTextSize(double value) async {
    _textSize = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyText, _textSize);
    notifyListeners();
  }
/// Alterna y guarda el modo oscuro/claro.
  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _isDark);
    notifyListeners();
  }
/// Cambia y guarda el idioma seleccionado.
  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLang, languageCode);
    notifyListeners();
  }
}
