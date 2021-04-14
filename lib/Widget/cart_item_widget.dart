import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int price;
  final int quantity;

  const CartItem({this.id, this.title, this.price, this.quantity});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      color: Color.fromRGBO(154, 206, 207, 1),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: ValueKey(id),
        background: Container(
          padding: EdgeInsets.only(right: 20),
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
        ),
        onDismissed: (direction) {
          cart.removeItem(id);
        },
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Color.fromRGBO(154, 206, 207, 1),
              title: Text(
                'Are you sure?',
                style: TextStyle(color: Colors.white),
              ),
              content: Text('Do you want to remove the item from the cart?',
                  style: TextStyle(color: Colors.white)),
              actions: [
                FlatButton(
                  child: Text('No', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Yes', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    cart.removeItem(id);
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(24, 231, 239, 1),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: FittedBox(
                  child:
                      Text('\$$price', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            title: Text(title, style: TextStyle(color: Colors.white)),
            subtitle: Text('Total: \$${price * quantity}',
                style: TextStyle(color: Colors.white)),
            trailing:
                Text('$quantity x', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
