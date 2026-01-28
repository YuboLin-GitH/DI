// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Student App';

  @override
  String get labelName => 'Name';

  @override
  String get labelScore => 'Score';

  @override
  String get btnSave => 'Save Student';

  @override
  String get msgError => 'Please enter text';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get textSize => 'Text Size';

  @override
  String get language => 'Language';
}
