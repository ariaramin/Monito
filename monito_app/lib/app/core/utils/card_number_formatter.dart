import 'package:flutter/services.dart'
    show TextEditingValue, TextInputFormatter, TextSelection;

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var formattedString = bufferString.toString();
    return newValue.copyWith(
      text: formattedString,
      selection: TextSelection.collapsed(offset: formattedString.length),
    );
  }
}
