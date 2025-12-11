import 'package:ejercicio35_mvvm_dificil/domain/entities/producto.dart';

class ProductoModel extends Producto{
  ProductoModel({required super.nombre , required super.precio})

  //FROMJSON

  //TOJSON

  Map<String, dynamic> toJSON(){
    return{
      'nombre': nombre,
      'precio': precio,
    };
  }

  
}