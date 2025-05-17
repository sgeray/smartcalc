import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../widgets/custom_drawer.dart';
import '../pages/settings_page.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) onThemeToggle;

  final dynamic onLocaleChange;
  //const SettingsPage({super.key, required this.onThemeToggle});
  const SettingsPage({
    super.key,
    required this.onThemeToggle,
    required this.onLocaleChange,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  Locale _locale = const Locale('en');

  void _changeLanguage(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.settings)),
      /*drawer: CustomDrawer(
        onThemeToggle: widget.onThemeToggle,
      ),*/
      // ✅ Add this line
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(locale.darkTheme),
            value: isDark,
            onChanged: (value) {
              setState(() => isDark = value);
              widget.onThemeToggle(isDark);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(locale.language),
            trailing: DropdownButton<Locale>(
              value: _locale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  _changeLanguage(newLocale);
                  widget.onLocaleChange(newLocale); // 🌐 Update global locale
                  // Restarting MaterialApp or using a language manager will be required
                  // for a full app language update (see below)
                }
              },
              items: [
                DropdownMenuItem(
                  value: const Locale('en'),
                  child: Text(locale.english),
                ),
                DropdownMenuItem(
                  value: const Locale('tr'),
                  child: Text(locale.turkish),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
