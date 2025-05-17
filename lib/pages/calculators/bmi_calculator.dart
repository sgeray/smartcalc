import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String result = '';
  String category = '';

  void calculateBmi() {
    final locale = AppLocalizations.of(context)!;
    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height <= 0) {
      setState(() {
        result = locale.invalidInputMessage;
        category = '';
      });
      return;
    }

    final bmi = weight / ((height / 100) * (height / 100));
    String cat;

    if (bmi < 18.5) {
      // Add localization here?
      cat = 'Underweight';
    } else if (bmi < 24.9) {
      cat = 'Normal';
    } else if (bmi < 29.9) {
      cat = 'Overweight';
    } else {
      cat = 'Obese';
    }

    setState(() {
      result = '${locale.yourBmi}: ${bmi.toStringAsFixed(2)}';
      category = '${locale.bmiCategory}: $cat';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.bmiCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.heightCm,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.weightKg,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBmi,
              style: AppStyles.primaryButton,
              child: Text(locale.calculate, style: AppStyles.primaryButtonText),
            ),
            const SizedBox(height: 20),
            Text(result, style: AppStyles.resultTextStyle),
            const SizedBox(height: 8),
            Text(category, style: AppStyles.resultTextStyle),
          ],
        ),
      ),
    );
  }
}
