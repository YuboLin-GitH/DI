import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => PantallaA(),
      },
    );
  }
}
class PantallaA extends StatefulWidget{
  const PantallaA({super.key});

 @override
  State<StatefulWidget> createState() => PantallaALogin();
   
}


class PantallaALogin extends State<PantallaA>{

  TextEditingController nombreController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla A"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
          [
           TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: "Usuariox"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            ElevatedButton(onPressed:(){
             Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaB(
                      nombreUsuario: nombreController.text,
                    ),
                  ),
                );
              },
              child: Text("Iniciar Sesión"), 
            ),
         
          ]
         
      ),
    );
  }
  
}



class PantallaB extends StatelessWidget {
   final String nombreUsuario;
  const PantallaB({super.key, required this.nombreUsuario});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla B")),
      body: Center(
        child: Column(
          children: [
            Text("Bienvenido"),
            Text(nombreUsuario),
          ],
        ),
          
        
      ),
    );
  }
}