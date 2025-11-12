import 'package:flutter/material.dart';

void main() { 
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PerfilPantalla(),
    );
  }
}

class PerfilPantalla extends StatefulWidget {
  const PerfilPantalla({super.key});

  @override
  _PerfilPantallaState createState() => _PerfilPantallaState();
}

class _PerfilPantallaState extends State<PerfilPantalla> {
  String nombreUsuario = "Nombre de Usuario";
  String descripcion = "Breve descripción aquí";
  
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombreController.text = nombreUsuario;
    _descripcionController.text = descripcion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:  NetworkImage('https://placehold.co/600x300.png'), 
                    fit: BoxFit.cover,
                  ),
                  color: Colors.blueAccent, 
                ),
              ),
              
              Positioned(
                left: 20,
                bottom: 0,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage('https://placehold.co/600x300.png'), 
                ),
              ),
            
              Positioned(
                left: 120,
                bottom: 28,
                child: Text(
                  nombreUsuario,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, shadows:[Shadow(blurRadius: 5, color: Colors.black26)]),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: _nombreController,
                  onChanged: (text) { nombreUsuario = text; },
                  decoration: InputDecoration(labelText: "Nombre de usuario"),
                ),
                TextField(
                  controller: _descripcionController,
                  onChanged: (text) { descripcion = text; },
                  decoration: InputDecoration(labelText: "Descripción"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Guardar"),
                ),
                SizedBox(height: 12),
              
                Text(
                  descripcion,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
