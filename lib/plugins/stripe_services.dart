import 'dart:convert';
import 'package:credit_card_input_form/model/card_info.dart';
import 'package:havass_coaching_flutter/model/credit_card.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

import 'firebase_auth_services/login_operations.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51IDE6aBqOxVQ2IQTBndyrEFbaGXFTnVdvDfNUFpSqlvBpCPG33CMhViDOtiKGi97cIz86hhhGOdWE4NebP0VPVLR00CeMst1EE';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {}

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount,
      String currency,
      CreditCardWithStripe creditCard,
      String courseName}) async {
    var response;
    try {
      LoginOperations _loginOperation = LoginOperations.getInstance();
      BillingDetails billingDetails = BillingDetails();
      billingDetails.name = _loginOperation.getLoginUserEmail();
      var _paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(
              card: creditCard, billingDetails: billingDetails));
      var _paymentIntent = await StripeService._createPaymentIntent(
          amount, currency, courseName);

      response = await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: _paymentIntent['client_secret'],
        paymentMethodId: _paymentMethod.id,
      ));
      print(response);
      return new StripeTransactionResponse(
          message: "Transaction success", success: true);
    } catch (e) {
      print(response);
      return new StripeTransactionResponse(
          message: "Transaction failed:${e.toString()}", success: false);
    }
  }

  static Future<Map<String, dynamic>> _createPaymentIntent(
      String amount, String currency, String description) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
        'description': description
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: headers);
      return Map<String, dynamic>.from(jsonDecode(response.body));
    } catch (err) {
      print("err charing user:${err.toString()}");
    }
    return null;
  }

  static CreditCardWithStripe createCreditCard(CardInfo cardInfo) {
    int _expMonth = int.parse(cardInfo.validate.split('/')[0]);
    int _expYear = int.parse(cardInfo.validate.split('/')[1]);
    CreditCardWithStripe creditCard = CreditCardWithStripe(
        cardInfo.name, cardInfo.cardNumber, _expYear, _expMonth, cardInfo.cvv);

    return creditCard;
  }
}
