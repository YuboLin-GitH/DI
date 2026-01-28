import 'package:actividad_repaso_examen_eva2/l10n/app_localizations.dart';
import 'package:actividad_repaso_examen_eva2/viewmodels/SettingsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsViewModel>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. 暗黑模式开关
          SwitchListTile(
            title: Text(l10n.darkMode),
            value: settings.isDark,
            onChanged: (val) => settings.toggleTheme(val),
          ),
          
          const Divider(),

          // 2. 语言选择 (Dropdown)
          ListTile(
            title: Text(l10n.language),
            trailing: DropdownButton<String>(
              value: settings.currentLocale.languageCode,
              items: const [
                DropdownMenuItem(value: 'es', child: Text('Español')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (val) {
                if (val != null) settings.changeLanguage(val);
              },
            ),
          ),

          const Divider(),

          // 3. 字体大小 (Slider)
          ListTile(
            title: Text("${l10n.textSize}: ${settings.textSize.toStringAsFixed(1)}"),
            subtitle: Slider(
              min: 0.8,
              max: 2.0,
              divisions: 6,
              value: settings.textSize,
              onChanged: (val) => settings.changeTextSize(val),
            ),
          ),
        ],
      ),
    );
  }
}