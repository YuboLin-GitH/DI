import 'package:actividad_repaso_examen_eva2_2/viewmodels/PerfilViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PerfilCard extends StatelessWidget {
 
  Widget build(BuildContext context) {
    final perfilVM = Provider.of<PerfilViewModel>(context);

    return Stack(
      alignment: Alignment.center,
      children:[
        Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
          top: 10,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(perfilVM.perfil.photoUrl),
          ),
        ),
        Positioned(
          bottom: 10,
          child: Text(
            perfilVM.perfil.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            
          ),
        ),
      ]
 
    );
  }
}