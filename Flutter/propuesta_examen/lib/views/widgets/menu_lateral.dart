import 'package:flutter/material.dart';
import 'package:propuesta_examen/l10n/app_localizations.dart';
import 'package:propuesta_examen/views/conversor_view.dart';
import 'package:propuesta_examen/views/transacciones_view.dart';
import 'package:propuesta_examen/views/settings_view.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              l10n.menu,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.double_arrow),
            title: Text(l10n.appTitle),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Conversor()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text(l10n.transactions),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Transacciones()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(l10n.settings),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
        ],
      ),
    );
  }
}
