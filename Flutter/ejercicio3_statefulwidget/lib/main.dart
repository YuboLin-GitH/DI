import 'package:flutter/material.dart';


/*Implementa un StatefulWidget que incremente el contador
al presionar el botón. ¿Se podría hacer con un StatelessWidget?*/
void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  int _counter = 0; // ATRIBUTO CONTADOR INICIALIZADO EN 0

  void _incrementCounter() {
    setState(() {
      _counter++;// INCREMENTAMOS EL CONTADOR
    });
  }

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(title: Text('Contador simple')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Presiona el botón: $_counter veces'),

            // AÑADIR UN ESPACIO ENTRE EL TEXTO Y EL BOTON DE 10
            const SizedBox(
              height: 10,
            ),

              ElevatedButton(

                // SE LLAMA A LA FUNCION INCREMENTAR CUANDO SE PULSA EL BOTON
                onPressed: _incrementCounter,
                child: Text('Botón +1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
