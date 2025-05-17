import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class ChangeByPercentCalculator extends StatefulWidget {
  const ChangeByPercentCalculator({super.key});

  @override
  State<ChangeByPercentCalculator> createState() =>
      _ChangeByPercentCalculatorState();
}

enum ChangeType { increase, decrease }

class _ChangeByPercentCalculatorState extends State<ChangeByPercentCalculator> {
  final TextEditingController valueController = TextEditingController();
  final TextEditingController percentController = TextEditingController();

  ChangeType _selectedType = ChangeType.increase;
  String result = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? value = double.tryParse(valueController.text);
    final double? percent = double.tryParse(percentController.text);

    if (value == null || percent == null) {
      setState(() {
        result = locale.invalidInputMessage;
      });
      return;
    }

    final changeFactor = percent / 100;
    final output =
        _selectedType == ChangeType.increase
            ? value * (1 + changeFactor)
            : value * (1 - changeFactor);

    setState(() {
      result = '${locale.resultPrefix}${output.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.changeByPercentCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.originalValue,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: percentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.changePercent,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<ChangeType>(
              value: _selectedType,
              isExpanded: true,
              onChanged: (ChangeType? newValue) {
                if (newValue != null) {
                  setState(() => _selectedType = newValue);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ChangeType.increase,
                  child: Text(locale.increase),
                ),
                DropdownMenuItem(
                  value: ChangeType.decrease,
                  child: Text(locale.decrease),
                ),
              ],
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
