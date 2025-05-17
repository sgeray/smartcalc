import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final TextEditingController billController = TextEditingController();
  final TextEditingController tipController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();

  String total = '';
  String perPerson = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? bill = double.tryParse(billController.text);
    final double? tip = double.tryParse(tipController.text);
    final int? people = int.tryParse(peopleController.text);

    if (bill == null || tip == null || bill <= 0) {
      setState(() {
        total = locale.invalidInputMessage;
        perPerson = '';
      });
      return;
    }

    final tipAmount = bill * (tip / 100);
    final totalAmount = bill + tipAmount;
    final split =
        (people != null && people > 0)
            ? (totalAmount / people).toStringAsFixed(2)
            : '-';

    setState(() {
      total = '${locale.totalWithTip}: ${totalAmount.toStringAsFixed(2)}';
      perPerson =
          people != null && people > 0 ? '${locale.perPerson}: $split' : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.tipCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: billController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.billAmount,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: tipController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.tipPercent,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: peopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.peopleCount,
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
            Text(total, style: AppStyles.resultTextStyle),
            const SizedBox(height: 8),
            Text(perPerson, style: AppStyles.resultTextStyle),
          ],
        ),
      ),
    );
  }
}
