// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Accessible Form';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameHint => 'Enter your full name';

  @override
  String get nameError => 'Name cannot be empty';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get phoneHint => 'Enter your phone number';

  @override
  String get phoneErrorEmpty => 'Phone cannot be empty';

  @override
  String get phoneErrorInvalid => 'Only numbers are allowed';

  @override
  String get submitButton => 'Submit';

  @override
  String get successMessage => 'Form submitted successfully';
}
