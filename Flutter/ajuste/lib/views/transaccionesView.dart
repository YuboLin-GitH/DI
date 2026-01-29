import 'package:flutter/material.dart';



class transaccionesView extends StatefulWidget {
  const transaccionesView({super.key});

  @override
  State<transaccionesView> createState() => _transaccionesViewState();
}

class _transaccionesViewState extends State<transaccionesView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("👤 User Profile", style: TextStyle(fontSize: 24)),
    );
  }
}