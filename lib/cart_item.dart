class CartItem {
  final String userUID;
  final String productName;
  int quantity;
  int price;

  CartItem({
    required this.userUID,
    required this.productName,
    required this.quantity,
    required this.price,
  });
}
