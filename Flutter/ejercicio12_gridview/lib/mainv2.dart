import 'package:flutter/material.dart';
/*EJERCICIO 12: Crea una galería de imágenes en una cuadrícula usando GridView.
Aplica padding a cada imagen y un borde redondeado usando BoxDecoration.*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 12',
      debugShowCheckedModeBanner: false, // QUITAR MARCA DEBBUG
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GalleryPage(title: 'Ejercicio 12 Pagina 52'),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Ejercicio 12 Página 52",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          padding: EdgeInsets.all(30),
          // AÑADIR UN PADDING A LAS FOTOS

          children: [
        // 1. Switch Modo Oscuro
        SwitchListTile(
          title: Text(l10n.modoOscuro),
          value: settingsVM.isDarkTheme,
          onChanged: (val) => settingsVM.toggleTheme(val),
        ),
        Divider(),

        CartaWidget(titulo: l10n.idioma),
        // 2. Dropdown Idioma
        ListTile(
          title: Text(l10n.idioma),
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
          title: Text(l10n.tamanioTexto),
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
        ),
      ),
    );
  }
}

class PlantillaImagen extends StatelessWidget {
  final String imageName;

  const PlantillaImagen(this.imageName, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // PERMITE AGREGAR UN BORDE REDONDEADO A LA IMAGEN
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/$imageName',
        // SE PONE BoxFit PARA QUE SE AJUSTE AL ESPACIO DISPONIBLE
        fit: BoxFit.cover, // NO SE PONE EL TAMAÑO PORQUE EL GRIDVIEW YA LO GESTIONA
      ),
    );
  }
}