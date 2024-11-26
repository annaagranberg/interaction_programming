String getCardBrand(String cardNumber) {
  if (RegExp(r'^4').hasMatch(cardNumber)) {
    return "visa";
  } else if (RegExp(r'^5[1-5]').hasMatch(cardNumber)) {
    return "mastercard";
  } else if (RegExp(r'^3[47]').hasMatch(cardNumber)) {
    return "amex";
  } else if (RegExp(r'^6(?:011|5)').hasMatch(cardNumber)) {
    return "discover";
  } else if (RegExp(r'^35').hasMatch(cardNumber)) {
    return "jcb";
  } else if (RegExp(r'^3(?:0[0-5]|[68])').hasMatch(cardNumber)) {
    return "dinersclub";
  } else if (RegExp(r'^62').hasMatch(cardNumber)) {
    return "union_pay";
  } else if (RegExp(r'^9792').hasMatch(cardNumber)) {
    return "troy";
  }
  return "visa"; // Fallback option
}
