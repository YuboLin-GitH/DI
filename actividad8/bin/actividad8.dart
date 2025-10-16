


/*
Descarga una imagen desde una URL usando la librería http y guarda el archivo en el
sistema de archivos. Asegúrate de utilizar await para esperar la descarga antes de
continuar.
 */
void main() async {
  var fichero = imagen("Imagen.png");

  var url =
      Uri.http('placehold.co', '/todos/1');

}
