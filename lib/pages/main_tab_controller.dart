import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_page.dart';
import 'settings_page.dart';

class MainTabController extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final Function(Locale) onLocaleChange;

  const MainTabController({
    super.key,
    required this.onThemeToggle,
    required this.onLocaleChange,
  });

  @override
  State<MainTabController> createState() => _MainTabControllerState();
}

class _MainTabControllerState extends State<MainTabController> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final screens = [
      HomePage(
        onThemeToggle: widget.onThemeToggle,
        onLocaleChange: widget.onLocaleChange,
        title: locale.appTitle,
      ),
      SettingsPage(
        onThemeToggle: widget.onThemeToggle,
        onLocaleChange: widget.onLocaleChange,
      ),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.calculate),
            label: locale.appTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: locale.settings,
          ),
        ],
      ),
    );
  }
}
