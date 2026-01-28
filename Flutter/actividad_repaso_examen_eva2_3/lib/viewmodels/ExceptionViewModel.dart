import 'package:flutter/material.dart';

class ExceptionViewModel extends ChangeNotifier {
  String? _errorMessage;
  
  // 暴露给界面读取的数据
  String? get errorMessage => _errorMessage;

  // 辅助属性：判断是否是错误消息（为了决定显示红色还是绿色）
  bool get isError => _errorMessage != null && _errorMessage!.startsWith("Error");

  void convertStringToInt(String value) {
    try {
      // 纯逻辑：尝试转换
      int number = int.parse(value);
      
      // 成功：更新数据
      _errorMessage = "El número es: $number"; 
      notifyListeners(); // 通知界面刷新
      
    } catch (e) {
      // 失败：捕获异常并更新数据
      _errorMessage = "Error: '$value' no es un número válido.";
      notifyListeners(); // 通知界面刷新
    }
  }
}