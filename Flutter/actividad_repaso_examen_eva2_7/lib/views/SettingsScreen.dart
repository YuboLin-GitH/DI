import 'package:actividad_repaso_examen_eva2_7/l10n/app_localizations.dart';
import 'package:actividad_repaso_examen_eva2_7/viewmodels/LanguageViewModel.dart';
import 'package:actividad_repaso_examen_eva2_7/views/AccessibleFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. 获取 ViewModel 和 翻译工具
    final languageVM = context.watch<LanguageViewModel>();
    final l10n = AppLocalizations.of(context)!;

    // 判断当前是不是英语 (用于控制 Switch 的开关状态)
    bool isEnglish = languageVM.appLocale.languageCode == 'en';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)), // 标题也会随语言变
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cambiar Idioma", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // --- 组件 1: Switch (快速切换) ---
            // 逻辑：关 = 西班牙语, 开 = 英语
            SwitchListTile(
              title: const Text('English Mode (Switch)'),
              subtitle: Text(isEnglish ? 'Activado' : 'Desactivado'),
              value: isEnglish,
              onChanged: (bool value) {
                if (value) {
                  languageVM.changeLanguage(const Locale('en'));
                } else {
                  languageVM.changeLanguage(const Locale('es'));
                }
              },
            ),

            const Divider(),
            const SizedBox(height: 20),

            // --- 组件 2: DropdownMenu (下拉选择) ---
            const Text("Seleccionar de lista (Dropdown):"),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  isExpanded: true,
                  value: languageVM.appLocale, // 当前选中的值
                  icon: const Icon(Icons.language),
                  items: AppLocalizations.supportedLocales.map((Locale locale) {
                    return DropdownMenuItem<Locale>(
                      value: locale,
                      child: Text(
                        _getLanguageName(locale.languageCode),
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      languageVM.changeLanguage(newLocale);
                    }
                  },
                ),
              ),
            ),

            const Spacer(),
            
            // 按钮：去之前的表单页面看看翻译效果
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccessibleFormScreen()),
                  );
                },
                child: const Text("Ir al Formulario >"),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 辅助函数：把代码 'es' 变成人话 'Español'
  String _getLanguageName(String code) {
    switch (code) {
      case 'es': return '🇪🇸 Español';
      case 'en': return '🇺🇸 English';
      default: return code;
    }
  }
}