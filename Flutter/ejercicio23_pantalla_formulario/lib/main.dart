import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/': (context) => PantallaA(), 
      },
      debugShowCheckedModeBanner: false,
    );
  }
}




class PantallaA extends StatelessWidget {
  PantallaA({super.key});

  TextEditingController controller = TextEditingController();

  var nombre = "Invidado";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla A " + nombre)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("PantallaA"),
          TextField(
            controller: controller,
            onChanged: (text){
              nombre = text;
            },
              decoration: InputDecoration(
                labelText: "Introduce tu nombre",
              ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  PantallaB(nombre: nombre))
              );
            },
            child: Text("B"),
          ),
        ],
      ),
    );
  }
}

class PantallaB extends StatelessWidget {
  var nombre = "";
  PantallaB({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla B")),
      body: Center(

        child: Column(
        children: [
          Text("Nombre de Usuario "+ nombre),
           ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Volver a Pantalla A"),
        )
        ]
        ),
      ),
    );
  }
}
