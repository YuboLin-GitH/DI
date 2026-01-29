import 'package:examen_eva2_yubo/services/database_service.dart';
import 'package:examen_eva2_yubo/viewmodels/gestion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListadoScreen extends StatefulWidget {
  const ListadoScreen({super.key});

  @override
  State<ListadoScreen> createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  final DatabaseService _databaseService = DatabaseService();
  

  
  @override
  Widget build(BuildContext context) {
    final gestionvm = context.read<GestionViewModel>();
    final libroLista = gestionvm.libros;

    return ListView.builder(
              itemCount: libroLista.length,
              itemBuilder: (context, index) {
                final gestoLibros = libroLista[index];
                final esDisponible = gestoLibros['status'] == 0;

                final Color transaccionColor = esDisponible
                    ? Colors.red
                    : Colors.green;
                final IconData transaccionIcon = esDisponible
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded;

                return ListTile(
                  leading: Icon(transaccionIcon, color: transaccionColor),
                  title: Text(gestoLibros['author']),
                  subtitle: Text(
                    "${gestoLibros['author']} - ${gestoLibros['title']} ",
                  ),

                  trailing: Text((gestoLibros['data'])),
                );
              },
            );
  }
  
}