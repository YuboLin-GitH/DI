import 'dart:io';

void main(){

  print("Introduce un numero entero para sale lista de numero primo");
  String? entrada = stdin.readLineSync();


  int numeroMaximo = int.parse(entrada!);
  int numeroPrueba = 1;
  
  while(numeroPrueba <= numeroMaximo){

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
