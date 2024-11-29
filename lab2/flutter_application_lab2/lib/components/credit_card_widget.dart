import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

class CreditCardWidget extends StatelessWidget {
  final FlipCardController controller;
  final String cardNumber;
  final String cardHolder;
  final String cardBrand;
  final String month;
  final String year;
  final String cvv;

  const CreditCardWidget({
    Key? key,
    required this.controller,
    required this.cardNumber,
    required this.cardHolder,
    required this.cardBrand,
    required this.month,
    required this.year,
    required this.cvv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: controller,
      flipOnTouch: true,
      direction: FlipDirection.HORIZONTAL,
      front: buildCreditCard(
        color: Colors.blue,
        cardHolder: cardHolder.isEmpty ? "Card Holder" : cardHolder.toUpperCase(),
        cardNumber: cardNumber.isEmpty ? "#### #### #### ####" : cardNumber,
        cardBrand: cardBrand,
        month: month.isEmpty ? "MM" : month,
        year: year.isEmpty ? "YY" : year,
      ),
      back: buildCardBack(cvv, cardBrand),
    );
  }

  Widget buildCreditCard({
    required Color color,
    required String cardHolder,
    required String cardNumber,
    required String cardBrand,
    required String month,
    required String year,
  }) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cardNumber, style: const TextStyle(fontSize: 22, color: Colors.white)),
            const SizedBox(height: 10),
            Text("Card Holder: $cardHolder", style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text("Expiry: $month/$year", style: const TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget buildCardBack(String cvv, String cardBrand) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child: Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
        Container(color: Colors.black, height: 50), 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("CVV: $cvv", style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(height: 10), 
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset(
            "assets/logos/$cardBrand.png",
            height: 50,
          ),
        ),
      ],
    ),
  );
}

}
