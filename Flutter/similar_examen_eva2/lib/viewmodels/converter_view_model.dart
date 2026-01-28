import 'package:flutter/material.dart';
import '../services/database_service.dart';

/// ViewModel para la lógica de negocio del conversor y gestión de transacciones.
class ConverterViewModel extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> get transactions => _transactions;

  // Mapa de conversiones requerido por el examen
  final Map<String, Map<String, double>> conversionRates = {
    'Kilómetros': {'Kilómetros': 1.0, 'Metros': 1000.0, 'Millas': 0.621371},
    'Metros': {'Kilómetros': 0.001, 'Metros': 1.0, 'Millas': 0.000621371},
    'Millas': {'Kilómetros': 1.60934, 'Metros': 1609.34, 'Millas': 1.0},
  };

  /// Realiza la conversión y guarda el resultado en BBDD.
  Future<bool> convertAndSave(String inputStr, String from, String to) async {
    final value = double.tryParse(inputStr);
    if (value == null) return false;

    // Lógica de conversión usando el Map
    double rate = conversionRates[from]![to]!;
    double result = value * rate;

    // Insertar en BBDD
    await _dbService.insertTransaction({
      'inputValue': value,
      'fromUnit': from,
      'toUnit': to,
      'resultValue': result,
    });

    // Recargar lista
    await loadTransactions();
    return true;
  }

  /// Carga el historial desde la base de datos.
  Future<void> loadTransactions() async {
    _transactions = await _dbService.getTransactions();
    notifyListeners();
  }

  /// Elimina una transacción de la base de datos y actualiza la lista.
  Future<void> deleteTransaction(int id) async {
    await _dbService.deleteTransaction(id);
    await loadTransactions();
  }
}