import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/datasources/product_datasource.dart';

void main() {
  final dataSource = ProductDataSource();


  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('JSON')),
        body: FutureBuilder<List<dynamic>>(
          future: ,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No posts found'));
            }
            var productos = snapshot.data!;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                var producto = productos[index];
                return ListTile(
                  title: Text(producto['nombre']),
                  trailing: Text('${producto['precio']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
