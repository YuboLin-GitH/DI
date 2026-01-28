import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageViewModel extends ChangeNotifier {
  // 默认语言 (例如西班牙语)
  Locale _appLocale = const Locale('es');

  Locale get appLocale => _appLocale;

  // 构造函数：一启动就去加载保存的语言
  LanguageViewModel() {
    _loadLanguage();
  }

  // --- 核心逻辑：加载语言 ---
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('language_code');

    if (languageCode != null) {
      _appLocale = Locale(languageCode);
      notifyListeners();
    }
  }

  // --- 核心逻辑：切换并保存语言 ---
  Future<void> changeLanguage(Locale type) async {
    _appLocale = type;
    notifyListeners(); // 通知 App 刷新

    // 保存到本地
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', type.languageCode);
  }
}