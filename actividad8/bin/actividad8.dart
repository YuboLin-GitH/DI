import 'dart:io';
import 'package:http/http.dart' as http;

/*
Descarga una imagen desde una URL usando la librería http y guarda el archivo en el
sistema de archivos. Asegúrate de utilizar await para esperar la descarga antes de
continuar.
 */
void main() async {

  var url =
      Uri.http('placehold.co', '/600x400/png');
  var response = await http.get(url);
   if (response.statusCode == 200) {
    var fichero = File("imagen.png");

    fichero.writeAsBytes(response.bodyBytes);

   } else{
    print("Falta with status: ${response.statusCode}.");
    }
}
