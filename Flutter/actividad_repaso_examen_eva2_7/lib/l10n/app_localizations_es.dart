// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Formulario Accesible';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get nameHint => 'Introduce tu nombre completo';

  @override
  String get nameError => 'El nombre no puede estar vacío';

  @override
  String get phoneLabel => 'Teléfono';

  @override
  String get phoneHint => 'Introduce tu número de teléfono';

  @override
  String get phoneErrorEmpty => 'El teléfono no puede estar vacío';

  @override
  String get phoneErrorInvalid => 'Introduce solo números';

  @override
  String get submitButton => 'Enviar';

  @override
  String get successMessage => 'Formulario enviado con éxito';
}
