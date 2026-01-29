import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:propuesta_examen/main.dart' as app;

void main() {
  // 1. Inicializar el entorno de integración
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flujo completo: Convertir valor y verificar resultado', (WidgetTester tester) async {
    // 2. Arrancar la app completa
    app.main();
    
    // Esperar a que la app cargue completamente
    await tester.pumpAndSettle();

    // 3. Interactuar con la UI
    
    // Localizar el campo de texto y escribir "10"
    final finderTextField = find.byType(TextFormField);
    await tester.enterText(finderTextField, '10');
    await tester.pumpAndSettle(); // Esperar a que se escriba

    // Opcional: Cambiar dropdowns (asumimos que por defecto son KM -> Millas)
    // Si quisieras cambiarlos, harías tester.tap() en el dropdown y luego en la opción.

    // Localizar y pulsar el botón "Convertir y guardar"
    // Buscamos por el tipo ElevatedButton ya que el texto puede variar por el idioma
    final finderButton = find.byType(ElevatedButton);
    await tester.tap(finderButton);
    
    // Esperar a que ocurra la conversión, el guardado en BD y aparezca el SnackBar
    await tester.pumpAndSettle();

    // 4. Verificar Resultados
    
    // Verificar que aparece el resultado en pantalla.
    // 10 Km a Millas es 6.21371.
    // Como tu UI muestra "Resultado: ...", buscamos parte del texto o el widget contenedor.
    // Buscaremos si aparece el número aproximado o el texto de resultado.
    
    // Nota: Esto depende de cómo formatea tu toStringAsFixed en la vista.
    // Si usas 2 decimales sería "6.21".
    expect(find.textContaining('6.21'), findsOneWidget);

    // Verificar que aparece el SnackBar de éxito
    expect(find.text('Transacción guardada exitosamente'), findsOneWidget);
  });
}