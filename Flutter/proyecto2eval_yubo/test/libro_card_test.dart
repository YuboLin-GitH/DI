import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto2eval_yubo/models/libro_model.dart';

void main() {

  final libroTest = Libro(
    id: 1,
    titulo: 'Flutter Avanzado',
    autor: 'Yubo',
    portada: '', 
    leido: 0,
    gusta: 1, 
  );

  testWidgets('La tarjeta del libro muestra título y autor correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Card(
            child: Column(
              children: [
                Text(libroTest.titulo),
                Text(libroTest.autor),
                Icon(
                  libroTest.gusta == 1 ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );

 
    final tituloFinder = find.text('Flutter Avanzado');
    final autorFinder = find.text('Yubo');
    final iconFinder = find.byIcon(Icons.favorite);


    expect(tituloFinder, findsOneWidget); //Debo encontrar 1
    expect(autorFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });
}