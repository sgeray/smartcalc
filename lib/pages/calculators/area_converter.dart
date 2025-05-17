import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class AreaConverter extends StatefulWidget {
  const AreaConverter({super.key});

  @override
  State<AreaConverter> createState() => _AreaConverterState();
}

class _AreaConverterState extends State<AreaConverter> {
  final TextEditingController valueController = TextEditingController();

  String result = '';

  final units = {
    'm²': 1.0,
    'ft²': 0.092903,
    'km²': 1e6,
    'ha': 10000.0,
    'ac': 4046.85642,
  };

  String fromUnit = 'm²';
  String toUnit = 'ft²';

  void convert() {
    final input = double.tryParse(valueController.text);
    if (input == null) {
      setState(
        () => result = AppLocalizations.of(context)!.invalidInputMessage,
      );
      return;
    }

    final baseValue = input * units[fromUnit]!; // convert to m²
    final converted = baseValue / units[toUnit]!;

    setState(() {
      result = '$input $fromUnit = ${converted.toStringAsFixed(4)} $toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.areaConverter)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.inputAreaValue,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromUnit,
                    decoration: InputDecoration(
                      labelText: locale.fromUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.keys.map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                    onChanged: (value) => setState(() => fromUnit = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toUnit,
                    decoration: InputDecoration(
                      labelText: locale.toUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.keys.map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                    onChanged: (value) => setState(() => toUnit = value!),
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
