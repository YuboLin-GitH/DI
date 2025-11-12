import 'package:flutter/material.dart';

// 1. 应用入口（必须有，否则无法启动）
void main() {
  runApp(const ValidacionTiempoRealApp());
}

// 2. 顶层应用容器（包含 MaterialApp，规范结构）
class ValidacionTiempoRealApp extends StatelessWidget {
  const ValidacionTiempoRealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ValidacionTiempoReal(), // 跳转到实时验证页面
    );
  }
}

// 3. 实时验证页面（有状态组件，管理错误提示状态）
class ValidacionTiempoReal extends StatefulWidget {
  // 补全构造函数（符合 Flutter 组件规范）
  const ValidacionTiempoReal({super.key});

  @override
  _ValidacionTiempoRealState createState() => _ValidacionTiempoRealState();
}

class _ValidacionTiempoRealState extends State<ValidacionTiempoReal> {
  String _mensajeError = ''; // 存储错误提示文字

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validación en Tiempo Real')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // 补全容器：让 TextField 垂直居中（优化视觉）
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 4. 修复后的 TextField：实时验证输入长度
            TextField(
              // 实时监听输入变化（输入时立即触发验证）
              onChanged: (text) {
                setState(() {
                  // 修复三元运算符：判断长度是否≥5
                  _mensajeError = text.length >= 5 
                      ? '' // 符合条件：清空错误提示
                      : 'Debe tener al menos 5 caracteres'; // 不符合：显示错误
                });
              },
              // 修复 decoration 属性：正确嵌套提示文字和错误提示
              decoration: InputDecoration(
                hintText: 'Texto en tiempo real', // 提示文字
                // 错误提示：有错误时显示 _mensajeError，否则隐藏（null）
                errorText: _mensajeError.isEmpty ? null : _mensajeError,
                // 错误时边框变红（可选，优化视觉）
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}