
import 'package:examen_eva2_yubo/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// ViewModel para la lógica de negocio del conversor y gestión de transacciones.
class GestionViewModel extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  
  List<Map<String, dynamic>> _libros = [];

  List<Map<String, dynamic>> get libros => _libros;


  Future<void> loadDatos() async {
    final datos = await _dbService.query('books');
    _libros = datos;
    notifyListeners();
  }

  Future<int> insertLibro(String title, String author, String genre, int status, String date) async {
    
    return await _dbService.insertLibro(title, author, genre, status, date);
  
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