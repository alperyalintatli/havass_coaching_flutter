import 'dart:convert';
import 'package:havass_coaching_flutter/model/credit_card.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51IMH5EGSjSaX6w4pgZ7CXn7xnAY19lhvVa8Sxelaiiyaq42yZqqBOeNg2cdCuXdPI07S7XCnemSTeCH2YFzWHlPa00d1WWous5';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {}
  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency, CreditCardWithStripe creditCard}) async {
    try {
      var _paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: creditCard));
      var _paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: _paymentIntent['client_secret'],
          paymentMethodId: _paymentMethod.id));
      print(response);
      return new StripeTransactionResponse(
          message: "Transaction success", success: true);
    } catch (e) {
      return new StripeTransactionResponse(
          message: "Transaction failed:${e.toString()}", success: true);
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: headers);
      return Map<String, dynamic>.from(jsonDecode(response.body));
    } catch (err) {
      print("err charing user:${err.toString()}");
    }
    return null;
  }
}
