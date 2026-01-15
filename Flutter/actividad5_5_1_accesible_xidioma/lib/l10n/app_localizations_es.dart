// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get titulo => 'Formulario de contacto';

  @override
  String get nombreLabel => 'Nombre';

  @override
  String get nombreHint => 'Introduce tu nombre';

  @override
  String get correoLaber => 'Correo electrónico';

  @override
  String get correoHint => 'Introduce tu correo electrónico';

  @override
  String get botonEnviar => 'Enviar';

  @override
  String get botonLimpiar => 'Limpiar';
}
