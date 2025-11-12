import 'package:flutter/material.dart';

void main() {
  runApp(const name());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }


  
}
class name extends StatefulWidget {
    const name({super.key});
  
    @override
    State<name> createState() => _nameState();
  }
  
  class _nameState extends State<name> {
    @override
    Widget build(BuildContext context) {
      return Container();
    }
  }