import 'package:actividad_repaso_examen_eva2/viewmodels/CounterViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Counterscreen extends StatelessWidget {
  const Counterscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterVM = Provider.of<CounterViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Contador MVVM"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Contador: ${counterVM.counter}"
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: counterVM.incrementar, child: Text("+")),
                SizedBox(width: 20,),
                ElevatedButton(onPressed: counterVM.decrementar, child: Text("-")),

              ],
            )
          ],
        ),
      ),
    );
  }
}