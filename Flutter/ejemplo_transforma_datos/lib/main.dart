import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ParentPage(), // 父页面作为首页
    );
  }
}

// 父页面：带输入框，用户输入信息后传递给子页面
class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  // 控制器：管理输入框的内容
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("padre")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 输入框：让用户输入要传递的信息
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: "introduce mensaje quiere enviar",
                border: OutlineInputBorder(), // 输入框边框
              ),
            ),
            const SizedBox(height: 20),
            // 按钮：点击后将输入的内容传递给子页面
            ElevatedButton(
              onPressed: () {
                // 获取输入框的内容（去除首尾空格）
                String inputText = _inputController.text.trim();

                // 如果输入为空，提示用户
                if (inputText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("introduce algo")),
                  );
                  return;
                }

                // 跳转到子页面，并传递输入的内容
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChildPage(
                      receivedText: inputText, // 传递用户输入的信息
                    ),
                  ),
                );
              },
              child: const Text("enviar al hijo"),
            ),
          ],
        ),
      ),
    );
  }

  // 销毁控制器，避免内存泄漏
  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}

// 子页面：接收并显示父页面传递的输入信息
class ChildPage extends StatelessWidget {
  // 接收父页面传递的信息（必须传入）
  final String receivedText;

  const ChildPage({
    super.key,
    required this.receivedText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parte hijo"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Mensaje de Padre", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // 显示父页面输入的内容
            Text(
              receivedText,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 返回父页面的按钮
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Volve al patre"),
            ),
          ],
        ),
      ),
    );
  }
}