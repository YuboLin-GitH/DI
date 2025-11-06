import 'package:flutter/material.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatefulWidget {
   MainApp({super.key});
   
     @override
     State<StatefulWidget> createState() => Configurar();
}

class Configurar extends  State<StatefulWidget> {
   
  var estadoswitch = false;
  var modoClaroOscuro = ThemeMode.light;

      @override
        Widget build(BuildContext context) {
          return MaterialApp(
            darkTheme: ThemeData.dark(),
            themeMode: modoClaroOscuro,
            home: Scaffold(
              body: Center(
                child: Switch(
                  onChanged: (estado){
                    setState(() {
                      estadoswitch = estado;
                      if(estadoswitch){
                         modoClaroOscuro= ThemeMode.dark;
                      }
                      else{
                        modoClaroOscuro = ThemeMode.light;
                      }
                    });
                  },
                  value: estadoswitch,
                )
              ),
            ),
          );
        }
}
