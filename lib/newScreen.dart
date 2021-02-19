import 'package:credit_card_input_form/model/card_info.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/credit_card.dart';
import 'package:havass_coaching_flutter/pages/welcome_page.dart';
import 'package:havass_coaching_flutter/plugins/stripe_services.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'business/concrete/login_operations.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

final cardDecoration = BoxDecoration(
    boxShadow: <BoxShadow>[
      BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
    ],
    gradient: LinearGradient(
        colors: [
          Colors.red,
          Colors.blue,
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
    borderRadius: BorderRadius.all(Radius.circular(15)));

class _NewScreenState extends State<NewScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("New Screen"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer items go in here
          ],
        ),
      ),
      body: Container(
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
                  print(now);
                },
              ),
              CreditCardInputForm(
                cardHeight: 170,
                showResetButton: true,
                onStateChange: (currentState, cardInfo) async {
                  if (currentState.toString() == "InputState.DONE") {
                    CardInfo card = CardInfo();
                    card = cardInfo;
                    int _expYear = int.parse(card.validate.split('/')[1]);
                    int _expMonth = int.parse(card.validate.split('/')[0]);
                    CreditCardWithStripe creditCard = CreditCardWithStripe(
                        card.name,
                        card.cardNumber,
                        _expYear,
                        _expMonth,
                        card.cvv);
                    var response = await StripeService.payWithNewCard(
                        amount: '150', currency: 'eur', creditCard: creditCard);
                    if (response.success) {
                      NotificationWidget.showNotification(
                          context, response.message);
                    }
                  }
                },
                frontCardDecoration: cardDecoration,
                backCardDecoration: cardDecoration,
              ),
            ],
          ),
        ),
      ),
    );

//               FlutterSummernote(
//                 hint: "Your text here...",
//                 key: _keyEditor,
//                 showBottomToolbar: true,
//                 hasAttachment: true,
//                 customToolbar: """
//     [
//       ['style', ['bold', 'italic', 'underline', 'clear']],
//       ['font', ['strikethrough', 'superscript', 'subscript']],
//       ['font', ['fontsize', 'fontname']],
//       ['color', ['forecolor', 'backcolor']],
//       ['para', ['ul', 'ol', 'paragraph']],
//       ['height', ['height']],
//       ['view', ['fullscreen']]
//     ]
//   """,
//                 customPopover: """
//     image: [
//       ['image', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
//       ['float', ['floatLeft', 'floatRight', 'floatNone']],
//       ['remove', ['removeMedia']]
//     ],
//     link: [
//       ['link', ['linkDialogShow', 'unlink']]
//     ],
//     table: [
//       ['add', ['addRowDown', 'addRowUp', 'addColLeft', 'addColRight']],
//       ['delete', ['deleteRow', 'deleteCol', 'deleteTable']],
//     ],
//     air: [
//       ['color', ['color']],
//       ['font', ['bold', 'underline', 'clear']],
//       ['para', ['ul', 'paragraph']],
//       ['table', ['table']],
//       ['insert', ['link', 'picture']]
//     ]
// """,
//               ),
  }
}
