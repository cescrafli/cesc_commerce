class Product {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String image;
  final String description;

  Product({required this.id, required this.title, required this.subtitle, required this.price, required this.image, required this.description});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
