import 'package:flutter/services.dart';

class MinuteTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    int value = int.tryParse(newValue.text) ?? 0;
    if (value < 0 || value > 59) {
      return oldValue;
    }
    return newValue;
  }
}
