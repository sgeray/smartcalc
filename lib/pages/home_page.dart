import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
/*import 'calculators/area_converter.dart';
import 'calculators/bmi_calculator.dart';
import 'calculators/change_by_percent_calculator.dart';
import 'calculators/currency_converter.dart';
import 'calculators/discount_calculator.dart';
import 'calculators/length_converter.dart';
import 'calculators/loan_calculator.dart';
import 'calculators/profit_margin_calculator.dart';
import 'calculators/speed_converter.dart';
import 'calculators/temperature_converter.dart';
import 'calculators/tip_calculator.dart';
import 'calculators/unit_price_calculator.dart';
import 'calculators/vat_calculator.dart';*/
import '../data/calculator_groups.dart';
import '../widgets/custom_drawer.dart';
/*import 'calculators/date_diff_calculator.dart';
import 'calculators/percentage_calculator.dart';*/
import '../widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final Function(Locale) onLocaleChange;
  final String title;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.onLocaleChange,
    required this.title,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<String> favoriteIds = [];
  List<String> recentIds = [];

  bool showOnlyFavorites = false;

  final sectionHeaderStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteIds = prefs.getStringList('favorites') ?? [];
      recentIds = prefs.getStringList('recents') ?? [];
    });
  }

  Widget _buildCalculatorTile(
    Map<String, dynamic> item, {
    bool isRecent = false,
  }) {
    final id = item['id'] as String;
    final title = item['title'] as String;

    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          setState(() {
            recentIds.remove(id);
            recentIds.insert(0, id);
            if (recentIds.length > 10) {
              recentIds = recentIds.take(10).toList();
            }
          });
          prefs.setStringList('recents', recentIds);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => item['builder']),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item['icon'], size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
              ),
              const SizedBox(height: 6),
              if (isRecent)
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  tooltip: 'Remove from recent',
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() => recentIds.remove(id));
                    prefs.setStringList('recents', recentIds);
                  },
                )
              else
                IconButton(
                  icon: Icon(
                    favoriteIds.contains(id) ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.amber,
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      if (favoriteIds.contains(id)) {
                        favoriteIds.remove(id);
                      } else {
                        favoriteIds.add(id);
                      }
                    });
                    prefs.setStringList('favorites', favoriteIds);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridFromIds(
    List<String> ids,
    List<Map<String, dynamic>> allItems, {
    bool isRecent = false,
  }) {
    final filtered = allItems.where((i) => ids.contains(i['id'])).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
        physics: const NeverScrollableScrollPhysics(),
        children:
            filtered
                .map((item) => _buildCalculatorTile(item, isRecent: isRecent))
                .toList(),
      ),
    );
  }

  /*Widget _buildGridFromIds(
    List<String> ids,
    List<Map<String, dynamic>> allItems, {
    bool isRecent = false,
  }) {
    final filtered = allItems.where((i) => ids.contains(i['id'])).toList();

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1,
      physics: const NeverScrollableScrollPhysics(),
      children:
          filtered
              .map((item) => _buildCalculatorTile(item, isRecent: isRecent))
              .toList(),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    /*final calculatorGroups = [
      {
        'title': locale.financeTools,
        'items': [
          {
            'id': 'profitMarginCalculator',
            'title': locale.profitMarginCalculator,
            'icon': Icons.trending_up,
            'builder': const ProfitMarginCalculator(),
          },
          {
            'id': 'loanCalculator',
            'title': locale.loanCalculator,
            'icon': Icons.credit_score,
            'builder': const LoanCalculator(),
          },
          {
            'id': 'currencyConverter',
            'title': locale.currencyConverter,
            'icon': Icons.currency_exchange,
            'builder': const CurrencyConverter(),
          },
        ],
      },
      {
        'title': locale.shoppingTools,
        'items': [
          {
            'id': 'discountCalculator',
            'title': locale.discountCalculator,
            'icon': Icons.local_offer,
            'builder': const DiscountCalculator(),
          },
          {
            'id': 'vatCalculator',
            'title': locale.vatCalculator,
            'icon': Icons.receipt_long,
            'builder': const VatCalculator(),
          },
          {
            'id': 'unitPriceCalculator',
            'title': locale.unitPriceCalculator,
            'icon': Icons.shopping_cart_checkout,
            'builder': const UnitPriceCalculator(),
          },
        ],
      },
      {
        'title': locale.generalMathTools,
        'items': [
          {
            'id': 'percentageCalculator',
            'title': locale.percentageCalculator,
            'icon': Icons.percent,
            'builder': const PercentageCalculator(),
          },
          {
            'id': 'changeByPercentCalculator',
            'title': locale.changeByPercentCalculator,
            'icon': Icons.trending_neutral,
            'builder': const ChangeByPercentCalculator(),
          },
          {
            'id': 'tipCalculator',
            'title': locale.tipCalculator,
            'icon': Icons.attach_money,
            'builder': const TipCalculator(),
          },
          {
            'id': 'bmiCalculator',
            'title': locale.bmiCalculator,
            'icon': Icons.monitor_weight,
            'builder': const BmiCalculator(),
          },
          {
            'id': 'dateDiffCalculator',
            'title': locale.dateDiffCalculator,
            'icon': Icons.date_range,
            'builder': const DateDiffCalculator(),
          },
          {
            'id': 'areaConverter',
            'title': locale.areaConverter,
            'icon': Icons.square_foot,
            'builder': const AreaConverter(),
          },
          {
            'id': 'speedConverter',
            'title': locale.speedConverter,
            'icon': Icons.speed,
            'builder': const SpeedConverter(),
          },
          {
            'id': 'temperatureConverter',
            'title': locale.temperatureConverter,
            'icon': Icons.thermostat,
            'builder': const TemperatureConverter(),
          },
          {
            'id': 'lengthConverter',
            'title': locale.lengthConverter,
            'icon': Icons.straighten,
            'builder': const LengthConverter(),
          },
        ],
      },
    ];*/

    final calculatorGroups = getCalculatorGroups(locale);

    final List<Map<String, dynamic>> allItems =
        calculatorGroups
            .expand((group) => group['items'] as List<Map<String, dynamic>>)
            .toList();

    final filteredGroups =
        calculatorGroups
            .map((group) {
              final items = group['items'] as List<Map<String, dynamic>>;
              final filteredItems =
                  items.where((item) {
                    final title = (item['title'] as String).toLowerCase();
                    final match = title.contains(_searchQuery.toLowerCase());
                    final isFav =
                        !showOnlyFavorites || favoriteIds.contains(item['id']);
                    return match && isFav;
                  }).toList();
              return {'title': group['title'], 'items': filteredItems};
            })
            .where((group) => (group['items'] as List).isNotEmpty)
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      drawer: CustomDrawer(
        onThemeToggle: widget.onThemeToggle,
        onLocaleChange: widget.onLocaleChange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text(locale.showOnlyFavorites),
            value: showOnlyFavorites,
            onChanged: (value) {
              setState(() {
                showOnlyFavorites = value;
              });
            },
          ),
          if (favoriteIds.isNotEmpty) ...[
            Text(locale.favorites, style: sectionHeaderStyle),
            _buildGridFromIds(favoriteIds, allItems),
          ],
          if (recentIds.isNotEmpty) ...[
            Text(locale.recentCalculators, style: sectionHeaderStyle),
            _buildGridFromIds(recentIds, allItems, isRecent: true),
          ],
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: locale.search,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 20),
          ...filteredGroups.map((group) {
            final items = group['items'] as List<Map<String, dynamic>>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group['title'] as String, style: sectionHeaderStyle),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: items.map(_buildCalculatorTile).toList(),
                ),
                const SizedBox(height: 24),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
