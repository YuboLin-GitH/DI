import 'package:actividad_repaso_examen_eva2_7/viewmodels/FormViewModel.dart';
import 'package:actividad_repaso_examen_eva2_7/views/AccessibleFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';


void main() {
  testWidgets('测试：发送后清空输入框', (WidgetTester tester) async {
    // 1. 构建测试环境 (必须包 Provider)
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => FormViewModel(),
        child: MaterialApp(home: AccessibleFormScreen()),
      ),
    );

    // 2. 找到控件
    final nameFinder = find.byKey(Key('nameField'));
    final phoneFinder = find.byKey(Key('phoneField'));
    final btnFinder = find.text('Enviar');

    // 3. 输入内容
    await tester.enterText(nameFinder, 'Usuario Test');
    await tester.enterText(phoneFinder, '123456789');

    // 验证一下输入成功没
    expect(find.text('Usuario Test'), findsOneWidget);

    // 4. 点击按钮
    await tester.tap(btnFinder);
    await tester.pump(); // 刷新一帧

    // 5. 验证是否清空
    // 预期：屏幕上找不到 'Usuario Test' 了，因为它被变成了 ''
    expect(find.text('Usuario Test'), findsNothing);
    expect(find.text('123456789'), findsNothing);

    // 6. 验证 SnackBar 出现
    expect(find.text('Formulario enviado con éxito'), findsOneWidget);
  });
}