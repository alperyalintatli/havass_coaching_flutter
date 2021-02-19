import 'dart:convert';
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
  static init() {}
  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    PaymentMethod _paymentMethod = PaymentMethod();
    try {
      _paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      print(jsonEncode(_paymentMethod));
      return new StripeTransactionResponse(
          message: "Transaction success", success: true);
    } catch (e) {
      if (_paymentMethod.card == null) {
        return new StripeTransactionResponse(
            message: "Alanlar boş bırakıldığı için işlem iptal edildi.",
            success: true);
      }
      return new StripeTransactionResponse(
          message: "Transaction failed:${e.toString()}", success: true);
    }
  }

  // static createPaymentIntent(String amount, String currency) async {
  //   try {
  //     var response =await
  //   } catch (err) {
  //     print("err charing user:${err.toString()}");
  //   }
  //   return null;
  // }
}
