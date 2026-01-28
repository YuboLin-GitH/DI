import 'package:actividad_repaso_examen_eva2/l10n/app_localizations.dart';
import 'package:actividad_repaso_examen_eva2/viewmodels/StudentViewModel.dart';
import 'package:actividad_repaso_examen_eva2/views/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Pantalla principal con formulario y lista.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 考点：Formulario y validación
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final studentVM = context.watch<StudentViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.title)),

      // 考点：Navegación (Drawer)
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Icon(Icons.school, size: 50)),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(l10n.settings),
              onTap: () {
                Navigator.pop(context); // 关掉 Drawer
                // 跳转到设置页
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- 表单区域 ---
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // 考点：Semantics (给输入框加语义)
                  Semantics(
                    label: "Campo para introducir nombre",
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: l10n.labelName),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return l10n.msgError;
                        return null;
                      },
                    ),
                  ),

                  Semantics(
                    label: "Campo para introducir puntuación",
                    child: TextFormField(
                      controller: _scoreController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: l10n.labelScore),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor escribe algo'; 
                        }
                        if (int.tryParse(value) == null) {
                          return 'Solo números (请输入数字)'; 
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // 调用 ViewModel 保存
                        studentVM.addStudent(
                          _nameController.text,
                          int.parse(_scoreController.text),
                        );
                        _nameController.clear();
                        _scoreController.clear();
                      }
                    },
                    child: Text(l10n.btnSave),
                  ),
                ],
              ),
            ),

            const Divider(),

            // --- 列表区域 ---
            Expanded(
              child: ListView.builder(
                itemCount: studentVM.students.length,
                itemBuilder: (context, index) {
                  final student = studentVM.students[index];
                  return ListTile(
                    title: Text(student['name']),
                    subtitle: Text("${l10n.labelScore}: ${student['score']}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => studentVM.deleteStudent(student['id']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
