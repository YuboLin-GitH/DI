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
      home: const FirstPage(), // 第一个界面（父页面）
    );
  }
}

// 第一个界面（父页面）：接收第二个界面传递的信息
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // 存储从第二个界面接收的信息
  String _messageFromSecondPage = "Espera mensaje de hijo";

  // 回调函数：用于接收第二个界面的数据
  void _receiveData(String data) {
    setState(() {
      _messageFromSecondPage = data; // 更新父页面显示
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Padre）"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 显示第二个界面传递的信息
            Text(
              "Mensaje de hijo：\n$_messageFromSecondPage",
              style: const TextStyle(fontSize: 18, color: Colors.purple),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 跳转到第二个界面的按钮
            ElevatedButton(
              onPressed: () {
                // 跳转到第二个界面，并传递回调函数
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(
                      onSendData: _receiveData, // 传递回调给子页面
                    ),
                  ),
                );
              },
              child: const Text("Pantalla hijo"),
            ),
          ],
        ),
      ),
    );
  }
}

// 第二个界面（子页面）：输入信息并传递给第一个界面
class SecondPage extends StatefulWidget {
  // 接收父页面的回调函数（用于传递数据）
  final Function(String) onSendData;

  const SecondPage({
    super.key,
    required this.onSendData,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // 控制器：管理输入框内容
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Hijo"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 输入框：在第二个界面输入要传递的信息
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: "Mensaje quiere mandar",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // 按钮：发送信息并返回第一个界面
            ElevatedButton(
              onPressed: () {
                String inputText = _inputController.text.trim();

                if (inputText.isEmpty) {
                  // 输入为空时提示
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Escribe algo")),
                  );
                  return;
                }

                // 调用回调函数，将信息传给第一个界面
                widget.onSendData(inputText);

                // 返回第一个界面
                Navigator.pop(context);
              },
              child: const Text("Enviar y vuelve"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}