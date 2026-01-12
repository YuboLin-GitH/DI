// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get formTitle => 'Contact Form';

  @override
  String get nameLabel => 'Full Name';

  @override
  String get nameHint => 'Please enter your name';

  @override
  String get emailLabel => 'Email Address';

  @override
  String get emailHint => 'example@mail.com';

  @override
  String get submitButton => 'Submit Data';

  @override
  String get errorNameEmpty => 'Name is required';

  @override
  String get errorEmailInvalid => 'Email is invalid';

  @override
  String get textScaleLabel => 'Text size';
}
