// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Converter';

  @override
  String get menu => 'Menu';

  @override
  String get transactions => 'Transactions';

  @override
  String get settings => 'Settings';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get language => 'Language';

  @override
  String get textSize => 'Text Size';

  @override
  String get convertSave => 'Convert & Save';

  @override
  String get result => 'Result';

  @override
  String get enterValue => 'Enter a value';

  @override
  String get savedSuccess => 'Transaction saved successfully';
}
