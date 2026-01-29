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

  @override
  void initState() {
    super.initState();
    // 页面初始化时，加载数据！否则列表是空的
    // 使用 PostFrameCallback 确保在构建完成后加载
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GestionViewModel>().loadDatos();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final gestionvm = context.watch<GestionViewModel>();
    final libroLista = gestionvm.libros;

    if (libroLista.isEmpty) {
      return Center(child: Text("No hay libro"));
    }

    return ListView.builder(
              itemCount: libroLista.length,
              itemBuilder: (context, index) {
                final libro = libroLista[index];
                final esDisponible = libro.status == 0;

                final Color transaccionColor = esDisponible
                    ? Colors.red
                    : Colors.green;
                final IconData transaccionIcon = esDisponible
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded;

                return ListTile(
                  leading: Icon(transaccionIcon, color: transaccionColor),
                  title: Text(libro.title),
                  subtitle: Text(
                    ("${libro.author} - ${libro.genre}"),
                  ),

                  trailing: Text((libro.date)),
                );
              },
            );
  }
  
}