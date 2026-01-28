import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:similar_examen_eva2/l10n/app_localizations.dart';
import '../viewmodels/settings_view_model.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsVM = context.watch<SettingsViewModel>();
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // 1. Switch Modo Oscuro
        SwitchListTile(
          title: Text(l10n.labelDarkMode),
          value: settingsVM.isDarkTheme,
          onChanged: (val) => settingsVM.toggleTheme(val),
        ),
        Divider(),

        // 2. Dropdown Idioma
        ListTile(
          title: Text(l10n.labelLanguage),
          trailing: DropdownButton<Locale>(
            value: settingsVM.appLocale,
            items: [
              DropdownMenuItem(value: Locale('es'), child: Text('Español')),
              DropdownMenuItem(value: Locale('en'), child: Text('English')),
            ],
            onChanged: (val) {
              if (val != null) settingsVM.changeLanguage(val);
            },
          ),
        ),
        Divider(),

        // 3. Slider Tamaño Texto
        ListTile(
          title: Text(l10n.labelTextSize),
          subtitle: Slider(
            value: settingsVM.textScaleFactor,
            min: 0.8,
            max: 2.0,
            divisions: 6,
            label: settingsVM.textScaleFactor.toString(),
            onChanged: (val) => settingsVM.changeTextScale(val),
          ),
        ),
        Center(child: Text("Preview Text Size", style: TextStyle(fontSize: 16))),
      ],
    );
  }
}