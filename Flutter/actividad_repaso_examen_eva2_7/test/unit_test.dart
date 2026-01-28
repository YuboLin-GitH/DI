import 'package:actividad_repaso_examen_eva2_7/viewmodels/FormViewModel.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:tu_proyecto/viewmodels/FormViewModel.dart'; // 导入 ViewModel

void main() {
  group('Unit Test - FormViewModel', () {
    final viewModel = FormViewModel(); // 直接造一个 ViewModel

    test('Verificar nombre: Error si está vacío', () {
      expect(viewModel.validateName(''), 'El nombre no puede estar vacío');
    });

    test('Verificación de nombre: exitosa', () {
      expect(viewModel.validateName('Jose'), null);
    });

    test('Número de teléfono de verificación: Mensaje de error no numérico', () {
      expect(viewModel.validatePhone('abc'), 'Introduce solo números');
    });

    test('Verificación telefónica: exitosa', () {
      expect(viewModel.validatePhone('123456'), null);
    });
  });
}