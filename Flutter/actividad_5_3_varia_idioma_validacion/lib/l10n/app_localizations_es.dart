// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get sendButton => 'Enviar';

  @override
  String get userName => 'Nombre de usuario';

  @override
  String get email => 'Correo electrónico';

  @override
  String get nameHint => 'Introduce tu nombre';

  @override
  String get emailHint => 'Introduce tu correo electrónico';

  @override
  String get submitHint => 'Pulsa para enviar el formulario';
}
