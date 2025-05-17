import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

enum CalculationType {
  bPercentOfA,
  percentageOfB,
  percentageChange,
  increaseByPercent,
  decreaseByPercent,
}

class PercentageCalculator extends StatefulWidget {
  const PercentageCalculator({super.key});

  @override
  State<PercentageCalculator> createState() => _PercentageCalculatorState();
}

class _PercentageCalculatorState extends State<PercentageCalculator> {
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();
  CalculationType _selectedType = CalculationType.bPercentOfA;
  String result = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? a = double.tryParse(aController.text);
    final double? b = double.tryParse(bController.text);

    if (a == null || b == null) {
      setState(() {
        result = locale.invalidInputMessage;
      });
      return;
    }

    String output;
    switch (_selectedType) {
      case CalculationType.bPercentOfA:
        output = locale.resultPrefix + '${(b / a * 100).toStringAsFixed(2)}%';
        break;
      case CalculationType.percentageOfB:
        output = locale.resultPrefix + '${(a / b * 100).toStringAsFixed(2)}%';
        break;
      case CalculationType.percentageChange:
        final change = ((b - a) / a * 100);
        output = locale.changePrefix + '${change.toStringAsFixed(2)}%';
        break;
      case CalculationType.increaseByPercent:
        output =
            locale.resultPrefix + '${(a * (1 + b / 100)).toStringAsFixed(2)}';
        break;
      case CalculationType.decreaseByPercent:
        output =
            locale.resultPrefix + '${(a * (1 - b / 100)).toStringAsFixed(2)}';
        break;
    }

    setState(() {
      result = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.percentageCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton<CalculationType>(
              value: _selectedType,
              isExpanded: true,
              onChanged: (CalculationType? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedType = newValue;
                    result = '';
                  });
                }
              },
              items: [
                DropdownMenuItem(
                  value: CalculationType.bPercentOfA,
                  child: Text(locale.calcOptionBPercentOfA),
                ),
                DropdownMenuItem(
                  value: CalculationType.percentageOfB,
                  child: Text(locale.calcOptionPercentOfB),
                ),
                DropdownMenuItem(
                  value: CalculationType.percentageChange,
                  child: Text(locale.calcOptionPercentageChange),
                ),
                DropdownMenuItem(
                  value: CalculationType.increaseByPercent,
                  child: Text(locale.calcOptionIncreaseByPercent),
                ),
                DropdownMenuItem(
                  value: CalculationType.decreaseByPercent,
                  child: Text(locale.calcOptionDecreaseByPercent),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: aController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.enterValueA,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: bController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.enterValueB,
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
            Text(result, style: AppStyles.resultTextStyle),
          ],
        ),
      ),
    );
  }
}
