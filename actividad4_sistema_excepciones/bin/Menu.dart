import 'dart:io';
import 'package:actividad4_sistema_excepciones/Calculadora.dart';
import 'package:actividad4_sistema_excepciones/NumeroPrimo.dart';
import 'package:actividad4_sistema_excepciones/EdadMap.dart';

void main() {
  bool salir = false;
  while (!salir) {
    print("\n--- Menú Principal ---");
    print("1. Listar números primos");
    print("2. Calculadora básica");
    print("3. Estadísticas de edades");
    print("4. Salir");
    stdout.write("Selecciona una opción (1-4): ");
    String? input = stdin.readLineSync();
    int opcion = int.tryParse(input ?? '') ?? 0;

    switch (opcion) {
      case 1:
        NumeroPrimo.listaPrimos();
        break;
      case 2:
        Calculadora.menuCalculadora();
        break;
      case 3:
        EdadMap.menuEdadMap();
        break;
      case 4:
        print("Hasta luego!");
        salir = true;
        break;
      default:
        print("Opción no válida, intenta de nuevo.");
    }
  }
}
