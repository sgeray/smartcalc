import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../data/calculator_groups.dart';
import '../pages/calculators/discount_calculator.dart';
import '../pages/calculators/vat_calculator.dart';
import '../pages/settings_page.dart';

class CustomDrawer extends StatelessWidget {
  final Function(bool) onThemeToggle;
  final Function(Locale) onLocaleChange; // 🌐

  const CustomDrawer({
    super.key,
    required this.onThemeToggle,
    required this.onLocaleChange,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final groups = getCalculatorGroups(locale);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.indigo),
            child: Row(
              children: [
                const Icon(Icons.calculate, color: Colors.white, size: 32),
                const SizedBox(width: 10),
                Text(
                  locale.appTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          /*ListTile(
            title: Text(locale.percentageCalculator),
            onTap: () => Navigator.pop(context), // Already home
          ),
          ListTile(
            title: Text(locale.discountCalculator),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DiscountCalculator()),
              );
            },
          ),
          ListTile(
            title: Text(locale.vatCalculator),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VatCalculator()),
              );
            },
          ),*/
          ...groups.expand((group) => group['items']).map<Widget>((item) {
            return ListTile(
              title: Text(item['title']),
              leading: Icon(item['icon']),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item['builder']),
                );
              },
            );
          }),
          ListTile(
            title: Text(locale.settings),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SettingsPage(
                        onThemeToggle: onThemeToggle,
                        onLocaleChange: onLocaleChange, // ✅ pass it
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
