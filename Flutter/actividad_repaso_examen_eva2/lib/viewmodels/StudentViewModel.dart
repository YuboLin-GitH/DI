import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';



class StudentViewModel extends ChangeNotifier {

  final Database _db;

  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> get students => _students;


  StudentViewModel(this._db) {
    _loadStudents();
  }


  // 读取数据
  Future<void> _loadStudents() async {
    _students = await _db.query('students');
    notifyListeners();
  }

  // 添加数据
  Future<void> addStudent(String name, int score) async {
    await _db.insert('students', {'name': name, 'score': score});
    _loadStudents(); // 刷新列表
  }

  // 删除数据
  Future<void> deleteStudent(int id) async {
    await _db.delete('students', where: 'id = ?', whereArgs: [id]);
    _loadStudents();
  }
}