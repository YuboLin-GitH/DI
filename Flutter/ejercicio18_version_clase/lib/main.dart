import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: listaElementos()),
    );
  }
}




class listaElementos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => listaElementosState();
}




class listaElementosState extends State<listaElementos> {
  bool estado1 = false;
   bool estado2 = false;
    bool estado3 = false;

    String tarea1 = "Ejemolo1";
     String tarea2 = "Ejemolo2";
      String tarea3 = "Ejemolo3";
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(tarea1,
                  style: TextStyle(
                    color: estado1? Colors.grey : Colors.black ,
                    decoration: estado1 ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                    
            ),
          trailing: Checkbox(value: estado1, onChanged: (bool? value) {
              setState(() {
                estado1 = !estado1;
              });
          }),
        ),
        ListTile(
          title: Text(tarea2,
                  style: TextStyle(
                    color: estado2? Colors.grey : Colors.black ,
                    decoration: estado2? TextDecoration.lineThrough : TextDecoration.none,
                    ),),
          trailing: Checkbox(value: estado2, onChanged: (bool? value) {
             setState(() {
                estado2 = !estado2;
              });
          }),
        ),
        ListTile(
          title: Text(tarea3,
                  style: TextStyle(
                    color: estado3? Colors.grey : Colors.black ,
                    decoration: estado3 ? TextDecoration.lineThrough : TextDecoration.none,
                    ),),
          trailing: Checkbox(value: estado3, onChanged: (bool? value) {
             setState(() {
                estado3 = !estado3;
              });
          }),
        ),
      ],
    );
  }
}
