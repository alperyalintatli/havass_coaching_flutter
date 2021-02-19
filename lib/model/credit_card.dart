import 'package:stripe_payment/stripe_payment.dart';

class CreditCardWithStripe extends CreditCard {
  CreditCardWithStripe(
      this._name, this._number, this._expYear, this._expMonth, this._cvc)
      : super(
            name: _name,
            number: _number,
            expYear: _expYear,
            expMonth: _expMonth,
            cvc: _cvc);
  String _name;
  String get name => _name;
  set name(String value) {
    if (value != null) {
      _name = value;
    }
  }

  String _number;
  String get number => _number;

  set number(String value) {
    if (value != null) {
      _number = value;
    }
  }

  String _cvc;
  String get cvc => _cvc;
  set cvc(String value) {
    if (value != null) {
      _cvc = value;
    }
  }

  int _expMonth;
  int get expMonth => _expMonth;
  set expMonth(int value) {
    if (value != null) {
      _expMonth = value;
    }
  }

  int _expYear;
  int get expYear => _expYear;
  set expYear(int value) {
    if (value != null) {
      _expYear = value;
    }
  }
}
