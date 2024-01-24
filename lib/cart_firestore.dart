import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_gate.dart';
import 'cart_item.dart';

class CartManager {
  final CollectionReference cartCollection = FirebaseFirestore.instance
      .collection('carts')
      .doc(userUID)
      .collection('products');

  Future<void> addToCart(CartItem item) async {
    var existingItem = await cartCollection.doc(item.productName).get();

    if (existingItem.exists) {
      // Nếu sản phẩm đã tồn tại, tăng số lượng
      await cartCollection.doc(item.productName).update({
        'quantity': FieldValue.increment(item.quantity),
        'price': item.price,
      });
    } else {
      // Nếu sản phẩm chưa tồn tại, tạo mới với số lượng là 1
      await cartCollection.doc(item.productName).set({
        'productName': item.productName,
        'quantity': 1,
        'price': item.price,
      });
    }
  }

  Future<void> removeFromCart(String productName) async {
    await cartCollection.doc(productName).delete();
  }

  Stream<List<CartItem>> getCartItems() {
    return cartCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CartItem(
          userUID: userUID.toString(),
          productName: data['productName'],
          quantity: data['quantity'],
          price: data['price'],
        );
      }).toList();
    });
  }
}
