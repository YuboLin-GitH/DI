/// Modelo de datos que representa una transacción de conversión.
///
/// Contiene el valor original, las unidades y el resultado calculado.
class TransaccionesModel {
  /// Identificador único de la transacción en la base de datos.
  final int? id;

  /// Valor numérico introducido por el usuario.
  final double inputValue;

  /// Unidad de medida de origen (ej. 'Kilómetros').
  final String inputUnit;

  /// Unidad de medida de destino (ej. 'Millas').
  final String outputUnit;

  /// Resultado de la conversión.
  final double result;

  /// Crea una instancia de [TransaccionesModel].
  TransaccionesModel({
    this.id,
    required this.inputValue,
    required this.inputUnit,
    required this.outputUnit,
    required this.result,
  });

  /// Convierte el objeto a un mapa JSON para insertarlo en la base de datos.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inputValue': inputValue,
      'inputUnit': inputUnit,
      'outputUnit': outputUnit,
      'result': result,
    };
  }

  /// Crea una instancia de [TransaccionesModel] a partir de un mapa JSON (de la BBDD).
  factory TransaccionesModel.fromMap(Map<String, dynamic> map) =>
      TransaccionesModel(
        id: map['id'],
        inputValue: map['inputValue'],
        inputUnit: map['inputUnit'],
        outputUnit: map['outputUnit'],
        result: map['result'],
      );
}