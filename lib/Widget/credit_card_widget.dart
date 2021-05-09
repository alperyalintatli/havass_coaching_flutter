import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:credit_card_input_form/model/card_info.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/home_page.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/plugins/stripe_services.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CreditCardWidget extends StatefulWidget {
  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  HvsUserProvider _hvsUserProvider;
  CartProvider _cartProvider;
  @override
  void initState() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IDE6aBqOxVQ2IQT2d6cFzQOL5apDfoRSRtO8wJSyh3LE5w3hMIiajG4tqo6cNsSy55YYBdhWPBxHYa9jU1bIm7n006LmyOJWY",
        merchantId: "Test",
        androidPayMode: 'test'));
    super.initState();
  }

  var cardDecoration = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/credit_card_backgorund_image.jpg')),
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
      ],
      color: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(15)));

  final _buttonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30.0),
    gradient: LinearGradient(
        colors: [
          const Color.fromRGBO(154, 206, 207, 1),
          const Color.fromRGBO(24, 231, 239, 1),
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
  );

  final _buttonTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);
  bool isPaymentSuccess = false;
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    return isPaymentSuccess
        ? CircularProgressIndicator()
        : CreditCardInputForm(
            cardHeight: 230,
            showResetButton: true,
            nextButtonDecoration: _buttonDecoration,
            nextButtonTextStyle: _buttonTextStyle,
            prevButtonDecoration: _buttonDecoration,
            prevButtonTextStyle: _buttonTextStyle,
            onStateChange: (currentState, cardInfo) async {
              if (currentState == InputState.DONE) {
                CardInfo infCard = CardInfo();
                infCard = cardInfo;
                _paymentWithStripe(infCard);
              }
            },
            frontCardDecoration: cardDecoration,
            backCardDecoration: cardDecoration,
          );
  }

  void _paymentWithStripe(CardInfo cardInfo) async {
    try {
      var creditCard = StripeService.createCreditCard(cardInfo);
      _cartProvider.changeIsPayment();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
      String coursesName = "";
      _cartProvider.items.forEach((key, value) async {
        coursesName = coursesName + _cartProvider.items[key].title + " ";
      });
      var response = await StripeService.payWithNewCard(
          amount: (_cartProvider.totalAmount * 100).toString(),
          currency: 'eur',
          creditCard: creditCard,
          courseName: coursesName);
      if (response.success) {
        int number = 0;
        _cartProvider.items.forEach((key, value) async {
          var result = await _hvsUserProvider.saveCourse(value.id);
          number++;
          if (_cartProvider.items.length == number) {
            if (result) {
              _cartProvider.clear();
              _cartProvider.changeIsPayment();
              NotificationWidget.showNotification(
                  context, AppLocalizations.getString("success_payment"));
            } else {
              NotificationWidget.showNotification(context,
                  AppLocalizations.getString("failed_payment_notification"));
            }
          }
        });
      } else {
        _cartProvider.changeIsPayment();
        NotificationWidget.showNotification(
            context, AppLocalizations.getString("failed_payment_notification"));
      }
    } catch (e) {
      NotificationWidget.showNotification(context,
          AppLocalizations.getString("failed_credit_card_notification"));
    }
  }
}
