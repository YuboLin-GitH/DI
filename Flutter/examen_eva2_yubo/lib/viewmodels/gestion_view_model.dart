
import 'package:examen_eva2_yubo/model/libroModel.dart';
import 'package:examen_eva2_yubo/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// ViewModel para la lógica de negocio del conversor y gestión de transacciones.
class GestionViewModel extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  
  List<Libromodel> _libros = [];

  List<Libromodel> get libros => _libros;


  Future<void> loadDatos() async {
    final datos = await _dbService.getLibros();
    _libros = datos;
    notifyListeners();
  }

  Future<int> insertLibro(String title, String author, String genre, int status) async {
    // 自动生成当前时间
    final now = DateTime.now();
    final dateString = "${now.day}/${now.month}/${now.year}";

    // 🔥 创建 Model 对象 (装箱)
    final nuevoLibro = Libromodel(
      title: title,
      author: author,
      genre: genre,
      status: status,
      date: dateString,
    );

    // 把对象传给 Service
    final result = await _dbService.insertLibro(nuevoLibro);
    
    // 插入后记得刷新列表
    await loadDatos(); 
    return result;
  }





  String? validateTitulo(String? value) {
    if (value == null || value.isEmpty) {
      return 'El Titulo no puede estar vacío';
    }
    return null; 
  }


  String? validateAutor(String? value) {
    if (value == null || value.isEmpty) {
      return 'El Autor no puede estar vacío';
    }
    return null; 
  }

  String? validateGenero(String? value) {
    if (value == null || value.isEmpty) {
      return 'El Genero no puede estar vacío';
    }
    return null; 
  }



  bool submitForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      // 在真实应用中，这里会调用 API 发送数据
      notifyListeners();
      return true;
    }
    return false;
  }



}