import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class SpeedConverter extends StatefulWidget {
  const SpeedConverter({super.key});

  @override
  State<SpeedConverter> createState() => _SpeedConverterState();
}

class _SpeedConverterState extends State<SpeedConverter> {
  final TextEditingController speedController = TextEditingController();
  String result = '';

  final units = {
    'km/h': 1.0,
    'm/s': 0.277778,
    'mph': 0.621371,
    'ft/s': 0.911344,
    'knots': 0.539957,
  };

  String from = 'km/h';
  String to = 'm/s';

  void convert() {
    final input = double.tryParse(speedController.text);
    if (input == null) {
      setState(
        () => result = AppLocalizations.of(context)!.invalidInputMessage,
      );
      return;
    }

    final baseValue = input / units[from]!; // convert to km/h base
    final converted = baseValue * units[to]!;

    setState(() {
      result = '$input $from = ${converted.toStringAsFixed(4)} $to';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.speedConverter)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: speedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.inputSpeedValue,
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
                      labelText: locale.fromSpeedUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.keys.map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
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
                      labelText: locale.toSpeedUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.keys.map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
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
