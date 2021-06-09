import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/cart_item_widget.dart'
    as cartWidget;
import 'package:havass_coaching_flutter/widget/credit_card_widget.dart';
import 'package:havass_coaching_flutter/widget/settings_drawer_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const routeName = 'cart-screen';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(),
      endDrawer: SettingsDrawerWidget(),
      body: Column(
        children: [
          Card(
            color: Color.fromRGBO(154, 206, 207, 1),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\€ ${_cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(24, 231, 239, 1),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cartProvider.itemCount,
              itemBuilder: (context, i) => cartWidget.CartItem(
                id: _cartProvider.items.values.toList()[i].id,
                price: _cartProvider.items.values.toList()[i].price,
                quantity: _cartProvider.items.values.toList()[i].quantity,
                title: _cartProvider.items.values.toList()[i].title,
                courseImagePath:
                    _cartProvider.items.values.toList()[i].courseImagePath,
              ),
            ),
          ),
          OrderButton(cart: _cartProvider)
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  Widget creditCard() {
    final _cartProvider = Provider.of<CartProvider>(context);
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 16),
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.getString("price") +
                          _cartProvider.totalAmount.toString() +
                          "€",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () => Navigator.of(context).pop(),
                      color: Colors.red,
                      iconSize: 30,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CreditCardWidget(),
                SizedBox(
                  height: 22,
                ),
              ],
            ),
          ), // bottom part
          // top part
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: RaisedButton(
        disabledColor: Colors.grey.shade400,
        color: Color.fromRGBO(154, 206, 207, 1),
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(AppLocalizations.getString("approve_cart_button_text"),
                style: TextStyle(color: Colors.white, fontSize: 18)),
        onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
            ? null
            : () {
                return showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    insetPadding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          child: creditCard(),
                        )
                      ],
                    ),
                  ),
                );
              },
        textColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
