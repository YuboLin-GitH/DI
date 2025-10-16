

void main(){
  int valorInicial = 10;
  int valorFinal = 0;

  /*
  Stream<int> temporizador = 
  */

  Stream.periodic(Duration(seconds: 1), (tick) =>valorInicial - tick)
    .takeWhile((valor) => valor >= valorFinal)
    .forEach((valor){
      print("Numero: $valor");
    });
/*
  temporizador.listen((numero){
    print("Numero: $numero");
  });
  */
}