import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
    MainApp({super.key});

  List<String> imanges = [
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: imanges.length,
          itemBuilder: (context, index) {
            String url = imanges[index];
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(url)
            );
          },

        // body: GridView.count(
        //   crossAxisCount: 3,
        //   children: <Widget>[
        //     Container(
        //       padding: EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.red, width: 5),
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       child: Image.network(imanges[0]),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(10),
        //        decoration: BoxDecoration(
        //         border: Border.all(color: Colors.red, width: 5),
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       child: Image.network("https://placehold.co/600x400.png"),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(10),
        //        decoration: BoxDecoration(
        //         border: Border.all(color: Colors.red, width: 5),
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       child: Image.network("https://placehold.co/600x400.png"),
        //     ),
        //   ],
        // ),
      ),
    )
    );
  }
}
