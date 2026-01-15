import 'package:flutter/material.dart';
import 'package:actividad5_5_1_accesible_xidioma/views/formulario_view.dart';
import 'package:actividad5_5_1_accesible_xidioma/models/formulario_model.dart';


class FormularioViewmodel extends ChangeNotifier {
  String nombre ="";
  String correo = "";
  


  //validarNombre
  String? validarNombre(String? valor){
    if(valor == null || valor.isEmpty){
        return "El campo esta vacio";
    }
    
  }
  //validarcorreor
  String? validarCorreo(String? valor){
    if(valor==null || valor.isEmpty){
      return "El campo esta vacio";
    }
     final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if(emailRegex.hasMatch(valor)){
      return "Pon un email valido";
    }
  }

  //limpiarFormulario
  void LimpiaFormulario(){
  
    nombre="";
    correo="";
    notifyListeners();
  }
  //enviarFormulario
  void enviarFormulario(String nombre , String correo){
      final contacto = ContactoFormulario(nombre, correo);

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

