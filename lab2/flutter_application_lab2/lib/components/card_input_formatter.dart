import 'package:flutter/services.dart';

class CardInputFormatter extends TextInputFormatter {
  final String cardType;

  CardInputFormatter({required this.cardType});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text.replaceAll(" ", "");
    StringBuffer buffer = StringBuffer();

    List<int> groupings = cardType == 'amex' ? [4, 6, 5] : [4, 4, 4, 4];

    int currentIndex = 0;
    for (int group in groupings) {
      if (currentIndex >= inputData.length) break;
      int endIndex = currentIndex + group;
      if (endIndex > inputData.length) endIndex = inputData.length;
      buffer.write(inputData.substring(currentIndex, endIndex));
      if (endIndex < inputData.length) buffer.write(" ");
      currentIndex = endIndex;
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}