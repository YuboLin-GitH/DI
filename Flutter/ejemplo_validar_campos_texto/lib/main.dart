import 'package:flutter/material.dart';

// Ver si no está vacío（检查是否为空）
void main() {
  runApp(const ValidacionCorreo());
}

class ValidacionCorreo extends StatefulWidget {
  const ValidacionCorreo({super.key}); // 新增 key 参数，符合组件规范

  @override
  _ValidacionCorreoState createState() => _ValidacionCorreoState();
}

class _ValidacionCorreoState extends State<ValidacionCorreo> {
  final _emailController = TextEditingController();
  String _mensajeError = '';

  // Expresión regular para validar formato de correo（原正则不变）
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  @override
  Widget build(BuildContext context) {
    // 补全：用 MaterialApp 包裹 Scaffold（符合 Flutter 层级规范）
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 可选：隐藏 debug 水印
      home: Scaffold(
        appBar: AppBar(title: const Text('Validación de Correo Electrónico')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  errorText: _mensajeError.isEmpty ? null : _mensajeError,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // 补全：先验证是否为空（满足注释里的需求）
                    final correo = _emailController.text.trim(); // 去除首尾空格
                    if (correo.isEmpty) {
                      _mensajeError = 'El campo no puede estar vacío';
                    } 
                    // 再验证格式是否正确
                    else if (!emailRegex.hasMatch(correo)) {
                      _mensajeError = 'Correo inválido!';
                    }
                    // 验证通过，清空错误提示
                    else {
                      _mensajeError = '';
                    }
                  });
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 补全：销毁控制器，避免内存泄漏
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}