// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get sendButton => 'Send';

  @override
  String get userName => 'Username';

  @override
  String get email => 'Email Address';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get submitHint => 'Tap to submit the form';
}
