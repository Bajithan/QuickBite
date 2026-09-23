import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  // 5% campus dining sales tax
  double get tax => subtotal * 0.05;

  // Free pickup on campus
  double get pickupFee => 0.00;

  double get total => subtotal + tax + pickupFee;

  bool get isEmpty => _items.isEmpty;

  void addItem(MenuItem item, {int quantity = 1, String? specialInstructions}) {
    final existingIndex = _items.indexWhere((ci) => ci.item.id == item.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
      if (specialInstructions != null && specialInstructions.isNotEmpty) {
        _items[existingIndex].specialInstructions = specialInstructions;
      }
    } else {
      _items.add(CartItem(
        item: item,
        quantity: quantity,
        specialInstructions: specialInstructions,
      ));
    }
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final index = _items.indexWhere((ci) => ci.item.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void removeItem(String itemId) {
    _items.removeWhere((ci) => ci.item.id == itemId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int getQuantityForItem(String itemId) {
    final index = _items.indexWhere((ci) => ci.item.id == itemId);
    if (index >= 0) {
      return _items[index].quantity;
    }
    return 0;
  }
}
