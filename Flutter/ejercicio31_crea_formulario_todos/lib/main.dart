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
      home: const FormularioPrincipal(), // 初始显示表单页面
    );
  }
}

// 1. 表单主页面（核心：管理表单验证和数据）
class FormularioPrincipal extends StatefulWidget {
  const FormularioPrincipal({super.key});

  @override
  State<FormularioPrincipal> createState() => _FormularioPrincipalState();
}

class _FormularioPrincipalState extends State<FormularioPrincipal> {
  // 表单唯一标识（必须有，用于触发验证/重置）
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  // 存储表单数据（后续传给下一页）
  String _email = '';
  String _login = '';
  String _contrasena = '';
  String _repetirContrasena = '';
  String _terminos = 'No Aceptar Términos'; // 下拉框默认值

  // 2. 重置表单（清空所有输入和错误提示）
  void _borrarFormulario() {
    _formKey.currentState!.reset(); // 重置表单
    _passwordController.clear();
    setState(() {
      _terminos = 'No Aceptar Términos'; // 下拉框恢复默认值
    });
  }

  // 3. 提交表单（验证通过后跳转到结果页）
  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      // 验证通过：保存表单输入的内容
      _formKey.currentState!.save();
      
      // 跳转到结果页，把表单数据传过去
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PantallaResultado(
            email: _email,
            login: _login,
            contrasena: _contrasena,
            terminos: _terminos,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario Simple')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 表单和屏幕边缘留间距
        child: Form(
          key: _formKey, // 绑定表单标识
          child: ListView( // 用ListView避免键盘遮挡
            children: [
              // 4. 邮箱输入框（验证格式）
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress, // 邮箱专用键盘
                // 验证规则：非空 + 包含@
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email no puede estar vacío';
                  }
                  if (!value.contains('@')) { // 简单验证格式
                    return 'Email inválido (falta @)';
                  }
                  return null; // 验证通过
                },
                // 保存输入的邮箱
                onSaved: (value) {
                  _email = value!;
                },
              ),

              const SizedBox(height: 16), // 输入框之间留间距

              // 5. Login输入框（不能是"admin"）
              TextFormField(
                decoration: const InputDecoration(labelText: 'Login'),
                // 验证规则：非空 + 不是"admin"
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Login no puede estar vacío';
                  }
                  if (value == 'admin') { // 禁止用"admin"
                    return 'Login no puede ser "admin"';
                  }
                  return null;
                },
                // 保存输入的Login
                onSaved: (value) {
                  _login = value!;
                },
              ),

              const SizedBox(height: 16),

              // 6. 密码输入框（8位+1个符号）
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true, // 隐藏密码
                // 验证规则：非空 + 长度>8 + 包含符号
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Contraseña no puede estar vacía';
                  }
                  if (value.length <= 8) { // 必须超过8位
                    return 'Contraseña需>8个字符';
                  }
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) { // 验证符号
                    return 'Contraseña需包含1个符号（如!@#）';
                  }
                  return null;
                },
                // 保存输入的密码
                onSaved: (value) {
                  _contrasena = value!;
                },
              ),

              const SizedBox(height: 16),

              // 7. 重复密码输入框（和密码一致）
              TextFormField(
                decoration: const InputDecoration(labelText: 'Repetir Contraseña'),
                obscureText: true,
                // 验证规则：非空 + 和密码一致
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Repite la contraseña';
                  }
                  // 获取当前密码输入框的值（对比一致性）
                
                  if (value != _passwordController.text) {
                    return 'Contraseñas no coinciden';
                  }
                  return null;
                },
                // 保存重复的密码
                onSaved: (value) {
                  _repetirContrasena = value!;
                },
              ),

              const SizedBox(height: 16),

              // 8. 下拉框（选择接受/不接受条款）
              DropdownButtonFormField(
                value: _terminos, // 默认选中值
                decoration: const InputDecoration(labelText: 'Términos'),
                // 下拉选项
                items: const [
                  DropdownMenuItem(
                    value: 'Aceptar Términos',
                    child: Text('Aceptar Términos'),
                  ),
                  DropdownMenuItem(
                    value: 'No Aceptar Términos',
                    child: Text('No Aceptar Términos'),
                  ),
                ],
                // 选择时更新值
                onChanged: (value) {
                  setState(() {
                    _terminos = value!;
                  });
                },
                // 验证规则：必须接受条款
                validator: (value) {
                  if (value == 'No Aceptar Términos') {
                    return 'Debes aceptar los términos';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // 9. 按钮组（重置 + 提交）
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 重置按钮
                  ElevatedButton(
                    onPressed: _borrarFormulario,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text('Borrar'),
                  ),
                  // 提交按钮
                  ElevatedButton(
                    onPressed: _enviarFormulario,
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 10. 结果页面（接收并显示表单数据）
class PantallaResultado extends StatelessWidget {
  // 接收从表单页传过来的数据
  final String email;
  final String login;
  final String contrasena;
  final String terminos;

  // 必须传入所有数据
  const PantallaResultado({
    super.key,
    required this.email,
    required this.login,
    required this.contrasena,
    required this.terminos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos Enviados')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 显示每一项数据
            _buildDatos('Email', email),
            _buildDatos('Login', login),
            _buildDatos('Contraseña', '******'), // 密码隐藏显示
            _buildDatos('Términos', terminos),
          ],
        ),
      ),
    );
  }

  // 复用组件：显示"标题+数据"
  Widget _buildDatos(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}