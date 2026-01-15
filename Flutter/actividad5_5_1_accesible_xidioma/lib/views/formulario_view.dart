import 'package:actividad5_5_1_accesible_xidioma/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:actividad5_5_1_accesible_xidioma/viewmodels/formulario_viewmodel.dart';
import 'package:provider/provider.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final formularioKey =  GlobalKey<FormState>();

  final nombreControlador = TextEditingController();
  final correoControlador = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = context.watch<FormularioViewmodel>();
    return Scaffold(

      body: 
      SingleChildScrollView(
        key: formularioKey,
        child: Column(
        children: [
          TextFormField(
            controller: nombreControlador,
            decoration: InputDecoration(labelText: l10n.nombreLabel , hintText: l10n.nombreHint),
            validator: viewModel.validarNombre,
          ),

          TextFormField(
            controller: correoControlador,
            decoration: InputDecoration(labelText: l10n.correoLaber, hintText: l10n.correoHint ),
            validator: viewModel.validarCorreo,
          ),
          
          OutlinedButton(onPressed: (){
            if(formularioKey.currentState?.validate() == true){
              viewModel.enviarFormulario(nombreControlador.text, correoControlador.text);
            }
          }, child: Text(l10n.botonEnviar)),
          OutlinedButton(onPressed: (){viewModel.LimpiaFormulario();}, child: Text(l10n.botonLimpiar))
        ],
      )),
    );
  }
}