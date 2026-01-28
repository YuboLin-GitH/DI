import 'package:flutter_test/flutter_test.dart';
import 'package:similar_examen_eva2/viewmodels/converter_view_model.dart';


void main() {
  group('ConverterViewModel Logic', () {
    late ConverterViewModel viewModel;

    setUp(() {
      viewModel = ConverterViewModel();
    });

    test('Verificar tasas de conversión', () {
      // Probar que 1 Km = 1000 Metros
      double rateKmToM = viewModel.conversionRates['Kilómetros']!['Metros']!;
      expect(rateKmToM, 1000.0);

      // Probar que 1 Milla = 1.60934 Km
      double rateMilesToKm = viewModel.conversionRates['Millas']!['Kilómetros']!;
      expect(rateMilesToKm, 1.60934);
    });
    
    // Nota: Para probar 'convertAndSave' se necesitaría mockear DatabaseService,
    // ya que los test unitarios no tienen acceso a sqflite real fácilmente.
  });
}