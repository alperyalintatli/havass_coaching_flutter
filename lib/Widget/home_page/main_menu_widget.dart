import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:credit_card_input_form/model/card_info.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/pages/welcome_page.dart';
import 'package:havass_coaching_flutter/plugins/stripe_services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '../notification_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  LoginOperations _loginOperation = LoginOperations.getInstance();
  var _selectedDate = DateTime.now();
  var cardDecoration = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/credit_card_backgorund_image.jpg')),
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
      ],
      color: Colors.black,
      // gradient:LinearGradient(
      //     colors: [
      //       Colors.red,
      //       Colors.blue,
      //     ],
      //     begin: const FractionalOffset(0.0, 0.0),
      //     end: const FractionalOffset(1.0, 0.0),
      //     stops: [0.0, 1.0],
      //     tileMode: TileMode.clamp),
      borderRadius: BorderRadius.all(Radius.circular(15)));

  @override
  void initState() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IMH5EGSjSaX6w4pG6yIc0YrmpryVSYwiZxF8juGdBY5tGeahVJ3YKhp8xluADB3gn8nR4NKnP4SldDhN1MSqDW300mtOnDxQ3",
        merchantId: "Test",
        androidPayMode: 'test'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
                child: Text("LogOut"),
                onPressed: () async {
                  await _loginOperation.signOut().whenComplete(() =>
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()),
                          (Route<dynamic> route) => false));
                }),
            TextButton(
              child: Text("Date"),
              onPressed: () async {
                var now = new DateTime.now();
                Map<String, dynamic> map = Map<String, dynamic>();
                for (var i = 1; i < 12; i++) {
                  now = now.add(Duration(days: 1));
                  map[now.day.toString() +
                      "/" +
                      now.month.toString() +
                      "/" +
                      now.year.toString() +
                      "/" +
                      now.hour.toString()] = i.toString() + "Page";
                }
                print(map);
              },
            ),
            // CreditCardInputForm(
            //   cardHeight: 230,
            //   showResetButton: true,
            //   onStateChange: (currentState, cardInfo) async {
            //     if (currentState == InputState.DONE) {
            //       CardInfo infCard = CardInfo();
            //       infCard = cardInfo;
            //       _paymentWithStripe(infCard);
            //     }
            //   },
            //   frontCardDecoration: cardDecoration,
            //   backCardDecoration: cardDecoration,
            // ),
            Container(
              margin: EdgeInsets.all(5),
              child: CalendarTimeline(
                initialDate: _selectedDate,
                firstDate: DateTime(2021, 02, 10),
                lastDate: DateTime(2021, 02, 10).add(Duration(days: 30)),
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                    print(date.day);
                  });
                },
                leftMargin: 20,
                monthColor: Colors.white,
                dayColor: Colors.teal[200],
                dayNameColor: Color(0xFF333A47),
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.redAccent[100],
                dotsColor: Color(0xFF333A47),
                // selectableDayPredicate: (date) => date.day != 23,
                locale: 'en',
              ),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  void _paymentWithStripe(CardInfo cardInfo) async {
    var creditCard = StripeService.createCreditCard(cardInfo);
    var response = await StripeService.payWithNewCard(
        amount: '150', currency: 'eur', creditCard: creditCard);
    if (response.success) {
      NotificationWidget.showNotification(context, response.message);
    }
  }
}
