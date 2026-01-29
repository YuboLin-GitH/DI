import 'package:flutter/material.dart';
import 'package:propuesta_examen/l10n/app_localizations.dart';
import 'package:propuesta_examen/views/widgets/menu_lateral.dart';
import 'package:propuesta_examen/models/transacciones_model.dart';
import 'package:propuesta_examen/viewmodel/transacciones_viewmodel.dart';

class Transacciones extends StatefulWidget {
  const Transacciones({super.key});

  @override
  State<Transacciones> createState() => _TransaccionesState();
}

class _TransaccionesState extends State<Transacciones> {
  late Future<List<TransaccionesModel>> _transaccionesList;

  @override
  void initState() {
    super.initState();
    _refreshTransactions();
  }

  void _refreshTransactions() {
    setState(() {
      _transaccionesList = DatabaseService.instance.getAllTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.transactions), centerTitle: false),
      drawer: MenuLateral(),
      body: FutureBuilder<List<TransaccionesModel>>(
        future: _transaccionesList,
        builder: (context, snapshot) {
          //Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          //Error
          if (snapshot.hasError) {
            return Center(child: Text("Error al cargar datos"));
          }
          //Sin datos
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay transacciones guardadas"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(
                    "${item.inputValue} ${item.inputUnit} -> ${item.outputUnit}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${l10n.result}: ${item.result.toStringAsFixed(4)}",
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await DatabaseService.instance.deleteTransaction(
                        item.id!,
                      );
                      _refreshTransactions();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Transaccion eliminada")),
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
