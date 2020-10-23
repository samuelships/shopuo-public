enum PaymentMethod {
  MtnMobileMoney,
  VodafoneCash,
  AirtelTigoMoney,
  Visa,
  Mastercard
}

class MobileMoneyModel {
  final PaymentMethod network;
  final int number;
  final int voucher;

  MobileMoneyModel({this.network, this.number, this.voucher});
}

class CardModel {
  final name;
  final cardNumber;
  final expiryMonth;
  final expiryYear;
  final cvv;

  CardModel({
    this.name,
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
  });
}
