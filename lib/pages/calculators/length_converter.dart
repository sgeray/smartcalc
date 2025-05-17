import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class LengthConverter extends StatefulWidget {
  const LengthConverter({super.key});

  @override
  State<LengthConverter> createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  final TextEditingController lengthController = TextEditingController();
  String result = '';

  final units = {
    'm': 1.0,
    'cm': 0.01,
    'mm': 0.001,
    'in': 0.0254,
    'ft': 0.3048,
    'yd': 0.9144,
    'km': 1000.0,
    'mi': 1609.344,
  };

  String from = 'm';
  String to = 'cm';

  void convert() {
    final input = double.tryParse(lengthController.text);
    if (input == null) {
      setState(
        () => result = AppLocalizations.of(context)!.invalidInputMessage,
      );
      return;
    }

    final base = input * units[from]!;
    final converted = base / units[to]!;

    setState(() {
      result = '$input $from = ${converted.toStringAsFixed(4)} $to';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.lengthConverter)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.inputLengthValue,
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
                      labelText: locale.fromLengthUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.keys.map((u) {
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
                      labelText: locale.toLengthUnit,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        units.keys.map((u) {
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
