// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'App Estudiantes';

  @override
  String get labelName => 'Nombre';

  @override
  String get labelScore => 'Puntuación';

  @override
  String get btnSave => 'Guardar Estudiante';

  @override
  String get msgError => 'Por favor escribe texto';

  @override
  String get settings => 'Ajustes';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get textSize => 'Tamaño de Texto';

  @override
  String get language => 'Idioma';
}
