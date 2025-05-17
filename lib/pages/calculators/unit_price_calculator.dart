import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class UnitPriceCalculator extends StatefulWidget {
  const UnitPriceCalculator({super.key});

  @override
  State<UnitPriceCalculator> createState() => _UnitPriceCalculatorState();
}

class _UnitPriceCalculatorState extends State<UnitPriceCalculator> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String result = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? price = double.tryParse(priceController.text);
    final double? quantity = double.tryParse(quantityController.text);

    if (price == null || quantity == null || quantity <= 0) {
      setState(() {
        result = locale.invalidInputMessage;
      });
      return;
    }

    final unitPrice = price / quantity;

    setState(() {
      result = '${locale.pricePerUnit}: ${unitPrice.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.unitPriceCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.totalPrice,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.quantity,
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
