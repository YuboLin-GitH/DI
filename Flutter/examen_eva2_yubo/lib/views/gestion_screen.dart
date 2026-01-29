import 'package:examen_eva2_yubo/l10n/app_localizations.dart';
import 'package:examen_eva2_yubo/viewmodels/gestion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestionScreen extends StatefulWidget {

  @override
  State<GestionScreen> createState() => _GestionScreenState();
}

class _GestionScreenState extends State<GestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final valorTitulo = TextEditingController();
  final valorAutor = TextEditingController();
  int valorEstado = 0;
  final List<bool> _selectedtipo = <bool>[true, false];
  String tipoGenre = 'genero';

  String? _generoSeleccionada;
  
  Map<String, List<String>> geneloLibro = {
    'genero': ['Novela', 'Ensayo', 'Ciencia', 'Fantasia'],

  };
  
  @override
  void initState() {
    super.initState();
    _generoSeleccionada = geneloLibro[tipoGenre]!.first;
  }



  void _clearFields() {
    valorTitulo.clear();
    valorAutor.clear();
  }


  @override
  Widget build(BuildContext context) {
    final gestionvm = context.read<GestionViewModel>();
    
    final l10n = AppLocalizations.of(context)!;
    List<Widget> tipo = <Widget>[Text(l10n.disponible), Text(l10n.prestado)];
    
    return Column(
       children: [
          Form(
            key: _formKey,

            child: Column(
              children: [
                
                TextFormField(
                    controller: valorTitulo,
                    decoration: InputDecoration(labelText: l10n.titulo),
                    validator: (value) => gestionvm.validateTitulo(value),
                ),
                const SizedBox(width: 5),
                
                TextFormField(
                    controller: valorAutor,
                    decoration: InputDecoration(labelText: l10n.autor, border: OutlineInputBorder(),),
                    validator: (value) => gestionvm.validateAutor(value),
                  ),
                
              

                DropdownButton<String>(
                  value: _generoSeleccionada,
                  hint: Text("Selecciona un genero"),
                  items: geneloLibro[tipoGenre]!
                      .map(
                        (genero) => DropdownMenuItem(
                          value: genero,
                          child: Text(genero),
                        ),
                      )
                      .toList(),
                  onChanged: (valor) {
                    setState(() {
                      _generoSeleccionada = valor;
                    });
                  },
                ),

                ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _selectedtipo.length; i++) {
                          _selectedtipo[i] = i == index;
                        }
                        if (index == 0) {
                           valorEstado = 0;
                        } else {
                          valorEstado = 1;
                        }
                         
                      });
                    },
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: _selectedtipo[0]
                        ? Colors.red[300]
                        : Colors.green[300],
                    color: Colors.black,
                    constraints: BoxConstraints(
                      minHeight: 30.0,
                      minWidth: 120.0,
                    ),
                    isSelected: _selectedtipo,
                    children: tipo,
                  ),                

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text("Libro añadido!!!")),
                       );
                       
                       gestionvm.insertLibro(valorAutor.text, valorAutor.text, _generoSeleccionada.toString(), valorEstado, "date");
                    }
                  },

                  child: Text(l10n.btGuarda),
                ),
              ],
            ),
          ),
        ]
    );
  }
}