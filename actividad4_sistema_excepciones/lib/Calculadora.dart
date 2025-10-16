import 'dart:io';

/// Clase para una calculadora básica
class Calculadora {
  // Método estático para mostrar menú de calculadora
  static void menuCalculadora() {
    while (true) {
      print("\nCalculadora básica:");
      print("1. Suma");
      print("2. Resta");
      print("3. Volver al menú principal");
      stdout.write("Opción: ");
      String? entrada = stdin.readLineSync();
      int opcion = int.tryParse(entrada ?? '') ?? 0;

      if (opcion == 1 || opcion == 2) {
        stdout.write("Introduce el primer número: ");
        int? num1 = int.tryParse(stdin.readLineSync() ?? '');
        stdout.write("Introduce el segundo número: ");
        int? num2 = int.tryParse(stdin.readLineSync() ?? '');
        if (num1 == null || num2 == null) {
          print("Entrada no válida.");
          continue;
        }
        if (opcion == 1) {
          print("$num1 + $num2 = ${num1 + num2}");
        } else {
          print("$num1 - $num2 = ${num1 - num2}");
        }
      } else if (opcion == 3) {
        break;
      } else {
        print("Opción incorrecta.");
      }
    }
  }
}
