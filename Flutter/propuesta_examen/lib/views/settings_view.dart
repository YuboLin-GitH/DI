import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:propuesta_examen/l10n/app_localizations.dart';
import 'package:propuesta_examen/views/widgets/menu_lateral.dart';
import 'package:propuesta_examen/viewmodel/theme_provider.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<DropdownMenuItem<String>> lenguajes = [
    DropdownMenuItem(value: "es", child: Text("Español")),
    DropdownMenuItem(value: "en", child: Text("Inglés")),
  ];
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings), centerTitle: true),
      drawer: MenuLateral(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 10),
          Card(
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SwitchListTile(
                  title: Text(l10n.darkTheme),
                  value: themeProvider.isDark,
                  onChanged: (bool value) {
                    themeProvider.toggleTheme();
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ListTile(
                  title: Text(l10n.language),
                  trailing: DropdownButton<String>(
                    value: themeProvider.locale.languageCode,
                    items: lenguajes,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          themeProvider.setLanguage(newValue);
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(l10n.textSize),
                      trailing: Text(
                        "${(themeProvider.textSize * 100).toInt()}%",
                      ),
                    ),
                    Slider(
                      value: themeProvider.textSize,
                      min: 0.8,
                      max: 2.0,
                      divisions: 6,
                      label: "${(themeProvider.textSize * 100).toInt()}%",
                      onChanged: (double value) {
                        themeProvider.setTextSize(value);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
