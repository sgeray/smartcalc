import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController amountController = TextEditingController();
  String from = 'USD';
  String to = 'EUR';
  String result = '';

  // Example static exchange rates relative to USD
  final Map<String, double> rates = {
    'USD': 1.0,
    'EUR': 0.92,
    'GBP': 0.78,
    'TRY': 32.50,
    'JPY': 154.0,
  };

  void convert() {
    final input = double.tryParse(amountController.text);
    if (input == null) {
      setState(
        () => result = AppLocalizations.of(context)!.invalidInputMessage,
      );
      return;
    }

    final base = input / rates[from]!;
    final converted = base * rates[to]!;

    setState(() {
      result = '$input $from = ${converted.toStringAsFixed(2)} $to';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.currencyConverter)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.amount,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: from,
                    decoration: InputDecoration(
                      labelText: locale.fromCurrency,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        rates.keys.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                    onChanged: (value) => setState(() => from = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: to,
                    decoration: InputDecoration(
                      labelText: locale.toCurrency,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        rates.keys.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                    onChanged: (value) => setState(() => to = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
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
