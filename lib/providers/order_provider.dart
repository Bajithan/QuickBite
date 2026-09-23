import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import '../models/cart_item.dart';
import '../data/menu_data.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];
  OrderModel? _activeOrder;

  OrderProvider() {
    _initDummyHistory();
  }

  List<OrderModel> get orders => List.unmodifiable(_orders);
  OrderModel? get activeOrder => _activeOrder;

  void _initDummyHistory() {
    final defaultMeals = MenuData.defaultItems;
    _orders.addAll([
      OrderModel(
        orderId: "QB-3841",
        items: [
          CartItem(item: defaultMeals[0], quantity: 1),
          CartItem(item: defaultMeals[4], quantity: 1),
        ],
        subtotal: 2300.00,
        tax: 115.00,
        total: 2415.00,
        pickupLocation: "Main Student Union Hub",
        estimatedPickupTime: "15 min",
        orderTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        status: OrderStatus.completed,
      ),
      OrderModel(
        orderId: "QB-2109",
        items: [
          CartItem(item: defaultMeals[2], quantity: 1),
          CartItem(item: defaultMeals[5], quantity: 2),
        ],
        subtotal: 2500.00,
        tax: 125.00,
        total: 2625.00,
        pickupLocation: "Library Cafe Counter",
        estimatedPickupTime: "10 min",
        orderTime: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
        status: OrderStatus.completed,
      ),
    ]);
  }

  OrderModel createOrder({
    required List<CartItem> items,
    required double subtotal,
    required double tax,
    required double total,
    required String pickupLocation,
  }) {
    final randomId = "QB-${1000 + Random().nextInt(9000)}";
    final newOrder = OrderModel(
      orderId: randomId,
      items: List.from(items),
      subtotal: subtotal,
      tax: tax,
      total: total,
      pickupLocation: pickupLocation,
      estimatedPickupTime: "15-20 min",
      orderTime: DateTime.now(),
      status: OrderStatus.placed,
    );

    _activeOrder = newOrder;
    _orders.insert(0, newOrder);
    notifyListeners();
    return newOrder;
  }

  void advanceOrderStatus(String orderId) {
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index >= 0) {
      final current = _orders[index].status;
      if (current == OrderStatus.placed) {
        _orders[index].status = OrderStatus.preparing;
      } else if (current == OrderStatus.preparing) {
        _orders[index].status = OrderStatus.readyForPickup;
      } else if (current == OrderStatus.readyForPickup) {
        _orders[index].status = OrderStatus.completed;
      }

      if (_activeOrder?.orderId == orderId) {
        _activeOrder = _orders[index];
      }
      notifyListeners();
    }
  }

  void setActiveOrder(OrderModel order) {
    _activeOrder = order;
    notifyListeners();
  }
}
