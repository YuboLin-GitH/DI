import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto2eval_yubo/viewmodels/settings_view_model.dart'; 

void main() {
  group('SettingsViewModel Tests', () {
    

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('El tema por defecto debe ser Claro (false)', () async {
      final vm = SettingsViewModel();

      await Future.delayed(Duration.zero); 
      
      expect(vm.esOscuro, false);
      expect(vm.themeMode, ThemeMode.light);
    });

    test('toggleTheme debe cambiar el estado y guardar', () async {
      final vm = SettingsViewModel();
      await Future.delayed(Duration.zero);

      expect(vm.esOscuro, false);

      await vm.toggleTheme();
      expect(vm.esOscuro, true);

      await vm.toggleTheme();
      expect(vm.esOscuro, false);
    });

    test('setFontSizeScale no debe permitir valores fuera de rango (10-14)', () async {
      final vm = SettingsViewModel();
      await Future.delayed(Duration.zero);

      await vm.setFontSizeScale(9.0);
      expect(vm.fontSize, 10.0);


      await vm.setFontSizeScale(20.0);
      expect(vm.fontSize, 14.0);


      await vm.setFontSizeScale(13.0);
      expect(vm.fontSize, 13.0);
    });
  });
}