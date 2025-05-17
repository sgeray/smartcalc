import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../core/app_styles.dart';

class DateDiffCalculator extends StatefulWidget {
  const DateDiffCalculator({super.key});

  @override
  State<DateDiffCalculator> createState() => _DateDiffCalculatorState();
}

class _DateDiffCalculatorState extends State<DateDiffCalculator> {
  DateTime? startDate;
  DateTime? endDate;
  bool useToday = true;
  String result = '';

  Future<void> pickDate(bool isStart) async {
    final initial = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDate == null) return;
    setState(() {
      if (isStart) {
        startDate = newDate;
      } else {
        endDate = newDate;
      }
    });
  }

  void calculateDifference() {
    final locale = AppLocalizations.of(context)!;

    if (startDate == null || (!useToday && endDate == null)) {
      setState(() {
        result = locale.invalidInputMessage;
      });
      return;
    }

    final from = startDate!;
    final to = useToday ? DateTime.now() : endDate!;

    final duration = to.difference(from);
    final years = (duration.inDays / 365).floor();
    final months = ((duration.inDays % 365) / 30).floor();
    final days = ((duration.inDays % 365) % 30);

    setState(() {
      result = '${locale.differenceResult}: $years y, $months m, $days d';
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.dateDiffCalculator)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: Text(locale.startDate),
              subtitle: Text(
                startDate != null ? DateFormat.yMMMd().format(startDate!) : '—',
              ),
              trailing: const Icon(Icons.calendar_month),
              onTap: () => pickDate(true),
            ),
            ListTile(
              title: Text(locale.endDate),
              subtitle: Text(
                useToday
                    ? '${locale.useToday}'
                    : (endDate != null
                        ? DateFormat.yMMMd().format(endDate!)
                        : '—'),
              ),
              trailing: const Icon(Icons.calendar_month),
              onTap: useToday ? null : () => pickDate(false),
            ),
            SwitchListTile(
              title: Text(locale.useToday),
              value: useToday,
              onChanged: (value) {
                setState(() {
                  useToday = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateDifference,
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
