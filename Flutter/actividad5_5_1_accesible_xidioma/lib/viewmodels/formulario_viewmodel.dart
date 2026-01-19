import 'package:flutter/material.dart';
import 'package:actividad5_5_1_accesible_xidioma/models/formulario_model.dart';


class FormularioViewmodel extends ChangeNotifier {
  String nombre ="";
  String correo = "";
  final nombreControlador = TextEditingController();
  final correoControlador = TextEditingController();


  //validarNombre
  String? validarNombre(String? valor){
    if(valor == null || valor.isEmpty){
        return "El campo esta vacio";
    }
    return null;
  }
  //validarcorreor
  String? validarCorreo(String? valor){
    if(valor==null || valor.isEmpty){
      return "El campo esta vacio";
    }
     final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if(!emailRegex.hasMatch(valor)){
      return "Pon un email valido";
    }
    return null;
  }

  //limpiarFormulario
  void LimpiaFormulario(){
    nombreControlador.clear(); 
    correoControlador.clear();
    nombre="";
    correo="";
    notifyListeners();
  }
  //enviarFormulario
  void enviarFormulario(String nombre , String correo){
      final contacto = ContactoFormulario(nombreControlador.text, correoControlador.text);

      print(contacto.toString());
      notifyListeners();
  }


  //telefono
  String? validarTelefono(String? valor){
    if(valor==null || valor.isEmpty){
      return "El campo esta vacio";
    }
    if(valor.length != 9  ) // || int.tryParse()
    return "Esta mal";
  }


}

