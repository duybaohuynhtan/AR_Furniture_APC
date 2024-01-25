class CartItem {
  final String userUID;
  final String productName;
  int quantity;
  int price;
  final String imageUrl;

  CartItem({
    required this.userUID,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}
