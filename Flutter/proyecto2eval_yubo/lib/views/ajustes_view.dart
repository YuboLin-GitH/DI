import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto2eval_yubo/viewmodels/settings_view_model.dart';


/// Pantalla de ajustes de la aplicación.
///
/// Permite:
/// - Cambiar el tema (claro / oscuro)
/// - Ajustar el tamaño del texto
class AjustesScreen extends StatefulWidget {
  const AjustesScreen({super.key});

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsVM = context.watch<SettingsViewModel>();
    final esOscuro = settingsVM.esOscuro;
    final currentScale = settingsVM.fontSize;
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes")),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Tema Oscuro"),
              trailing: Switch(
                onChanged: (_) => context.read<SettingsViewModel>().toggleTheme(),
                value: settingsVM.esOscuro,
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),

          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Text(
                "Tamaño de texto: ${currentScale.toStringAsFixed(1)}",
              ),
              subtitle: Slider(
                min: 10,
                max: 14,
                divisions: 4,
                value: currentScale,
                onChanged: (value) {
                  settingsVM.setFontSizeScale(value);
                },
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
