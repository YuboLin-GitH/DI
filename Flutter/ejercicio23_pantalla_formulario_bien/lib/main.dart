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
 
  @override
  State<StatefulWidget> createState() => PantallaAState();
 
}
 
class PantallaAState extends State<PantallaA>{
  var nombre = "Invitado";
 
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Nombre: "+nombre),
          ElevatedButton(
            child: Text("Ir al fomrularo"),
            onPressed: () async{
              final resultado = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PantallaB()));
              setState(() {
                nombre = resultado;
              });
            }),
        ],
      )
    );
  }
}
 
class PantallaB extends StatelessWidget{
 
var nombre = "";
 
TextEditingController controller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FormularioNombre'),),
      body: Column(
        children: [
          Text("NOMBRE POR DEFECTO: "+nombre),
          TextField(
            controller: controller,
            onChanged: (text){
              nombre = text;
            }),
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context, nombre);
            },
            child: Text("Volver"),
            ),
        ],
      )
    );
  }
}
 