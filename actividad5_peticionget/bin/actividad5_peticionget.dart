import 'package:http/http.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


void main() async {
  await obtenerPosts();
}


Future<void> obtenerPosts() async {
 
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  
  try {
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
    
      final data = jsonDecode(respuesta.body);
      print('ID: ${data['id']}');
      print('Título: ${data['title']}');
      print('Contenido: ${data['body']}');
    } else {
      print('Error. Código: ${respuesta.statusCode}');
    }
  } catch (e) {
    print('Hubo un error: $e');
  }
}