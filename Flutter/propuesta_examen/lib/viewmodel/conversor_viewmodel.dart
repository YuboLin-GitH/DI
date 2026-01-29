import 'package:flutter/material.dart';
import 'package:propuesta_examen/models/transacciones_model.dart';
import 'package:propuesta_examen/viewmodel/transacciones_viewmodel.dart';

/// ViewModel encargado de la lógica de negocio de la pantalla Conversor.
///
/// Gestiona el estado de los dropdowns, realiza los cálculos de conversión
/// y solicita el guardado en la base de datos.
class ConversorViewModel extends ChangeNotifier {
  /// Mapa de tasas de conversión entre unidades.
  final Map<String, Map<String, double>> conversionRates = {
    'Kilómetros': {'Kilómetros': 1.0, 'Metros': 1000.0, 'Millas': 0.621371},
    'Metros': {'Kilómetros': 0.001, 'Metros': 1.0, 'Millas': 0.000621371},
    'Millas': {'Kilómetros': 1.60934, 'Metros': 1609.34, 'Millas': 1.0},
  };

  String _dropdownValue = 'Kilómetros';
  String _dropdownValue2 = 'Millas';
  double _resultado = 0.0;

  // Getters
  String get dropdownValue => _dropdownValue;
  String get dropdownValue2 => _dropdownValue2;
  double get resultado => _resultado;
  
  /// Obtiene la lista de unidades disponibles.
  List<String> get unidades => conversionRates.keys.toList();

  /// Actualiza la unidad de origen seleccionada.
  void setDropdownValue(String? value) {
    if (value != null) {
      _dropdownValue = value;
      notifyListeners();
    }
  }

  /// Actualiza la unidad de destino seleccionada.
  void setDropdownValue2(String? value) {
    if (value != null) {
      _dropdownValue2 = value;
      notifyListeners();
    }
  }

  /// Realiza la conversión y guarda el resultado en la base de datos.
  ///
  /// Retorna [true] si la operación fue exitosa, o [false] si la validación falló.
  Future<bool> convertirYGuardar(String textValue) async {
    // Validación: Si está vacío o no es un número, retornamos false.
    if (textValue.isEmpty) return false;
    double? inputVal = double.tryParse(textValue);
    if (inputVal == null) return false;

    double rate = conversionRates[_dropdownValue]![_dropdownValue2]!;
    
    _resultado = inputVal * rate;
    notifyListeners(); 

    final nuevaTransaccion = TransaccionesModel(
      inputValue: inputVal,
      inputUnit: _dropdownValue,
      outputUnit: _dropdownValue2,
      result: _resultado,
    );

    await DatabaseService.instance.insertTransaction(nuevaTransaccion);
    return true;
  }
}