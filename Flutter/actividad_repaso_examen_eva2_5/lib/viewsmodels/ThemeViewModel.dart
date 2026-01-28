import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends ChangeNotifier {
  // 1. 数据 (Model): 一个简单的布尔值
  bool _isDarkTheme = false;

  // 2. 暴露数据
  bool get isDarkTheme => _isDarkTheme;

  // 3. 初始化：一启动就加载配置
  ThemeViewModel() {
    _loadTheme();
  }

  // --- 业务逻辑 ---

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // 读取保存的值，如果没有则默认为 false (浅色)
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners(); // 通知 App 刷新主题
  }

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme; // 切换状态
    notifyListeners(); // 通知界面刷新
    
    // 异步保存到本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
  }
}