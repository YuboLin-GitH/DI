import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:propuesta_examen/l10n/app_localizations.dart';
import 'package:propuesta_examen/views/widgets/menu_lateral.dart';
// Importamos el ViewModel nuevo
import 'package:propuesta_examen/viewmodel/conversor_viewmodel.dart';

class Conversor extends StatefulWidget {
  const Conversor({super.key});

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  // El controller se queda en la vista porque es un elemento de UI efímero
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Accedemos al ViewModel
    final vm = Provider.of<ConversorViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), centerTitle: true),
      drawer: MenuLateral(),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text(l10n.enterValue),
                  border: OutlineInputBorder(),
                ),
              ),
              // Dropdown 1 usando datos del VM
              DropdownButton<String>(
                value: vm.dropdownValue,
                onChanged: (String? value) {
                  vm.setDropdownValue(value);
                },
                items: vm.unidades.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              // Dropdown 2 usando datos del VM
              DropdownButton<String>(
                value: vm.dropdownValue2,
                onChanged: (String? value) {
                  vm.setDropdownValue2(value);
                },
                items: vm.unidades.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Capturamos el resultado de la operación (true/false)
                  bool exito = await vm.convertirYGuardar(_controller.text);

                  if (context.mounted) {
                    if (exito) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Transacción guardada exitosamente"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // Mensaje de error si la validación falla
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Por favor, introduce un número válido",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text(l10n.convertSave),
              ),
              Text(
                "${l10n.result}: ${vm.resultado} ${vm.dropdownValue2}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
