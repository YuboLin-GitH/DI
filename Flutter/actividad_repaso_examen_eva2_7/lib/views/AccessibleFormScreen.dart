import 'package:actividad_repaso_examen_eva2_7/viewmodels/FormViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'viewmodels/FormViewModel.dart';

class AccessibleFormScreen extends StatelessWidget {
  // GlobalKey 属于 UI 状态，放在 Widget 里没问题
  final _formKey = GlobalKey<FormState>();
  
  // Controller 也属于 UI 状态
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _clearFields() {
    _nameController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // 监听 ViewModel (虽然这个例子里 viewModel 没有状态变化需要监听，但用 read 调用方法是必须的)
    // 如果想要更纯粹，这里可以用 context.read，但我写 watch 也没错
    final viewModel = context.watch<FormViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Formulario Accesible MVVM')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // --- 名字输入框 ---
              Semantics(
                label: 'Campo de texto para nombre',
                hint: 'Introduce tu nombre completo',
                child: TextFormField(
                  key: Key('nameField'),
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  // 调用 ViewModel 的验证逻辑
                  validator: (value) => viewModel.validateName(value),
                ),
              ),
              
              SizedBox(height: 20),
              
              // --- 电话输入框 ---
              Semantics(
                label: 'Campo de texto para teléfono',
                hint: 'Introduce tu número de teléfono',
                child: TextFormField(
                  key: Key('phoneField'),
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  // 调用 ViewModel 的验证逻辑
                  validator: (value) => viewModel.validatePhone(value),
                ),
              ),
              
              SizedBox(height: 20),
              
              // --- 提交按钮 ---
              Semantics(
                label: 'Botón de enviar formulario',
                hint: 'Pulsa para enviar los datos',
                child: ElevatedButton(
                  onPressed: () {
                    // 调用 ViewModel 的提交方法
                    // 注意：这里需要把 formKey 传进去，或者让 ViewModel 不依赖 key
                    // 最简单的分离方式是：UI 判断 validate，ViewModel 处理业务
                    
                    if (_formKey.currentState!.validate()) {
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Formulario enviado con éxito')),
                       );
                       // 这里可以调用 viewModel.saveData(...)
                       _clearFields();
                    }
                  },
                  child: Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}