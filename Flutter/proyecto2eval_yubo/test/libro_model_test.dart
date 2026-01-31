import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto2eval_yubo/models/libro_model.dart'; 

void main() {
  group('Libro Model Test', () {
    test('Libro se crea correctamente desde Map', () {
      final map = {
        'id': 1,
        'titulo': 'Test Book',
        'autor': 'Tester',
        'portada': 'http://img.com',
        'detalle': 'Detalle test',
        'leido': 1,
        'gusta': 0
      };

      final libro = Libro.fromMap(map);

      expect(libro.id, 1);
      expect(libro.titulo, 'Test Book');
      expect(libro.leido, 1);
    });

    test('Libro se convierte correctamente a Map', () {
      final libro = Libro(
        id: 2,
        titulo: 'Map Test',
        autor: 'Author',
        portada: '',
        detalle: '',
      );

      final map = libro.toMap();

      expect(map['titulo'], 'Map Test');
      expect(map['gusta'], 0);
    });
  });
}