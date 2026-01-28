// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Conversor Examen';

  @override
  String get menuConverter => 'Conversor';

  @override
  String get menuTransactions => 'Transacciones';

  @override
  String get menuSettings => 'Ajustes';

  @override
  String get labelValue => 'Valor';

  @override
  String get hintValue => 'Introduce el valor';

  @override
  String get btnConvert => 'Convertir y Guardar';

  @override
  String get msgSuccess => '¡Transacción guardada!';

  @override
  String get msgError => 'Entrada inválida';

  @override
  String get labelDarkMode => 'Modo Oscuro';

  @override
  String get labelLanguage => 'Idioma';

  @override
  String get labelTextSize => 'Tamaño de Texto';

  @override
  String get emptyHistory => 'No hay transacciones';
}
