import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test1_prueba/main.dart';


void main(){
  testWidgets(
    "EL home funciona correctamente", (WidgetTester tester) async{
      await tester.pumpWidget(const MyApp());
      expect(find.text('0'), findsOneWidget);
      expect(find.text('Flutter Demo Home Page'), findsOneWidget);
    });


  testWidgets("El boton funciona correctamente", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp( 
        home: Scaffold(
        body: MyHomePage(title: "titulo",)
            ),
          ),
        );

    tester.tap(find.byType(FloatingActionButton));
   
    
  });
}