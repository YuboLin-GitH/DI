import 'package:actividad_repaso_examen_eva2_4/viewmodels/NumbersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'viewmodels/NumbersViewModel.dart'; // 记得导入上面的文件

class EvenNumbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 监听 ViewModel
    final viewModel = context.watch<NumbersViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Números Pares MVVM")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 直接从 viewModel 读取原始数据
            Text(
              "Lista original: ${viewModel.numbers.join(", ")}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                // 直接从 viewModel 读取处理好的偶数数据
                itemCount: viewModel.evenNumbers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      viewModel.evenNumbers[index].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}