import 'cart_item.dart';

enum OrderStatus {
  placed,
  preparing,
  readyForPickup,
  completed,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.preparing:
        return 'Preparing in Kitchen';
      case OrderStatus.readyForPickup:
        return 'Ready for Pickup';
      case OrderStatus.completed:
        return 'Completed';
    }
  }

  int get stepIndex {
    switch (this) {
      case OrderStatus.placed:
        return 0;
      case OrderStatus.preparing:
        return 1;
      case OrderStatus.readyForPickup:
        return 2;
      case OrderStatus.completed:
        return 3;
    }
  }
}

class OrderModel {
  final String orderId;
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double total;
  final String pickupLocation;
  final String estimatedPickupTime;
  final DateTime orderTime;
  OrderStatus status;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.pickupLocation,
    required this.estimatedPickupTime,
    required this.orderTime,
    this.status = OrderStatus.placed,
  });
}
