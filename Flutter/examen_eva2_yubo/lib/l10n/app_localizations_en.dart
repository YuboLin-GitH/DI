// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tituloGestion => 'Gestion';

  @override
  String get tituloListado => 'List';

  @override
  String get tituloAjuste => 'Settings';

  @override
  String get nuevolibro => 'New Book';

  @override
  String get titulo => 'Title';

  @override
  String get autor => 'Author';

  @override
  String get estado => 'State';

  @override
  String get disponible => 'DISPONIBLE';

  @override
  String get prestado => 'PRESTADO';

  @override
  String get btGuarda => 'Save';

  @override
  String get modoClaro => 'clase theme';

  @override
  String get modoOscuro => 'Dark theme';

  @override
  String get idioma => 'Language';

  @override
  String get tamanioTexto => 'Text size';
}
