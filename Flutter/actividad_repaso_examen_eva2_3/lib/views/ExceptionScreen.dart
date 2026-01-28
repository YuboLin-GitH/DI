import 'package:actividad_repaso_examen_eva2_3/viewmodels/ExceptionViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 假设上面的 ExceptionViewModel 在另一个文件，记得 import
// import 'viewmodels/ExceptionViewModel.dart';

class ExceptionScreen extends StatelessWidget {
  // 定义一个控制器来获取输入框的文本
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 1. 监听数据 (watch)
    final viewModel = context.watch<ExceptionViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Manejo de Excepciones MVVM")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller, // 使用控制器获取文本
              decoration: InputDecoration(
                labelText: "Introduce un número",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 2. 触发逻辑 (read)
                // 把输入框里的字传给 ViewModel
                context.read<ExceptionViewModel>().convertStringToInt(_controller.text);
              },
              child: Text("Convertir"),
            ),
            SizedBox(height: 20),
            // 3. 显示结果
            Text(
              viewModel.errorMessage ?? "",
              style: TextStyle(
                // 颜色判断逻辑也可以利用 ViewModel 的辅助属性变得更简单
                color: viewModel.isError ? Colors.red : Colors.green,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}