import 'package:flutter/material.dart';

import 'cart_firestore.dart';
import 'cart_item.dart';

class CartPage extends StatelessWidget {
  final CartManager cartManager = CartManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: cartManager.getCartItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<CartItem> cartItems = snapshot.data!;
          int totalAmount = calculateTotalAmount(cartItems);

          if (cartItems.isEmpty) {
            return const Center(
              child: Text('No items in the cart'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cartItems[index].productName),
                      subtitle: Text(
                          'Quantity: ${cartItems[index].quantity}, Total: ${cartItems[index].quantity * cartItems[index].price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartManager
                              .removeFromCart(cartItems[index].productName);
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text('Total Amount: $totalAmount'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                },
                child: const Text('Checkout'),
              ),
            ],
          );
        },
      ),
    );
  }
}

int calculateTotalAmount(List<CartItem> cartItems) {
  int totalAmount = 0;
  for (int index = 0; index < cartItems.length; index++) {
    totalAmount += cartItems[index].quantity * cartItems[index].price;
  }
  return totalAmount;
}
