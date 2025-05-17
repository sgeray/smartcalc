import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// calculator pages
import '../pages/calculators/area_converter.dart';
import '../pages/calculators/bmi_calculator.dart';
import '../pages/calculators/change_by_percent_calculator.dart';
import '../pages/calculators/currency_converter.dart';
import '../pages/calculators/discount_calculator.dart';
import '../pages/calculators/length_converter.dart';
import '../pages/calculators/loan_calculator.dart';
import '../pages/calculators/profit_margin_calculator.dart';
import '../pages/calculators/speed_converter.dart';
import '../pages/calculators/temperature_converter.dart';
import '../pages/calculators/tip_calculator.dart';
import '../pages/calculators/unit_price_calculator.dart';
import '../pages/calculators/vat_calculator.dart';
import '../pages/calculators/date_diff_calculator.dart';
import '../pages/calculators/percentage_calculator.dart';

List<Map<String, dynamic>> getCalculatorGroups(AppLocalizations locale) {
  return [
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
  ];
}
