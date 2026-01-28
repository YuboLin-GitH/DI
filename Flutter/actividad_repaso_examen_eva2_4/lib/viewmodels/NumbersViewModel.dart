import 'package:flutter/material.dart';

class NumbersViewModel extends ChangeNotifier {
  // 1. 数据 (Model)
  // 原始数据（现实中这可能来自数据库或 API）
  final List<int> _numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  
  // 结果数据
  List<int> _evenNumbers = [];

  // 2. 暴露数据 (Getters)
  // 让界面能读取原始列表（用于显示第一行文字）
  List<int> get numbers => _numbers;
  // 让界面能读取偶数列表（用于 ListView）
  List<int> get evenNumbers => _evenNumbers;

  // 3. 构造函数 (初始化逻辑)
  // 相当于原来的 initState
  NumbersViewModel() {
    _filterEvenNumbers();
  }

  // 4. 业务逻辑 (Logic)
  void _filterEvenNumbers() {
    // 这里执行筛选逻辑
    _evenNumbers = _numbers.where((number) => number % 2 == 0).toList();
    notifyListeners(); // 通知界面更新（虽然在这个静态例子中不加也行，但养成习惯很好）
  }
}