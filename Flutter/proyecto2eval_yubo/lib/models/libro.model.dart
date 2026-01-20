class Libro {
  String titulo;
  String autor;
  int leido;

  Libro(this.titulo, this.autor, this.leido);


  String toString(){
    return "Titulo : $titulo , Nombre: $autor";
  }
}