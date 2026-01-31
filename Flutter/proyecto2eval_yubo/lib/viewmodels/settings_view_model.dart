import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



/// ViewModel para la gestión de preferencias de usuario.
///
/// Controla el tema (oscuro/claro), el tamaño de fuente y el idioma,
/// persistiendo los datos utilizando [SharedPreferences].
class SettingsViewModel extends ChangeNotifier {
  bool _esOscuro = false;
  bool get esOscuro => _esOscuro;
  ThemeMode get themeMode => _esOscuro ? ThemeMode.dark : ThemeMode.light;

  static const String _fontSizeKey = 'fontSize';
  static const String _themeKey = 'esOscuro';
  
  
  double _fontSize = 12.0;

  double get fontSize => _fontSize;


  Locale _currentLocale = const Locale('es');

  Locale get currentLocale => _currentLocale;
  static const String _langKey = 'languageCode';


  SettingsViewModel() {
    _loadFromPrefs();
  }

  /// Carga las preferencias guardadas en el dispositivo.
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _esOscuro = prefs.getBool(_themeKey) ?? false;
    _fontSize = prefs.getDouble(_fontSizeKey) ?? 12.0;
    String langCode = prefs.getString(_langKey) ?? 'es';
    _currentLocale = Locale(langCode);
    notifyListeners();
  }


  /// Cambia el idioma de la aplicación.
  ///
  /// [languageCode] debe ser 'es', 'en' o 'zh'.
  Future<void> setLanguage(String languageCode) async {
    if (['es', 'zh', 'en'].contains(languageCode)) {
      _currentLocale = Locale(languageCode);
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_langKey, languageCode);
    }
  }

  /// Alterna entre tema claro y oscuro.
  Future<void> toggleTheme() async {
    _esOscuro = !_esOscuro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _esOscuro);
  }

  /// Configurar tamaño de texto.
  Future<void> setFontSizeScale(double newScale) async {
    _fontSize = newScale.clamp(10, 14);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, _fontSize);
  }
}