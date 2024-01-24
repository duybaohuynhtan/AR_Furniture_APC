import 'package:flutter/material.dart';
import 'cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(String productName, int price) {
    int index =
        _cartItems.indexWhere((item) => item.productName == productName);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems
          .add(CartItem(productName: productName, quantity: 1, price: price));
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }
}
