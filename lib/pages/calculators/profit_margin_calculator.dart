import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class ProfitMarginCalculator extends StatefulWidget {
  const ProfitMarginCalculator({super.key});

  @override
  State<ProfitMarginCalculator> createState() => _ProfitMarginCalculatorState();
}

class _ProfitMarginCalculatorState extends State<ProfitMarginCalculator> {
  final TextEditingController costController = TextEditingController();
  final TextEditingController sellingController = TextEditingController();

  String profit = '';
  String percentage = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? cost = double.tryParse(costController.text);
    final double? selling = double.tryParse(sellingController.text);

    if (cost == null || selling == null || cost <= 0) {
      setState(() {
        profit = locale.invalidInputMessage;
        percentage = '';
      });
      return;
    }

    final double profitValue = selling - cost;
    final double percentValue = (profitValue / cost) * 100;

    setState(() {
      profit = '${locale.profitAmount}: ${profitValue.toStringAsFixed(2)}';
      percentage =
          '${locale.profitPercentage}: ${percentValue.toStringAsFixed(2)}%';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.profitMarginCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.costPrice,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: sellingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.sellingPrice,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              style: AppStyles.primaryButton,
              child: Text(locale.calculate, style: AppStyles.primaryButtonText),
            ),
            const SizedBox(height: 20),
            Text(profit, style: AppStyles.resultTextStyle),
            const SizedBox(height: 8),
            Text(percentage, style: AppStyles.resultTextStyle),
          ],
        ),
      ),
    );
  }
}
