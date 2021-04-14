import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:credit_card_input_form/model/card_info.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/courses.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
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
  DateAndNoteProvider _dateAndNoteProvider;
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
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    _dateAndNoteProvider = Provider.of<DateAndNoteProvider>(context);
    return CreditCardInputForm(
      cardHeight: 230,
      showResetButton: true,
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
    var creditCard = StripeService.createCreditCard(cardInfo);
    var response = await StripeService.payWithNewCard(
        amount: (_cartProvider.totalAmount * 100).toString(),
        currency: 'eur',
        creditCard: creditCard);
    if (response.success) {
      await _hvsUserProvider.getUser();
      Course course1 = Course();
      course1.courseName = "Havassyenikurs";
      course1.courseComment = "idare eder";
      List<DatesToPdf> listDates = List<DatesToPdf>();

      var dateTime = DateTime.now();
      var now = dateTime.day.toString() +
          "." +
          dateTime.month.toString() +
          "." +
          dateTime.year.toString();
      for (var i = 0; i < 21; i++) {
        DatesToPdf datesToPdf = DatesToPdf();
        String date = dateTime.day.toString() +
            "." +
            dateTime.month.toString() +
            "." +
            dateTime.year.toString();
        datesToPdf.date = date;
        if (date == now) {
          datesToPdf.pdfName = "sample.pdf";
        } else {
          datesToPdf.pdfName = "havas123.pdf";
        }
        listDates.add(datesToPdf);
        dateTime = dateTime.add(Duration(days: 1));
      }
      course1.dates = listDates;
      List<Course> course = List<Course>();
      course.add(course1);
      _hvsUserProvider.getHvsUser.course = course;
      await _hvsUserProvider.createCourse(_hvsUserProvider.getHvsUser);
      var dateList =
          _hvsUserProvider.getHvsUser.course.last.dates.first.date.split(".");
      _dateAndNoteProvider.getStartDate(DateTime(
          int.parse(dateList[2].toString()),
          int.parse(dateList[1].toString()),
          int.parse(dateList[0].toString())));
      NotificationWidget.showNotification(context, response.message);
    }
  }
}
