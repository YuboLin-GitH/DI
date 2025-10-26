import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Titulo de ejecicio6')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Texto superior', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Texto A'),
                  Text('Texto B'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){},
                child: Text('Botón1'),
              ),
              ElevatedButton(
                onPressed: (){},
                child: Text('Botón2'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
