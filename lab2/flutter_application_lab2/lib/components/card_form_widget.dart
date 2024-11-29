import 'package:flutter/material.dart';

class CardFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderNameController;
  final TextEditingController cardCvvController;
  final String cardBrand;
  final String? selectedMonth;
  final String? selectedYear;
  final List<String> months;
  final List<String> years;
  final void Function(String value) onCardNumberChanged;
  final void Function(String value) onCardHolderNameChanged;
  final void Function(String? value) onMonthChanged;
  final void Function(String? value) onYearChanged;
  final VoidCallback onSubmit;

  const CardFormWidget({
    Key? key,
    required this.formKey,
    required this.cardNumberController,
    required this.cardHolderNameController,
    required this.cardCvvController,
    required this.cardBrand,
    required this.selectedMonth,
    required this.selectedYear,
    required this.months,
    required this.years,
    required this.onCardNumberChanged,
    required this.onCardHolderNameChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildTextInput("Card Number", cardNumberController, onCardNumberChanged),
          buildTextInput("Card Holder", cardHolderNameController, onCardHolderNameChanged),
          buildDropdownInputs(context),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  Widget buildTextInput(String label, TextEditingController controller, Function(String) onChanged) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  Widget buildDropdownInputs(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: selectedMonth,
          items: months.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onMonthChanged,
        ),
        DropdownButton<String>(
          value: selectedYear,
          items: years.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onYearChanged,
        ),
      ],
    );
  }
}
