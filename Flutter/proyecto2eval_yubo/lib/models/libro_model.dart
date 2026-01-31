class Libro {
  final int? id;
  final String titulo;
  final String autor;
  final String portada;
  final String detalle;
  final int leido; // 0: No, 1: Sí
  final int gusta; // 0: No, 1: Sí

  Libro({
    this.id,
    required this.titulo,
    required this.autor,
    this.portada = '',
    this.detalle = '',
    this.leido = 0,
    this.gusta = 0,
  });

  // Convertir un mapa en un objeto (leer desde una base de datos)
  factory Libro.fromMap(Map<String, dynamic> map) {
    return Libro(
      id: map['id'],
      titulo: map['titulo'],
      autor: map['autor'],
      portada: map['portada'] ?? '',
      detalle: map['detalle'] ?? '',
      leido: map['leido'],
      gusta: map['gusta'],
    );
  }

  // Convierte el objeto en un mapa (y guárdalo en la base de datos).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'portada': portada,
      'detalle': detalle,
      'leido': leido,
      'gusta': gusta,
    };
  }

  
}