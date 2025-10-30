import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  Future<List<dynamic>> fetchPosts() async {
    var response = await rootBundle.loadString('assets/posts.json');
    return jsonDecode(response) as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('HTTP jsonplaceholder')),
        body: FutureBuilder<List<dynamic>>(
          future: fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No posts found'));
            }
            var posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var post = posts[index];
                return ListTile(
                  leading: Text(post['id'].toString()),
                  title: Text(post['title']),
                  subtitle: Text(post['body']),
                  trailing: Text(post['userId'].toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
