import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale _currentLocale = const Locale('es');
  
  double _textScaleFactor = 1.0;

  void _toggleLanguage() {
    setState(() {
      if (_currentLocale.languageCode == 'es') {
        _currentLocale = const Locale('en');
      } else {
        _currentLocale = const Locale('es');
      }
    });
  }


  void _changeTextScale(double newValue) {
    setState(() {
      _textScaleFactor = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 5',
      // La clave principal para habilitar el cambio de idioma en la aplicación
      locale: _currentLocale,
      debugShowCheckedModeBanner: false,

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_textScaleFactor),
          ),
          child: child!,
        );
      },

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],

      home: FormPage(
        onLanguageToggle: _toggleLanguage,
        currentScale: _textScaleFactor,
        onScaleChanged: _changeTextScale,
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  final VoidCallback onLanguageToggle;
  final double currentScale;
  final ValueChanged<double> onScaleChanged;

  const FormPage({
    super.key, 
    required this.onLanguageToggle,
    required this.currentScale,
    required this.onScaleChanged,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.formTitle),
        actions: [
          Tooltip(
            message: 'Cambiar idioma',
            child: IconButton(
              icon: const Icon(Icons.language),
              onPressed: widget.onLanguageToggle,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(

                        "${l10n.textScaleLabel}: ${widget.currentScale}x", 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Slider(
                        value: widget.currentScale,
                        min: 1.0,  
                        max: 1.75,
                        divisions: 3, 
                        label: "${widget.currentScale}x",
                        onChanged: widget.onScaleChanged,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ---------------------------


              Text(
                l10n.formTitle,
                style: const TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),


              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.nameLabel,
                  hintText: l10n.nameHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.errorNameEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.emailLabel,
                  hintText: l10n.emailHint,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return l10n.errorEmailInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${l10n.submitButton} OK!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(l10n.submitButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}