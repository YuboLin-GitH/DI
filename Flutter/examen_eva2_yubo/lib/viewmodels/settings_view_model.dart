import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel para gestionar la configuración global de la app.
/// Maneja: Tema (Claro/Oscuro), Idioma, Tamaño de texto.
class SettingsViewModel extends ChangeNotifier {
  // Estados iniciales por defecto
  bool _isDarkTheme = false;
  Locale _appLocale = const Locale('es');
  double _textScaleFactor = 1.0;

  // Getters
  bool get isDarkTheme => _isDarkTheme;
  Locale get appLocale => _appLocale;
  double get textScaleFactor => _textScaleFactor;

  SettingsViewModel() {
    _loadPreferences();
  }

  /// Carga las preferencias guardadas en SharedPreferences.
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDark') ?? false;
    String langCode = prefs.getString('language') ?? 'es';
    _appLocale = Locale(langCode);
    _textScaleFactor = prefs.getDouble('textScale') ?? 1.0;
    notifyListeners();
  }

  /// Cambia el tema y guarda la preferencia.
  Future<void> toggleTheme(bool value) async {
    _isDarkTheme = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDarkTheme);
  }

  /// Cambia el idioma y guarda la preferencia.
  Future<void> changeLanguage(Locale locale) async {
    _appLocale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
  }

  /// Cambia el tamaño del texto y guarda la preferencia.
  Future<void> changeTextScale(double scale) async {
    _textScaleFactor = scale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textScale', _textScaleFactor);
  }
}