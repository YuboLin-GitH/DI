// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get formTitle => 'Formulario de Contacto';

  @override
  String get nameLabel => 'Nombre completo';

  @override
  String get nameHint => 'Por favor ingresa tu nombre';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailHint => 'ejemplo@correo.com';

  @override
  String get submitButton => 'Enviar datos';

  @override
  String get errorNameEmpty => 'El nombre es obligatorio';

  @override
  String get errorEmailInvalid => 'El correo no es válido';

  @override
  String get textScaleLabel => 'Tamaño de texto';
}
