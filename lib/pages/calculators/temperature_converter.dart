import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController tempController = TextEditingController();
  String result = '';

  final List<String> units = ['°C', '°F', 'K'];
  String from = '°C';
  String to = '°F';

  void convert() {
    final input = double.tryParse(tempController.text);
    if (input == null) {
      setState(
        () => result = AppLocalizations.of(context)!.invalidInputMessage,
      );
      return;
    }

    double tempInC;

    // Convert input to Celsius
    if (from == '°C') {
      tempInC = input;
    } else if (from == '°F') {
      tempInC = (input - 32) * 5 / 9;
    } else {
      tempInC = input - 273.15;
    }

    double converted;

    // Convert Celsius to target
    if (to == '°C') {
      converted = tempInC;
    } else if (to == '°F') {
      converted = (tempInC * 9 / 5) + 32;
    } else {
      converted = tempInC + 273.15;
    }

    setState(() {
      result = '$input $from = ${converted.toStringAsFixed(2)} $to';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.temperatureConverter)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.inputTemperatureValue,
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
                      labelText: locale.fromTemperatureUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.map((u) {
                          return DropdownMenuItem(value: u, child: Text(u));
                        }).toList(),
                    onChanged: (value) => setState(() => from = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: to,
                    decoration: InputDecoration(
                      labelText: locale.toTemperatureUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.map((u) {
                          return DropdownMenuItem(value: u, child: Text(u));
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
