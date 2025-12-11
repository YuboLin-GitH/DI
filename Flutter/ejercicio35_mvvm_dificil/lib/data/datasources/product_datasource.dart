import 'dart:convert';

import 'package:flutter/services.dart';

class ProductDataSource {
  //OBTENER PRODUCTOS

  Future<List<dynamic>> fetchPosts() async {
    var response = await rootBundle.loadString('assets/producto.json');
    return jsonDecode(response) as List<dynamic>;
  }
}

