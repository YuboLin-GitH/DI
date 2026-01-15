// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titulo => 'Contact Form';

  @override
  String get nombreLabel => 'Name';

  @override
  String get nombreHint => 'Enter your name';

  @override
  String get correoLaber => 'Email Address';

  @override
  String get correoHint => 'Enter your email address';

  @override
  String get botonEnviar => 'Submit';

  @override
  String get botonLimpiar => 'Clear';
}
