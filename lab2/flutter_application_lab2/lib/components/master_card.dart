import 'package:flutter/material.dart';
import '../components/card_detection.dart';

Card buildCreditCard({
  required String cardNumber,
  required Color color,
  required String cardHolder,
  required String cardExpiration,
  required String cardBrand,
}) {
  String cardBrand = getCardBrand(cardNumber);

  return Card(
    elevation: 4.0,
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 9.0, bottom: 16.0),
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
                  "assets/logos/$cardBrand.png", // Dynamic logo
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
              buildDetailsBlock(
                label: 'Full Holder',
                value: cardHolder,
              ),
              buildDetailsBlock(label: 'Expires', value: cardExpiration),
            ],
          ),
        ],
      ),
    ),
  );
}


Column buildDetailsBlock({required String label, required String value}) {
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
      )
    ],
  );
}
