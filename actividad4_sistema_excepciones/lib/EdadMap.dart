

/// Clase para manejar mapas de edades
class EdadMap {
  
  static void menuEdadMap() {
    Map<String, int> edades = {
      'Pedro': 20,
      'Ana': 25,
      'Juan': 30
    };

    int totalEdad = sumaEdad(edades);
    int nMaximo = numeroMaximo(edades);
    int nMinima = numeroMinima(edades);

    print("Suma todas las edades: $totalEdad");
    print("La edad máxima: $nMaximo");
    print("La edad mínima: $nMinima");
  }


  static int sumaEdad(Map<String, int> mapa) {
    int suma = 0;
    mapa.forEach((nombre, edad) {
      suma += edad;
    });
    return suma;
  }


  static int numeroMaximo(Map<String, int> mapa) {
    int maxima = mapa.values.first;
    mapa.forEach((nombre, edad) {
      if (maxima < edad) {
        maxima = edad;
      }
    });
    return maxima;
  }

  static int numeroMinima(Map<String, int> mapa) {
    int minima = mapa.values.first;
    mapa.forEach((nombre, edad) {
      if (minima > edad) {
        minima = edad;
      }
    });
    return minima;
  }
}
