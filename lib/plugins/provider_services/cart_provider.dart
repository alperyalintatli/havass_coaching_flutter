import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String courseImagePath;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.courseImagePath,
  });
}

class CartProvider with ChangeNotifier {
  bool _isPayment = false;
  bool get getIsPayment => this._isPayment;

  set setIsPayment(bool isPayment) => this._isPayment = isPayment;

  void changeIsPayment() {
    if (_isPayment) {
      _isPayment = false;
    } else {
      _isPayment = true;
    }

    notifyListeners();
  }

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
      String productId, int price, String title, String courseImagePath) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingValue) => CartItem(
          courseImagePath: existingValue.courseImagePath,
          id: existingValue.id,
          title: existingValue.title,
          price: existingValue.price,
          quantity: (existingValue.quantity == 0)
              ? existingValue.quantity + 1
              : existingValue.quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          courseImagePath: courseImagePath,
          id: productId,
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          courseImagePath: existingCartItem.courseImagePath,
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
