import 'package:flutter/material.dart';

void main() {
  runApp(DescargaApp());
}

// Aplicación principal
class DescargaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progreso de descarga',
      theme: ThemeData(primarySwatch: Colors.green),
      home: DescargaPage(),
    );
  }
}

// Página principal con barra de progreso
class DescargaPage extends StatefulWidget {
  @override
  State<DescargaPage> createState() => _DescargaPageState();
}

class _DescargaPageState extends State<DescargaPage> {
  // Variable que guarda el progreso (0.0 a 1.0)
  double progreso = 0.0;

  // Función que aumenta el progreso cada vez que se presiona el botón
  void _aumentarProgreso() {
    setState(() {
      progreso += 0.2; // Aumenta 20%
      if (progreso > 1.0) progreso = 0.0; // Reinicia al llegar al 100%
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simular Descarga')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Barra de progreso:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // Barra que muestra el progreso actual
            LinearProgressIndicator(value: progreso),
            const SizedBox(height: 20),
            // Botón para aumentar el progreso
            ElevatedButton(
              onPressed: _aumentarProgreso,
              child: const Text('Aumentar progreso'),
            ),
            const SizedBox(height: 10),
            // Muestra el porcentaje numérico
            Text('${(progreso * 100).round()}% completado'),
          ],
        ),
      ),
    );
  }
}
