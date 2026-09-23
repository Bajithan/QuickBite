import 'menu_item.dart';

class CartItem {
  final MenuItem item;
  int quantity;
  String? specialInstructions;

  CartItem({
    required this.item,
    this.quantity = 1,
    this.specialInstructions,
  });

  double get totalPrice => item.price * quantity;

  CartItem copyWith({
    MenuItem? item,
    int? quantity,
    String? specialInstructions,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}
