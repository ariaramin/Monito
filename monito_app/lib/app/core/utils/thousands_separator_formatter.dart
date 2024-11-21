import 'package:flutter/services.dart'
    show TextEditingValue, TextInputFormatter, TextSelection;
import 'package:intl/intl.dart' show NumberFormat;

class ThousandsSeparatorFormatter extends TextInputFormatter {
  // Setup a formatter that supports both commas for thousands and decimals
  final formatter = NumberFormat("#,##0.###");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    // Remove commas to check the new input and for parsing
    final newText = newValue.text.replaceAll(',', '');
    // Try parsing the input as a double
    final num? newTextAsNum = num.tryParse(newText);

    if (newTextAsNum == null) {
      return oldValue; // Return old value if new value is not a number
    }

    // Split the input into whole number and decimal parts
    final parts = newText.split('.');
    if (parts.length > 1) {
      // If there's a decimal part, format accordingly
      final integerPart = int.tryParse(parts[0]) ?? 0;
      final decimalPart = parts[1];
      // Handle edge case where decimal part is present but empty (user just typed the dot)
      final formattedText = '${formatter.format(integerPart)}.$decimalPart';
      return TextEditingValue(
        text: formattedText,
        selection: updateCursorPosition(formattedText),
      );
    } else {
      // No decimal part, format the whole number
      final newFormattedText = formatter.format(newTextAsNum);
      return TextEditingValue(
        text: newFormattedText,
        selection: updateCursorPosition(newFormattedText),
      );
    }
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.collapsed(offset: text.length);
  }
}
