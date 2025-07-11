import 'package:flutter/services.dart';

/// It takes the input text, adds a space after every 4 characters, and returns the
/// new value
class CreditCardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final bufferString = StringBuffer();
    for (var i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      final nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    final string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
