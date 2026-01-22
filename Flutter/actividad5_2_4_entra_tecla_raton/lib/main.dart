/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Container(
                child: Text("daaaa "),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KeyboardMouseScreen(),
    );
  }
}

class KeyboardMouseScreen extends StatelessWidget {
  const KeyboardMouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrada Teclado y Ratón')),
      body: Center(
        // 1. FocusTraversalGroup: Gestiona la navegación automática con flechas
        // por defecto usa ReadingOrderTraversalPolicy (Izquierda->Derecha, Arriba->Abajo)
        child: FocusTraversalGroup(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(6, (index) {
                return TarjetaInteractiva(index: index);
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class TarjetaInteractiva extends StatefulWidget {
  final int index;
  const TarjetaInteractiva({super.key, required this.index});

  @override
  State<TarjetaInteractiva> createState() => _TarjetaInteractivaState();
}

class _TarjetaInteractivaState extends State<TarjetaInteractiva> {
  bool _isFocused = false; // Estado del teclado
  bool _isHovered = false; // Estado del ratón

  // Acción común para Clic o Enter
  void _handleAction() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste el elemento ${widget.index + 1}'),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definimos el color y borde según el estado
    final isActive = _isFocused || _isHovered;
    
    // 2. GestureDetector: Para clics del ratón (o toques en pantalla táctil)
    return GestureDetector(
      onTap: _handleAction,
      // 3. MouseRegion: Para detectar cuando el cursor pasa por encima
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        // Cursor personalizado para indicar que es clickeable
        cursor: SystemMouseCursors.click, 
        
        // 4. Focus: Hace que el widget sea visible para el teclado
        child: Focus(
          onFocusChange: (value) => setState(() => _isFocused = value),
          // Opcional: Permitir activar con tecla Enter/Espacio
          onKeyEvent: (node, event) {
            // Si el usuario presiona Enter o Espacio mientras tiene el foco
            // if (event is KeyDownEvent && 
            //    (event.logicalKey == LogicalKeyboardKey.enter || 
            //     event.logicalKey == LogicalKeyboardKey.space)) {
            //   _handleAction();
            //   return KeyEventResult.handled;
            // }
            return KeyEventResult.ignored;
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue[100] : Colors.grey[200],
              border: Border.all(
                color: isActive ? Colors.blue : Colors.grey,
                width: isActive ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: isActive
                  ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)]
                  : [],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isActive ? Icons.check_circle : Icons.circle_outlined,
                    size: 40,
                    color: isActive ? Colors.blue : Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Item ${widget.index + 1}",
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}