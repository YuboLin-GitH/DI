import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Librería Flutter'**
  String get appTitle;

  /// No description provided for @misLibros.
  ///
  /// In es, this message translates to:
  /// **'Mis Libros'**
  String get misLibros;

  /// No description provided for @libreria.
  ///
  /// In es, this message translates to:
  /// **'Librería'**
  String get libreria;

  /// No description provided for @ajustes.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get ajustes;

  /// No description provided for @noHayFavoritos.
  ///
  /// In es, this message translates to:
  /// **'No hay libros en favoritos'**
  String get noHayFavoritos;

  /// No description provided for @visitarLibreria.
  ///
  /// In es, this message translates to:
  /// **'Ve a visitar la librería.'**
  String get visitarLibreria;

  /// No description provided for @todos.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get todos;

  /// No description provided for @leidos.
  ///
  /// In es, this message translates to:
  /// **'Leídos'**
  String get leidos;

  /// No description provided for @pendientes.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get pendientes;

  /// No description provided for @favoritos.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favoritos;

  /// No description provided for @anadirLibro.
  ///
  /// In es, this message translates to:
  /// **'Añadir Libro'**
  String get anadirLibro;

  /// No description provided for @titulo.
  ///
  /// In es, this message translates to:
  /// **'Título'**
  String get titulo;

  /// No description provided for @autor.
  ///
  /// In es, this message translates to:
  /// **'Autor'**
  String get autor;

  /// No description provided for @portadaUrl.
  ///
  /// In es, this message translates to:
  /// **'URL de Portada'**
  String get portadaUrl;

  /// No description provided for @detalle.
  ///
  /// In es, this message translates to:
  /// **'Detalle'**
  String get detalle;

  /// No description provided for @cancelar.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelar;

  /// No description provided for @guardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get guardar;

  /// No description provided for @cargarPrueba.
  ///
  /// In es, this message translates to:
  /// **'¿Cargar libros de prueba?'**
  String get cargarPrueba;

  /// No description provided for @cargarPruebaDesc.
  ///
  /// In es, this message translates to:
  /// **'Esto añadirá 5 libros clásicos.'**
  String get cargarPruebaDesc;

  /// No description provided for @cargar.
  ///
  /// In es, this message translates to:
  /// **'Cargar'**
  String get cargar;

  /// No description provided for @exitoCarga.
  ///
  /// In es, this message translates to:
  /// **'¡Libros añadidos correctamente!'**
  String get exitoCarga;

  /// No description provided for @temaOscuro.
  ///
  /// In es, this message translates to:
  /// **'Tema Oscuro'**
  String get temaOscuro;

  /// No description provided for @tamanoTexto.
  ///
  /// In es, this message translates to:
  /// **'Tamaño de texto'**
  String get tamanoTexto;

  /// No description provided for @idioma.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get idioma;

  /// No description provided for @sinopsis.
  ///
  /// In es, this message translates to:
  /// **'Sinopsis'**
  String get sinopsis;

  /// No description provided for @noHayLibros.
  ///
  /// In es, this message translates to:
  /// **'No hay libros'**
  String get noHayLibros;

  /// No description provided for @leidoSingular.
  ///
  /// In es, this message translates to:
  /// **'Leído'**
  String get leidoSingular;

  /// No description provided for @pendienteSingular.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pendienteSingular;

  /// No description provided for @favoritoSingular.
  ///
  /// In es, this message translates to:
  /// **'Favorito'**
  String get favoritoSingular;

  /// No description provided for @normal.
  ///
  /// In es, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @marcarLeido.
  ///
  /// In es, this message translates to:
  /// **'Marcar como Leído/Pendiente'**
  String get marcarLeido;

  /// No description provided for @quitarFavorito.
  ///
  /// In es, this message translates to:
  /// **'Quitar de Favoritos'**
  String get quitarFavorito;

  /// No description provided for @anadirFavorito.
  ///
  /// In es, this message translates to:
  /// **'Añadir a Favoritos'**
  String get anadirFavorito;

  /// No description provided for @noDescripcion.
  ///
  /// In es, this message translates to:
  /// **'No hay descripción disponible.'**
  String get noDescripcion;

  /// No description provided for @buscar.
  ///
  /// In es, this message translates to:
  /// **'Buscar...'**
  String get buscar;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
