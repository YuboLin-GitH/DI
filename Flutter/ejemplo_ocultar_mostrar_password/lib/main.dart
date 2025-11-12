import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 应用入口
}

// 完整页面（包含 Scaffold 和 AppBar，调用密码输入框组件）
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Campo de Contraseña')), // 页面导航栏
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const CampoContrasena(), // 调用密码输入框组件
        ),
      ),
    );
  }
}

// 可复用的密码输入框组件（正确结构：仅包含输入框逻辑，不含页面顶层结构）
class CampoContrasena extends StatefulWidget {
  const CampoContrasena({super.key}); // 规范添加 key 参数

  @override
  _CampoContrasenaState createState() => _CampoContrasenaState();
}

class _CampoContrasenaState extends State<CampoContrasena> {
  bool _obscureText = true; // 控制密码显示/隐藏：true=隐藏，false=显示

  @override
  Widget build(BuildContext context) {
    // 仅返回 TextField（密码输入框），不包含 Scaffold
    return TextField(
      obscureText: _obscureText, // 绑定密码显示状态
      decoration: InputDecoration(
        hintText: 'Contraseña', // 提示文字
        // 右侧图标按钮：切换密码显示/隐藏
        suffixIcon: IconButton(
          icon: Icon(
            // 三元运算符：根据 _obscureText 切换图标
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            // 点击切换 _obscureText 状态（刷新UI）
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}