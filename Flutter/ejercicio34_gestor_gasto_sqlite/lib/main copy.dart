import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar la marca de debug
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Gestor de Finanzas"),
          backgroundColor: Colors.blueGrey,
        ),
        body: const Padding(padding: EdgeInsets.all(16.0), child: Formulario()),
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  bool esGasto = true;
  List<String> opcionesGasto = ["coche", "casa", "compra"];
  List<String> opcionesIngreso = ["salario", "donacion"];

  String? categoriaSeleccionada;

  final List<bool> selectedtipo = <bool>[false, true];

  TextEditingController cantidadCtrll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> opcion = esGasto ? opcionesGasto : opcionesIngreso;
    return Form(
      child: Column(
        children: [
          ToggleButtons(
            isSelected: [!esGasto, esGasto],
            selectedColor: Colors.amber,
            fillColor: esGasto ? Colors.green : Colors.red,
            onPressed: (int index) {
              setState(() {
                esGasto = index == 1;
                //Importante para vacia valor
                categoriaSeleccionada = null;
              });
            },
            children: [Text("Gasto"), Text("Ingreso")],
          ),
          DropdownButton(
            value: categoriaSeleccionada,
            items: opcion
                .map(
                  (categoria) => DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  ),
                )
                .toList(),
            onChanged: (valor) {
              setState(() {
                categoriaSeleccionada = valor;
              });
            },
          ),
          TextField(
            controller: cantidadCtrll,
            decoration: InputDecoration(labelText: "cantidad", suffixText: "€"),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: esGasto ? Colors.green : Colors.red,
            ),
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
