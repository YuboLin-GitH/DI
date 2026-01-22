import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 
            MediaQuery.sizeOf(context).width < 600 ? 1 :
            (MediaQuery.sizeOf(context).width <= 840 ? 2 : 4),
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              
              color: index %2 ==0 ? Colors.red : Colors.blue,
              child: Text("no no no"),
            );
          },
        ),
        ),
    );
  }
}


/*
 itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("no no no")
            );
          },

*/ 
