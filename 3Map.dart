

/*
 Define un Map que contenga pares clave-valor donde las claves sean los nombres
de personas y los valores sean la edad. Escribe una función que sume todas las
edades en el mapa y retorne el total. Luego, crea otra función que determine cuál es
la edad máxima y mínima en el mapa. Imprime los resultados.
 */


void main(){
    Map<String, int> edades = {
     'Pedro': 20,
     'Ana': 25,
     'Juan': 30
    };

  
  int totalEdad = sumaEdad(edades);
  int nMaximo =numeroMaximo(edades);
  int nMinima =numeroMinima(edades);
  
  print("Suma todas las edades:  $totalEdad");
  print("La edad máxima: $nMaximo");
  print("la edad mínima: $nMinima");
  
}

  // función que sume todas las edades en el mapa
  int sumaEdad(Map<String, int> mapa){
    int suma = 0;
    mapa.forEach((nombre, edad){
      suma += edad;
    });
    return suma;
  }


//función que determine cuál es la edad máxima
  int numeroMaximo(Map<String, int> mapa){
    int Maxima = mapa.values.first;
    mapa.forEach((nombre, edad){
      
      if(Maxima < edad){
        Maxima = edad;
      }
    });
    return Maxima;
  }

//función que determine cuál es la edad mínima
  int numeroMinima(Map<String, int> mapa){
    int Minima = mapa.values.first;
    mapa.forEach((nombre, edad){
      if(Minima > edad){
        Minima = edad;
      }
    });
    return Minima;
  }