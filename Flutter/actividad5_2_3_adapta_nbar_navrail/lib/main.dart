import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true), // Aseguramos Material 3
      home: const _ScaffoldCambianState(),
    );
  }
}


class _ScaffoldCambianState extends StatefulWidget {
  const _ScaffoldCambianState({super.key});

  @override
  State<_ScaffoldCambianState> createState() => __ScaffoldCambianStateState();
}

class __ScaffoldCambianStateState extends State<_ScaffoldCambianState> {

  int _selectedIndex = 0;
  
  
  final List<Widget> _pantallas = const [
    Home(),
    Perfil(), 
    Ajustes(),
  ];


  final List<Map<String, dynamic>> _destinos = [
    {'icon': Icons.home_outlined, 'iconSelect': Icons.home,'label': 'Home'},
    {'icon': Icons.person_outlined, 'iconSelect': Icons.person,'label': 'Perfil'},
    {'icon': Icons.settings_outlined,'iconSelect': Icons.settings, 'label': 'Ajustes'},
  ];
  @override
  Widget build(BuildContext context) {
    final anchura = MediaQuery.sizeOf(context).width;

    return Scaffold(
      bottomNavigationBar: anchura < 600 ? 
        NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
                setState(() => _selectedIndex = index);
              },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_outlined),selectedIcon: Icon(Icons.home), label: "home"),
            NavigationDestination(icon: Icon(Icons.person_outline),selectedIcon: Icon(Icons.person), label: "Perfil"),
            NavigationDestination(icon: Icon(Icons.settings_outlined),selectedIcon: Icon(Icons.settings), label: "Ajustes"),
          ]
        )
          :
        null
      ,
      body: Row(children: [
        if (anchura >= 600)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() => _selectedIndex = index);
              },
              labelType: NavigationRailLabelType.all,
              // Generamos los items desde la MISMA lista compartida
              destinations: _destinos.map((item) {
                return NavigationRailDestination(
                  icon: Icon(item['icon']),
                  selectedIcon: Icon(item['iconSelect']),
                  label: Text(item['label']),
                );
              }).toList(),
            ),
            if (anchura >= 600) const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pantallas[_selectedIndex],
          ),
      ],),
    );
  }
}





class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Pantalla Home")),
    );
  }
}



class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Pantalla Perfil")),
    );
  }
}


class Ajustes extends StatelessWidget {
  const Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Pantalla Ajustes")),
    );
  }
}