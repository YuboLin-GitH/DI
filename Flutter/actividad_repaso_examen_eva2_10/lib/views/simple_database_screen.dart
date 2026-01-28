import 'package:flutter/material.dart';
// 导入你的数据库服务 (注意路径，.. 表示上一级目录)
import '../services/database_service.dart'; 

class SimpleDatabaseScreen extends StatefulWidget {
  @override
  _SimpleDatabaseScreenState createState() => _SimpleDatabaseScreenState();
}

class _SimpleDatabaseScreenState extends State<SimpleDatabaseScreen> {
  // 实例化 Service
  final DatabaseService _databaseService = DatabaseService();
  
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  double? _lastValue;

  Future<void> _saveValue() async {
    if (_formKey.currentState!.validate()) {
      final value = double.parse(_valueController.text);
      
      // 1. 存数据
      await _databaseService.insertValue(value);
      
      // 2. 检查页面是否还活着 (防止 Context 报错)
      if (!mounted) return;

      // 3. 弹窗
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Valor $value guardado en la base de datos')),
      );
      _valueController.clear();
    }
  }

  Future<void> _getValue() async {
    // 1. 查数据
    final value = await _databaseService.getLastValue();
    
    // 2. 检查页面是否还活着
    if (!mounted) return;

    setState(() {
      _lastValue = value;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value != null
              ? 'Valor cargado: $value'
              : 'No hay valores en la base de datos',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejemplo BBDD')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Introduce un valor',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, inserta un valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Inserta un número válido';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _saveValue, child: Text('Guardar Valor')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _getValue, child: Text('Cargar Valor')),
            SizedBox(height: 16),
            if (_lastValue != null)
              Text(
                'Último valor guardado: $_lastValue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}