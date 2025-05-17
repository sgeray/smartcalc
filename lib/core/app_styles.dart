import 'package:flutter/material.dart';

class AppStyles {
  static const heading = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const body = TextStyle(fontSize: 16);

  static const card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
    ],
  );

  static const dropdown = InputDecorationTheme(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    isDense: true,
  );

  /*static TextStyle dropdownTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  static TextStyle dropdownHintStyle = const TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );*/

  static const input = InputDecorationTheme(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );

  static TextStyle primaryButtonText = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle resultTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );
}
