import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/card_alert_dialog.dart';
import '../components/card_input_formatter.dart';
import '../components/card_month_input_formatter.dart';
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
  String cardBrand = "visa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              FlipCard(
                  fill: Fill.fillFront,
                  direction: FlipDirection.HORIZONTAL,
                  controller: flipCardController,
                  flipOnTouch: false,
                  front: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildCreditCard(
                      color: kDarkBlue,
                      cardExpiration: cardExpiryDateController.text.isEmpty
                          ? "08/2022"
                          : cardExpiryDateController.text,
                      cardHolder: cardHolderNameController.text.isEmpty
                          ? "Card Holder"
                          : cardHolderNameController.text.toUpperCase(),
                      cardNumber: cardNumberController.text.isEmpty
                          ? "#### #### #### ####"
                          : cardNumberController.text,
                      cardBrand: cardBrand,
                    ),
                  ),
                  back: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 4.0,
                      color: kDarkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        height: 230,
                        padding: const EdgeInsets.only(bottom: 22.0),
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
                                color: Colors.white, // Backaground color
                                child: SizedBox(
                                  height: 35,
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
                              padding: const EdgeInsets.all(
                                  16.0), // Adjust padding as needed
                              child: Align(
                                alignment: Alignment
                                    .centerRight, // Aligns the child to the right
                                child: Image.asset(
                                  "assets/logos/$cardBrand.png", // Dynamic logo
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
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
                        LengthLimitingTextInputFormatter(16),
                        CardInputFormatter(),
                      ],
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
                  const SizedBox(height: 12),
                  const Text(
                    'Expiry Date',
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
                      controller: cardExpiryDateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardDateInputFormatter(),
                      ],
                      onChanged: (value) {
                        var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                        setState(() {
                          cardExpiryDateController.value =
                              cardExpiryDateController.value.copyWith(
                                  text: text,
                                  selection: TextSelection.collapsed(
                                      offset: text.length),
                                  composing: TextRange.empty);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CVV Label
                      const Text(
                        'CVV',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // CVV Text Field
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
              const SizedBox(height: 20 * 3),
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
                  Future.delayed(const Duration(milliseconds: 300), () {
                    showDialog(
                        context: context,
                        builder: (context) => const CardAlertDialog());
                    cardCvvController.clear();
                    cardExpiryDateController.clear();
                    cardHolderNameController.clear();
                    cardNumberController.clear();
                    flipCardController.toggleCard();
                  });
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
      ),
    );
  }
}
