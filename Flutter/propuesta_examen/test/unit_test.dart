import 'package:flutter_test/flutter_test.dart';
import 'package:propuesta_examen/models/transacciones_model.dart';

void main() {
  group('Pruebas Unitarias - TransaccionesModel', () {
    test('El modelo debe convertirse correctamente a Map (toMap)', () {
      // 1. Preparar (Arrange)
      final transaccion = TransaccionesModel(
        id: 1,
        inputValue: 10.0,
        inputUnit: 'Kilómetros',
        outputUnit: 'Millas',
        result: 6.21,
      );

      // 2. Actuar (Act)
      final map = transaccion.toMap();

      // 3. Verificar (Assert)
      expect(map['id'], 1);
      expect(map['inputValue'], 10.0);
      expect(map['inputUnit'], 'Kilómetros');
      expect(map['result'], 6.21);
    });

    test('El Map debe convertirse correctamente a Modelo (fromMap)', () {
      // 1. Preparar
      final map = {
        'id': 2,
        'inputValue': 1000.0,
        'inputUnit': 'Metros',
        'outputUnit': 'Kilómetros',
        'result': 1.0,
      };

      // 2. Actuar
      final model = TransaccionesModel.fromMap(map);

      // 3. Verificar
      expect(model.id, 2);
      expect(model.inputValue, 1000.0);
      expect(model.inputUnit, 'Metros');
      expect(model.result, 1.0);
    });
  });
}