import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/card_input_formatter.dart';
import '../components/master_card.dart';
import '../constants.dart';
import '../components/card_detection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  final FlipCardController flipCardController = FlipCardController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String cardBrand = "visa";

  String? selectedMonth;
  String? selectedYear;

  final List<String> months = [
    for (var i = 1; i <= 12; i++) i.toString().padLeft(2, '0')
  ];
  final List<String> years = [
    for (var i = DateTime.now().year; i < DateTime.now().year + 10; i++)
      (i % 100).toString().padLeft(2, '0')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              FlipCard(
                fill: Fill.fillFront,
                direction: FlipDirection.HORIZONTAL,
                controller: flipCardController,
                flipOnTouch: true,
                front: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: buildCreditCard(
                    color: kDarkBlue,
                    cardHolder: cardHolderNameController.text.isEmpty
                        ? "Card Holder"
                        : cardHolderNameController.text.toUpperCase(),
                    cardNumber: cardNumberController.text.isEmpty
                        ? "#### #### #### ####"
                        : cardNumberController.text,
                    cardBrand: cardBrand,
                    month: selectedMonth ?? "MM",
                    year: selectedYear ?? "YY",
                  ),
                ),
                back: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Container(
                      height: 230,
                      padding: const EdgeInsets.only(bottom: 22.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: const DecorationImage(
                          image:
                              AssetImage('assets/images/card_background.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 15),
                          Container(
                            height: 45,
                            width: 500,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              color: Colors.white,
                              child: SizedBox(
                                height: 45,
                                width: 500,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    cardCvvController.text.isEmpty
                                        ? "CVV  "
                                        : cardCvvController.text,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                "assets/logos/$cardBrand.png",
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Column(
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(
                            cardBrand == "amex" ? 15 : 16),
                        CardInputFormatter(),
                      ],
                      validator: (value) {
                        if (cardBrand == "amex" && value!.length < 15) {
                          return 'Please enter a valid card number';
                        }
                        if (cardBrand != "amex" && value!.length < 16) {
                          return 'Please enter a valid card number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                        setState(() {
                          cardNumberController.value =
                              cardNumberController.value.copyWith(
                            text: text,
                            selection:
                                TextSelection.collapsed(offset: text.length),
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Expiry Date',
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
                          //Månad
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          const SizedBox(width: 10),
                          //År
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          )
                        ],
                      )
                    ],
                  ),

                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CVV',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width / 2.4,
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
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          onTap: () {
                            setState(() {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                flipCardController.toggleCard();
                              });
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              int length = value.length;
                              if (length == 4 || length == 9 || length == 14) {
                                cardNumberController.text = '$value ';
                                cardNumberController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(offset: value.length + 1),
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
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
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      cardCvvController.clear();
                      cardExpiryDateController.clear();
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid xomehting!'),
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
        )),
      ),
    );
  }
}
