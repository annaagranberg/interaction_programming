import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/card.dart';
import 'components/card_input_formatter.dart';
import 'components/card_detection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cardExpiryDateController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  final FlipCardController flipCardController = FlipCardController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String cardBrand = "visa";

  String? selectedMonth; // ? is a null-aware operator. Prevent is from craching if null???
  String? selectedYear;

  final List<String> months = [
    for (var i = 1; i <= 12; i++) i.toString().padLeft(2, '0')
  ];
  final List<String> years = [
    for (var i = DateTime.now().year; i < DateTime.now().year + 10; i++)
      (i % 100).toString().padLeft(2, '0')
  ];

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          // Form content
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 300),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Number Field
                        const Text(
                          'Card Number',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 1.12,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: cardNumberController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  cardBrand == "amex" ? 15 : 16),
                              CardInputFormatter(cardType: cardBrand),
                            ],
                            validator: (value) {
                              if (cardBrand == "amex" && value!.length < 15) {
                                return 'Please enter a valid card number';
                              }
                              if (cardBrand != "amex" &&
                                  value!.length < 16) {
                                return 'Please enter a valid card number';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              var text =
                                  value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                              setState(() {
                                cardNumberController.value =
                                    cardNumberController.value.copyWith(
                                  text: text,
                                  selection: TextSelection.collapsed(
                                      offset: text.length),
                                  composing: TextRange.empty,
                                );
                                cardBrand = getCardBrand(text);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Card Name',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 1.12,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: cardHolderNameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid name';
                              } else if (RegExp(r'\d').hasMatch(value)) {
                                return 'Name cannot contain numbers';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                cardHolderNameController.value =
                                    cardHolderNameController.value.copyWith(
                                        text: value,
                                        selection: TextSelection.collapsed(
                                            offset: value.length),
                                        composing: TextRange.empty);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Expiry Date & CVV',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Month Dropdown
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text('MM'),
                                  value: selectedMonth,
                                  items: months
                                      .map((month) => DropdownMenuItem<String>(
                                            value: month,
                                            child: Text(month),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMonth = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Year Dropdown
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text('YY'),
                                  value: selectedYear,
                                  items: years
                                      .map((year) => DropdownMenuItem<String>(
                                            value: year,
                                            child: Text(year),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedYear = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // CVV Field
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  controller: cardCvvController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    hintText: 'CVV',
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onTap: () {
                                    setState(() {
                                      Future.delayed(
                                          const Duration(milliseconds: 300),
                                          () {
                                        flipCardController.toggleCard();
                                      });
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return 'Not valid CVV';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      cardCvvController.value =
                                          cardCvvController.value.copyWith(
                                        text: value,
                                        selection: TextSelection.collapsed(
                                            offset: value.length),
                                        composing: TextRange.empty,
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width / 1.12, 55),
                          ),
                          onPressed: () {
                            if (!_isFutureDate(selectedMonth, selectedYear)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid expiry date'),
                                ),
                              );
                              return;
                            } else if (_formKey.currentState!.validate()) {
                              setState(() {
                                cardCvvController.clear();
                                cardHolderNameController.clear();
                                cardNumberController.clear();
                                cardBrand = "visa";
                                selectedMonth = null;
                                selectedYear = null;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Card added successfully!'),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Add Card'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Floating Card
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: FlipCardComponent(
              flipCardController: flipCardController,
              cardBrand: cardBrand,
              cardHolder: cardHolderNameController.text.isEmpty
                  ? "Card Holder"
                  : cardHolderNameController.text.toUpperCase(),
              cardNumber: cardNumberController.text.isEmpty
                  ? "#### #### #### ####"
                  : formatCardNumber(cardNumberController.text, cardBrand),
              month: selectedMonth ?? "MM",
              year: selectedYear ?? "YY",
              cvv: cardCvvController.text.isEmpty ? "CVV" : cardCvvController.text,
            ),
          ),
        ],
      ),
    ),
  );
}

}



bool _isFutureDate(String? month, String? year) {
  if (month == null || year == null) return false;

  final now = DateTime.now();
  final expiryDate = DateTime(int.parse('20$year'), int.parse(month));

  return expiryDate.isAfter(now);
}
