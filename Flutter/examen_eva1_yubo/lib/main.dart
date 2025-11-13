import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Examen de Yubo',
      debugShowCheckedModeBanner: false,  // quitar Debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeNavScreen(),
    );
  }
}




class HomeNavScreen extends StatefulWidget {
  const HomeNavScreen({super.key});

  @override
  State<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends State<HomeNavScreen> {
  int _selectedIndex = 0; // INDICE ACTUAL DEL BOTTOM NAVIGATION BAR


 // LISTA DE WIDGETS PARA CADA PANTALLA
  final List<Widget> _screens = [
    HomeScreen(),
    FeedScreen(),
    SettingsScreen(),
  ];



  void _onItemTapped(int index) { 
    setState(() {
      _selectedIndex = index;// ACTUALIZA EL INDICE
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Generar'),
            BottomNavigationBarItem(icon: Icon(Icons.app_registration),label: 'Feed',),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Opciones'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
    );
  }
}


// PANTALLAS Generar


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _tema = 'tecnologia'; 
  
  int _numero = 0;
  String valorHashtag="";
  String valorAutor= "";


    // Expresión regular para validar formato de Autor
  final RegExp regularAutor = RegExp(
    r'^@[A-Za-z0-9_]{3,15}$',
  );

    // Expresión regular para validar formato de Hashtag
  final RegExp regularHashtag = RegExp(
    r'^#[A-Za-z0-9_]{2,20}$',
  );





   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
         
        child: Card(
          child: ListView( 
            children: [
              
              //Tema de Generar
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Tema'),
                items: const [
                  DropdownMenuItem(
                    value: 'tecnologia',
                    child: Text('Tecnología'),
                  ),
                  DropdownMenuItem(
                    value: 'juegos',
                    child: Text('Juegos'),
                  ),
                   DropdownMenuItem(
                    value: 'deportes',
                    child: Text('Deportes'),
                  ),
                ],
  
                onChanged: (value) {
                  setState(() {
                    _tema = value!;
                  });
                },
                
              ),

              const SizedBox(height: 24),

               TextFormField(
                decoration: const InputDecoration(labelText: 'Número de posts (1-20)'),
                keyboardType: TextInputType.number, // solo tipo numero.
                
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Numero no puede estar vacío';
                }
                if (value as int  < 1 || value as int > 20 ) { 
                  return 'Numero deber ser dentro de 1 hasta 20';
                }
                return value; 
                },

                onSaved: (value) {
                  _numero = value! as int;
                },
                
              ),
              
            const SizedBox(height: 24),

                // Parte Hashtag
               TextFormField(
                decoration: const InputDecoration(labelText: 'Hashtag (opcional, ej: #flutter )'),
                
                validator: (value) {
                if (!regularHashtag.hasMatch(value!)) {
                  return 'Deber ser bien formado -> #XXX';
                }
            
                return value; 
                },

                onSaved: (value) {
                  valorHashtag = value!;
                },
                
              ),
        
           
            const SizedBox(height: 24),

              //Parte Autor preferido

               TextFormField(
                decoration: const InputDecoration(labelText: 'Autor preferido (opcional, ej: @javier)'),
                keyboardType: TextInputType.number, // solo tipo numero.
                
                validator: (value) {
                if (!regularAutor.hasMatch(value!)) {
                  return 'Deber ser bien formado -> @XXX';
                }
               
                return value; 
                },

                onSaved: (value) {
                  valorAutor = value! ;
                },
                
              ),
              
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(
                    onPressed: (){
                       
                    },
                    child: const Text('Generar feed'),
                  ),  
              ],
            ),

            const SizedBox(height: 24,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   ElevatedButton(
                    onPressed: (){
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaDeTec()));
                    },
                    child: const Text('Parte de Tecnología'),
                  ),  

                   ElevatedButton(
                    onPressed: (){
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaDeJuego()));
                    },
                    child: const Text('Parte de Juego'),
                  ),

                   ElevatedButton(
                    onPressed: (){
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaDeDeport()));
                    },
                    child: const Text('Generar feed'),
                  ), 


                ],
            ),
            ],
          ),        
        ),
      ),
    );
  }
}



/*

 */

// Pantalla de Tecnología
class PantallaDeTec extends StatefulWidget {
  const PantallaDeTec({super.key});

  @override
  State<PantallaDeTec> createState() => _PantallaDeTecState();
}

class _PantallaDeTecState extends State<PantallaDeTec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed"),),
      body:  ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Elemento $index"),
            leading: Icon(Icons.favorite_border),
            onTap: () {
              // ACCIÓN AL PULSAR UN ELEMENTO DE LA LISTA
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Elemento $index pulsado")),
              );
            },
          );
        },
      ),
    );
  }
}



// Pantalla de Juegos
class PantallaDeJuego extends StatefulWidget {
  const PantallaDeJuego({super.key});

  @override
  State<PantallaDeJuego> createState() => _PantallaDeJuegoState();
}

class _PantallaDeJuegoState extends State<PantallaDeJuego> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed"),),
      body:  ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Elemento $index"),
            leading: Icon(Icons.favorite),
            onTap: () {
              // ACCIÓN AL PULSAR UN ELEMENTO DE LA LISTA
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Elemento $index pulsado")),
              );
            },
          );
        },
      ),
    );
  }
}

// Pantalla de Deportes

class PantallaDeDeport extends StatefulWidget {
  const PantallaDeDeport({super.key});

  @override
  State<PantallaDeDeport> createState() => _PantallaDeDeportState();
}

class _PantallaDeDeportState extends State<PantallaDeDeport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed"),),
      body:  ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Elemento $index"),
            leading: Icon(Icons.favorite),
            onTap: () {
              // ACCIÓN AL PULSAR UN ELEMENTO DE LA LISTA
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Elemento $index pulsado")),
              );
            },
          );
        },
      ),
    );
  }
}





// PANTALLAS Feed

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed"),),
      body: Center(
        child: Text("No hay datos"),
      ),
    );
  }
}



// PANTALLAS Opciones


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


var estadoswitch = false;
String terminos = "espanol";
 late double valueLinea = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
             children: [
              Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
               boxShadow: [BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading:  Icon(Icons.language),
                title: Text("Idioma"),
                trailing: DropdownButton(items: const[
                  DropdownMenuItem(
                    value: 'espanol',
                    child: Text('Español'),
                  ),
                  DropdownMenuItem(
                    value: 'Ingles',
                    child: Text('Inglés'),
                  ),
                  DropdownMenuItem(
                    value: 'japones',
                    child: Text('Japonés'),
                  ),
                ], onChanged: (value){
                     setState(() {
                        terminos =  value!;
                  });
                },
                value: terminos,
                ),
                contentPadding: EdgeInsets.all(20),
              ),
            ),

            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
               boxShadow: [BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading:  Icon(Icons.dark_mode),
                title: Text("Tema oscuro"),
                trailing: Switch(
                  onChanged: (estado){
                    setState(() {
                      estadoswitch = estado;
                      if(estadoswitch){
                      }
                      else{
                      }
                    });
                  },
                  value: estadoswitch,
                ),
                contentPadding: EdgeInsets.all(10),
              
              ),
            ),
              
             Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
               boxShadow: [BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text("Tamaño de texto: 1.0"),
                
                contentPadding: EdgeInsets.all(10),
              
              ),
            ),
                
          ],
        ),
    );
  }
}
