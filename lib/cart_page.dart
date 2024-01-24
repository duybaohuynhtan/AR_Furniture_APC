import 'package:flutter/material.dart';

import 'cart_firestore.dart';
import 'cart_item.dart';

class CartPage extends StatelessWidget {
  final CartManager cartManager = CartManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: cartManager.getCartItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<CartItem> cartItems = snapshot.data!;
          int totalAmount = 0;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    totalAmount +=
                        cartItems[index].quantity * cartItems[index].price;
                    return ListTile(
                      title: Text(cartItems[index].productName),
                      subtitle: Text(
                          'Quantity: ${cartItems[index].quantity}, Total: ${cartItems[index].quantity * cartItems[index].price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartManager
                              .removeFromCart(cartItems[index].productName);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('Total Amount: $totalAmount'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Đặt logic để xử lý Checkout ở đây
                  // Ví dụ: Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                },
                child: Text('Checkout'),
              ),
            ],
          );
        },
      ),
    );
  }
}
