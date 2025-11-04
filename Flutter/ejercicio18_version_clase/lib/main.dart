import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            ListTile(
              title: Text("Ejemolo1"),
              trailing:Checkbox(value: false, onChanged: (bool? value){}),
              
            ),
             ListTile(
              title: Text("Ejemolo1"),
              trailing:Checkbox(value: false, onChanged: (bool? value){}),
              
            ),
             ListTile(
              title: Text("Ejemolo1"),
              trailing:Checkbox(value: false, onChanged: (bool? value){}),
              
            ),
          ],
        ),
      ),
    );
  }
}
