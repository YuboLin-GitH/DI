import "dart:convert";
import "dart:io";

void main() async {
  var fichero = File("Prueba.txt");
  var directorio = fichero.parent;

  directorio.watch().listen(
    (event) {
      switch(event.type){
      case FileSystemEvent.create:
      print("El fichero ha sido creado ${event.path}");
      break;
      case FileSystemEvent.delete:
      print("El fichero ha sido borrado ${event.path}");
      break;
      case FileSystemEvent.modify:
      print("El fichero ha sido modificado ${event.path}");
      break;
      default:
      print("ha ocurrido algo ${event.path}");
      break;
    }
    if(event.type == FileSystemEvent){
      print("El fichero ha sido modificado : ${event.path}");
    }
    },
  );

  print("Has modificado");

/*
  // leer fichero una fila a una fila
  Stream<String> lineas = fichero.openRead()
    .transform(utf8.decoder)
    .transform(LineSplitter());

  lineas.listen((linea){
      print("Procesando la linea: $linea");
  });
*/
/*
  var contenido = await fichero.readAsString();
  print("El archivo tiene ${contenido.length} caracteres .");
*/

}
