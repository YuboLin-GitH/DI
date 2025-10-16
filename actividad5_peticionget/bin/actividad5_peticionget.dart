import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  
  var url =
      Uri.http('jsonplaceholder.typicode.com', '/todos/1');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    print(jsonResponse);
   /* var itemCount = jsonResponse['totalItems'];
   print('Number of books about http: $itemCount.');
    */ 
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}