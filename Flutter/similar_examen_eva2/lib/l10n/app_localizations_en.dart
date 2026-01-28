// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Exam Converter';

  @override
  String get menuConverter => 'Converter';

  @override
  String get menuTransactions => 'Transactions';

  @override
  String get menuSettings => 'Settings';

  @override
  String get labelValue => 'Value';

  @override
  String get hintValue => 'Enter value';

  @override
  String get btnConvert => 'Convert & Save';

  @override
  String get msgSuccess => 'Transaction saved!';

  @override
  String get msgError => 'Invalid input';

  @override
  String get labelDarkMode => 'Dark Mode';

  @override
  String get labelLanguage => 'Language';

  @override
  String get labelTextSize => 'Text Size';

  @override
  String get emptyHistory => 'No transactions yet';
}
