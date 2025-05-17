import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_styles.dart';

class DiscountCalculator extends StatefulWidget {
  const DiscountCalculator({super.key});

  @override
  State<DiscountCalculator> createState() => _DiscountCalculatorState();
}

class _DiscountCalculatorState extends State<DiscountCalculator> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController percentController = TextEditingController();

  String discount = '';
  String finalPrice = '';

  void calculate() {
    final locale = AppLocalizations.of(context)!;
    final double? price = double.tryParse(priceController.text);
    final double? percent = double.tryParse(percentController.text);

    if (price == null || percent == null) {
      setState(() {
        discount = locale.invalidInputMessage;
        finalPrice = '';
      });
      return;
    }

    final double discountValue = price * (percent / 100);
    final double discountedPrice = price - discountValue;

    setState(() {
      discount =
          '${locale.discountAmount}: ${discountValue.toStringAsFixed(2)}';
      finalPrice =
          '${locale.finalPrice}: ${discountedPrice.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.discountCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.originalPrice,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: percentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: locale.discountPercent,
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
            Text(discount, style: AppStyles.resultTextStyle),
            const SizedBox(height: 8),
            Text(finalPrice, style: AppStyles.resultTextStyle),
          ],
        ),
      ),
    );
  }
}
