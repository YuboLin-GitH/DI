import 'dart:io';


// Genera una lista de números primos hasta el que el usuario introduzca por consola.
void main(){


 //Introducir datos
  print("Introduce un numero entero para sale lista de numero primo");
  String? entrada = stdin.readLineSync();


  //Comprobar DATO  
  int numeroMaximo = int.parse(entrada!);
  
  

  //Bucle hasta el número
  int numeroPrueba = 1;
  while(numeroPrueba <= numeroMaximo){
  
  //Calcular primo o no cada número
      if(numeroPrueba == 1){
        print("$numeroPrueba no es primo");
      }

      if(numeroPrueba == 2){
        print("$numeroPrueba es primo");
      }

      bool esPrimo =true;
      
      if(numeroPrueba > 2){
            int i= 2;
            int veces =0;
            for(i; i< numeroPrueba; i++){
                if(numeroPrueba%i== 0){
                veces++;
                }
            }
            if(veces >= 1){
              esPrimo = false;
            }
            var primo = (esPrimo)? "$numeroPrueba es primo": "$numeroPrueba no es primo";
            print(primo);
      }
      
    numeroPrueba++;
  }

}
