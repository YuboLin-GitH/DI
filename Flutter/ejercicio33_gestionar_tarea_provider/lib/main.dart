import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final contador = context.watch<TaskProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        
        child: Text(
  "        context.watch<TaskProvider>().contador.toString();"
          
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Formulario()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskProvider extends ChangeNotifier {
  List<String> _tareas = [];

  List<String> get contador => _tareas;

  void anadirTareas(String tareas) {
    _tareas.add(tareas);
    notifyListeners();
  }

  
}



class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    TextEditingController? controller;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("AddTaskScreen"),)),
      body: Center(
         child: Form(child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            ElevatedButton(onPressed: (){
              context.read<TaskProvider>().anadirTareas(controller!.text);
              Navigator.pop(context);
            }, child: Text("Enviar"))
          ],
         )),
      )
    );
  }
}
