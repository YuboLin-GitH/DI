

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

  
  print(edades);
  int? valorAna = edades['Ana'];
  print(valorAna);

  int totalEdad = sumaEdad(edades);

  print(totalEdad);
  
}

  int sumaEdad(Map<String, int> mapa){
    int suma = 0;
    mapa.forEach((nombre, edad){
      suma += edad;
    });
    return suma;
  }



