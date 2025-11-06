import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  PantallaPrincipal(
      ),
    );
  }
}

class Producto {
  final String nombre; 
  final double precio; 
  final String descripcion; 

  const Producto({
    required this.nombre,
    required this.precio,
    required this.descripcion,
  });
}


class PantallaPrincipal extends StatelessWidget{
  const PantallaPrincipal({super.key});
  
  @override
  Widget build(BuildContext context) {
    final List<Producto> listaProductos = [
      Producto(
        nombre: "Manzana",
        precio: 1.99,
        descripcion: "Manzana roja fresca",
      ),
      Producto(
        nombre: "Banana",
        precio: 0.99,
        descripcion: "Banana madura",
      ),
    ];


    return Scaffold(
        appBar: AppBar(title: Text("Pantalla de Producto"),),
        body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: listaProductos.length,
        itemBuilder: (context, index) {
          final productoSeleccionado = listaProductos[index];
          return ListTile(
            title: Text(productoSeleccionado.nombre), 
            subtitle: Text("${productoSeleccionado.precio} €"), 
            onTap: () {
              Navigator.push(
                context,
              MaterialPageRoute(
                  builder: (context) => DetallesProducto(
                  producto: productoSeleccionado, 
                  ),
                ),
              );
            },
          );
        },
      ),
        
        
    );
  }
}

class DetallesProducto extends StatelessWidget{
  final Producto producto;
  const DetallesProducto({super.key, required this.producto,});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle de objeto")),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
  
            Text(
              producto.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
    
            Text(
              "${producto.precio} €",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),

            Text(
              "Descripción: ${producto.descripcion}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
    );
  }
}
