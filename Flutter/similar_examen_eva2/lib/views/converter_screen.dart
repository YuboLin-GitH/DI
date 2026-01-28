import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:similar_examen_eva2/l10n/app_localizations.dart';
import '../viewmodels/converter_view_model.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _controller = TextEditingController();
  String _fromUnit = 'Kilómetros';
  String _toUnit = 'Millas';
  String _resultText = '';

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ConverterViewModel>(); // Access VM
    final l10n = AppLocalizations.of(context)!;
    
    // Unidades disponibles (Claves del Map)
    final units = viewModel.conversionRates.keys.toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Input
          TextField(
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.labelValue,
              hintText: l10n.hintValue,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          
          // Dropdowns
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _fromUnit,
                  isExpanded: true,
                  items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                  onChanged: (val) => setState(() => _fromUnit = val!),
                ),
              ),
              Icon(Icons.arrow_forward),
              Expanded(
                child: DropdownButton<String>(
                  value: _toUnit,
                  isExpanded: true,
                  items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                  onChanged: (val) => setState(() => _toUnit = val!),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Botón Convertir
          ElevatedButton(
            onPressed: () async {
              bool success = await viewModel.convertAndSave(_controller.text, _fromUnit, _toUnit);
              
              if (success) {
                // Calcular visualmente para mostrar rápido (o leer de DB)
                double rate = viewModel.conversionRates[_fromUnit]![_toUnit]!;
                double val = double.parse(_controller.text);
                setState(() {
                  _resultText = "Resultado: ${(val * rate).toStringAsFixed(2)} $_toUnit";
                });
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.msgSuccess))
                );
                _controller.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.msgError), backgroundColor: Colors.red)
                );
              }
            },
            child: Text(l10n.btnConvert),
          ),
          
          SizedBox(height: 20),
          Text(
            _resultText,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}