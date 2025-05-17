import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class VatCalculator extends StatefulWidget {
  const VatCalculator({super.key});

  @override
  State<VatCalculator> createState() => _VatCalculatorState();
}

class _VatCalculatorState extends State<VatCalculator> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController vatRateController = TextEditingController();

  String vat = '';
  String total = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? price = double.tryParse(priceController.text);
    final double? rate = double.tryParse(vatRateController.text);

    if (price == null || rate == null) {
      setState(() {
        vat = locale.invalidInputMessage;
        total = '';
      });
      return;
    }

    final double vatAmount = price * (rate / 100);
    final double totalPrice = price + vatAmount;

    setState(() {
      vat = '${locale.vatAmount}: ${vatAmount.toStringAsFixed(2)}';
      total = '${locale.priceWithVat}: ${totalPrice.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.vatCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.priceWithoutVat,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: vatRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.vatRate,
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
            Text(vat, style: AppStyles.resultTextStyle),
            const SizedBox(height: 8),
            Text(total, style: AppStyles.resultTextStyle),
          ],
        ),
      ),
    );
  }
}
