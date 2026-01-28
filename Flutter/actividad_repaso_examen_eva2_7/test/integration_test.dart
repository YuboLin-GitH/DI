import 'package:actividad_repaso_examen_eva2_7/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('完整流程测试', (WidgetTester tester) async {
    // 1. 启动整个 App
    app.main();
    await tester.pumpAndSettle(); // 等待启动动画完成

    // 2. 输入
    await tester.enterText(find.byKey(Key('nameField')), 'Integration');
    await tester.enterText(find.byKey(Key('phoneField')), '999');
    await tester.pumpAndSettle();

    // 3. 点击
    await tester.tap(find.text('Enviar'));
    await tester.pumpAndSettle(); // 等待 SnackBar 消失和清空完成

    // 4. 验证清空
    expect(find.text('Integration'), findsNothing);
  });
}