import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:propuesta_examen/l10n/app_localizations.dart';

// Importamos tus vistas y viewmodels
import 'package:propuesta_examen/views/conversor_view.dart';
import 'package:propuesta_examen/viewmodel/conversor_viewmodel.dart';
import 'package:propuesta_examen/viewmodel/theme_provider.dart';

void main() {
  testWidgets('La vista Conversor muestra los elementos correctamente', (WidgetTester tester) async {
    // 1. Construir el Widget (Pump)
    // Necesitamos envolverlo en MultiProvider y MaterialApp con Localizations
    // porque tu código original depende de ellos.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => ConversorViewModel()),
        ],
        child: MaterialApp(
          // Configuración de idiomas necesaria para que no falle l10n
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale("es"), Locale("en")],
          locale: Locale("es"), // Forzamos español para el test
          home: Conversor(),
        ),
      ),
    );

    // Esperar a que todo renderice
    await tester.pumpAndSettle();

    // 2. Verificaciones (Assert)
    
    // Verificamos que existe el título (tomado del arb en español)
    // Nota: Asegúrate que tu app_es.arb tiene "appTitle": "Conversor"
    expect(find.text('Conversor'), findsOneWidget);

    // Verificamos que existe el campo de texto
    expect(find.byType(TextFormField), findsOneWidget);

    // Verificamos que existen los Dropdowns (hay 2)
    expect(find.byType(DropdownButton<String>), findsNWidgets(2));

    // Verificamos que existe el botón
    expect(find.byType(ElevatedButton), findsOneWidget);
    
    // Opcional: Introducir texto (Interacción)
    // await tester.enterText(find.byType(TextFormField), '100');
    // await tester.pump();
    // expect(find.text('100'), findsOneWidget);
    
    // NOTA: No pulsamos el botón "Convertir" en este test de Widget básico
    // porque intentaría llamar a la BBDD real y podría fallar sin configuración extra.
    // Para eso usaremos el test de integración.
  });
}