import 'package:flutter/material.dart';

class FormViewModel extends ChangeNotifier {
  // 1. 验证逻辑 (纯逻辑，不涉及 UI)
  
  // 验证名字
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre no puede estar vacío';
    }
    return null; // 验证通过
  }

  // 验证电话
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono no puede estar vacío';
    }
    // 使用正则判断是否全是数字
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Introduce solo números';
    }
    return null; // 验证通过
  }

  // 2. 提交动作
  // 返回 true 表示成功，false 表示失败
  bool submitForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      // 在真实应用中，这里会调用 API 发送数据
      notifyListeners();
      return true;
    }
    return false;
  }
}