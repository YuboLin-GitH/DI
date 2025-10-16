import 'dart:io';
void main(){

  bool quiereSalir = false;
  
  while(quiereSalir == false){
  print("Menu de calculadora básica(Elegir entre 1-3)");
  print("1. Suma");
  print("2. Restar");
  print("3. Salir");

  String? entrada = stdin.readLineSync();
  int opcion = int.parse(entrada!);

  switch(opcion){
    case 1 :
          print("-------Has elegido Suma(+)-------------------");
          print("Introduce primero numero para suma: ");
          String? eNumero1 = stdin.readLineSync();
          int numero1 = int.parse(eNumero1!);
           print("Introduce segundo numero para suma: ");
          String? eNumero2 = stdin.readLineSync();
          int numero2 = int.parse(eNumero2!);
          int suma = numero1 + numero2;
          print("Suma de $numero1  + $numero2 = $suma");
          break;
    case 2 :
       print("-------Has elegido Resta(-)-------------------");
          print("Introduce primero numero para suma: ");
          String? eNumero1 = stdin.readLineSync();
          int numero1 = int.parse(eNumero1!);
           print("Introduce segundo numero para suma: ");
          String? eNumero2 = stdin.readLineSync();
          int numero2 = int.parse(eNumero2!);
          int resta = numero1 - numero2;
          print("Suma de $numero1  - $numero2 = $resta");
          break;
    case 3 :
        print("Adios");
        quiereSalir = true;
        break;
    default:
          print("Opcion no es 1, 2 o 3" );
        
  }

  } 



}