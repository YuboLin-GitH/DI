import 'package:flutter/material.dart';
import 'package:nav_latera/viewmodels/change_theme_provider.dart';
import 'package:nav_latera/views/MainScreen.dart';
import 'package:provider/provider.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late var isEncendido = false;
  late ThemeData themeData = ThemeData.dark();

  String languageSelected = "EN";
  double minTextSize = 10;
  double maxTextSize = 30;
  double valueTextSize = 10;

  List<DropdownMenuItem> language = [
    DropdownMenuItem(
      value: "EN",
      child: Text("English"),
    ),
    DropdownMenuItem(
      value: "ES",
      child: Text("Español"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainScreen(),
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Card(
              shadowColor: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark Theme"),
                  Switch(
                      value: isEncendido,
                      onChanged: (value) {
                        setState(() {
                          if (isEncendido) {
                            themeData = ThemeData.light();
                          } else {
                            themeData = ThemeData.dark();
                          }
                        });
                        // GUARDAR LOS DATOS DEL TEMA EN EL ESTADO GLOBAL
                        final currentTheme = Provider.of<ChangeThemeProvider>(this.context, listen: false);
                        currentTheme.setTheme(themeData); // SE ACTUALIZA EL ESTADO GLOBAL
                        isEncendido = !isEncendido;
                      }),
                ],
              ),
            ),
          ),
          ListTile(
            title: Card(
              shadowColor: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Language"),
                  DropdownButton(
                      items: language,
                      onChanged: (value) {
                        setState(
                          () {
                            languageSelected = value.toString();
                          },
                        );
                      },
                      value: languageSelected)
                ],
              ),
            ),
          ),
          ListTile(
            title: Card(
              shadowColor: Colors.grey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Text Size")),
                  Slider(
                      min: minTextSize,
                      max: maxTextSize,
                      value: valueTextSize,
                      onChanged: (value) {
                        setState(() {
                          valueTextSize = value;
                        });
                        print('');
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
