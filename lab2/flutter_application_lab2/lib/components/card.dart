import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class FlipCardComponent extends StatelessWidget {
  final FlipCardController flipCardController;
  final String cardBrand;
  final String cardHolder;
  final String cardNumber;
  final String month;
  final String year;
  final String cvv;

  const FlipCardComponent({
    Key? key,
    required this.flipCardController,
    required this.cardBrand,
    required this.cardHolder,
    required this.cardNumber,
    required this.month,
    required this.year,
    required this.cvv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillFront,
      direction: FlipDirection.HORIZONTAL,
      controller: flipCardController,
      flipOnTouch: true,
      front: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _buildCreditCard(
          color: const Color.fromARGB(255, 18, 16, 113),
          cardHolder: cardHolder,
          cardNumber: cardNumber,
          cardBrand: cardBrand,
          month: month,
          year: year,
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
                image: AssetImage('assets/images/card_background.jpeg'),
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
                          cvv.isEmpty ? "CVV  " : cvv,
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
    );
  }


/// FRONT OF THE CARD ///
  Card _buildCreditCard({
    required String cardNumber,
    required Color color,
    required String cardHolder,
    required String cardBrand,
    required String month,
    required String year,
  }) {
    final String cardExpiration =
        month.isEmpty || year.isEmpty ? "MM/YY" : "$month/$year";

    //String formattedCardNumber = formatCardNumber(cardNumber, cardBrand);
    return Card(
      elevation: 20.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: const DecorationImage(
            image: AssetImage("assets/images/card_background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, top: 9.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/chip.png",
                        height: 50,
                        width: 60,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  Image.asset(
                    "assets/logos/$cardBrand.png", 
                    height: 60,
                    width: 60,
                  ),
                ],
              ),
            ),
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                letterSpacing: 4,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'Full Holder',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'Expires', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: .5,
          ),
        ),
      ],
    );
  }
}

String formatCardNumber(String cardNumber, String cardBrand) {

  List<int> groupings = cardBrand == 'amex' ? [4, 6, 5] : [4, 4, 4, 4];

  String cleanedNumber = cardNumber.replaceAll(' ', '');

  String paddedNumber = cleanedNumber.padRight(
    groupings.reduce((value, element) => value + element),
    '#',
  );

  StringBuffer buffer = StringBuffer();
  int currentIndex = 0;

  for (int group in groupings) {
    if (currentIndex >= paddedNumber.length) break;
    int endIndex = currentIndex + group;
    if (endIndex > paddedNumber.length) endIndex = paddedNumber.length;
    buffer.write(paddedNumber.substring(currentIndex, endIndex));
    if (endIndex < paddedNumber.length) buffer.write(" ");
    currentIndex = endIndex;
  }

  return buffer.toString();
}