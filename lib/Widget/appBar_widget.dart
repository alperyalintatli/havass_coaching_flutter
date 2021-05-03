import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/cart_page.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
  final bool isPopup;
  final bool isCoursePage;
  @override
  final Size preferredSize;
  AppBarWidget({
    this.isPopup = true,
    this.isCoursePage = false,
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  CartProvider _cartProvider;
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    return AppBar(
      leading: widget.isPopup
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      toolbarHeight: 70,
      backgroundColor: Color.fromRGBO(164, 233, 232, 1),
      actions: [
        widget.isCoursePage == false
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              )
            : Container(),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Havass Me",
              ),
              Text(
                "App",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          _cartProvider.items.length > 0
              ? Badge(
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    cartItemCount(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage())),
                    icon: Icon(
                      Icons.shopping_cart_sharp,
                      color: Colors.white,
                    ),
                    iconSize: 32,
                  ),
                )
              : IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartPage())),
                  icon: Icon(
                    Icons.shopping_cart_sharp,
                    color: Colors.white,
                  ),
                  iconSize: 32,
                ),
        ],
      ),
    );
  }

  String cartItemCount() {
    int count = 0;
    _cartProvider.items.forEach((key, value) async {
      count += value.quantity;
    });
    return count.toString();
  }
}
