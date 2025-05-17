import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'core/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SmartCalcApp());
}

class SmartCalcApp extends StatefulWidget {
  const SmartCalcApp({super.key});

  @override
  State<SmartCalcApp> createState() => _SmartCalcAppState();
}

//const String kPrefIsDarkTheme = 'isDarkTheme';
//const String kPrefLanguageCode = 'languageCode';

class _SmartCalcAppState extends State<SmartCalcApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en'); // 🌐 New

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // 👈 Load saved settings on startup
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool('isDarkTheme') ?? false;
    final langCode = prefs.getString('languageCode') ?? 'en';

    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      _locale = Locale(langCode);
    });
  }

  void _toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark); // ✅ Save theme

    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'languageCode',
      newLocale.languageCode,
    ); // ✅ Save language

    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale, // 🌐 Apply selected locale here
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('tr')],
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: Builder(
        builder:
            (context) => HomePage(
              onThemeToggle: _toggleTheme,
              onLocaleChange: _changeLocale, // ✅ ADD THIS LINE
              title: AppLocalizations.of(context)!.appTitle,
            ),
      ),
    );
  }
}
