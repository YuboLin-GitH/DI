import 'package:flutter/material.dart';

void main() {
  runApp(const ValidacionContrasena()); // 应用入口
}

class ValidacionContrasena extends StatefulWidget {
  const ValidacionContrasena({super.key}); // 规范 key

  @override
  _ValidacionContrasenaState createState() => _ValidacionContrasenaState();
}

class _ValidacionContrasenaState extends State<ValidacionContrasena> {
  // 两个控制器：管理密码和确认密码输入
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _mensajeError = ''; // 存储错误提示

  @override
  Widget build(BuildContext context) {
    // 修复1：添加 MaterialApp 顶层容器（Scaffold 必须嵌套其中）
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 可选：隐藏 debug 水印
      home: Scaffold(
        appBar: AppBar(title: const Text('Validación de Contraseñas')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 密码输入框
              TextField(
                controller: _passwordController,
               // obscureText: true,
                decoration: const InputDecoration(hintText: 'Contraseña'),
              ),
              const SizedBox(height: 12),

              // 确认密码输入框（带 errorText）
              TextField(
                controller: _confirmPasswordController,
               // obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirmar Contraseña',
                  errorText: _mensajeError.isNotEmpty ? _mensajeError : null,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 提交按钮
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // 密码对比逻辑
                    if (_passwordController.text == _confirmPasswordController.text) {
                      _mensajeError = '';
                    } else {
                      _mensajeError = 'Las contraseñas no coinciden';
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

  // 修复2：添加 dispose 方法，销毁控制器（避免内存泄漏）
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}