import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({super.key});

  @override
  State<LoanCalculator> createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController monthsController = TextEditingController();

  String result = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? amount = double.tryParse(amountController.text);
    final double? rate = double.tryParse(rateController.text);
    final int? months = int.tryParse(monthsController.text);

    if (amount == null || rate == null || months == null || months <= 0) {
      setState(() {
        result = locale.invalidInputMessage;
      });
      return;
    }

    // Simple flat interest formula (not compound):
    final totalInterest = amount * (rate / 100) * (months / 12);
    final totalRepay = amount + totalInterest;
    final monthly = totalRepay / months;

    setState(() {
      result = '${locale.monthlyPayment}: ${monthly.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.loanCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.loanAmount,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.interestRate,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: monthsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.months,
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
