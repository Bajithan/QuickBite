import 'package:flutter_test/flutter_test.dart';
import 'package:quickbite_app/models/menu_item.dart';
import 'package:quickbite_app/models/cart_item.dart';
import 'package:quickbite_app/models/order_model.dart';
import 'package:quickbite_app/providers/cart_provider.dart';
import 'package:quickbite_app/providers/order_provider.dart';
import 'package:quickbite_app/main.dart';

void main() {
  group('1. MenuItem Model Tests', () {
    test('MenuItem should deserialize from JSON correctly', () {
      final jsonMap = {
        'id': 'test-1',
        'name': 'Test Burger',
        'category': 'Meals',
        'price': 9.50,
        'description': 'Delicious test burger',
        'imageUrl': 'https://example.com/burger.jpg',
        'rating': 4.9,
        'calories': 550,
        'prepTime': '12 min',
      };

      final item = MenuItem.fromJson(jsonMap);
      expect(item.id, 'test-1');
      expect(item.name, 'Test Burger');
      expect(item.category, 'Meals');
      expect(item.price, 9.50);
      expect(item.rating, 4.9);
      expect(item.calories, 550);
      expect(item.prepTime, '12 min');
    });

    test('MenuItem should serialize to JSON correctly', () {
      const item = MenuItem(
        id: 'test-2',
        name: 'Test Latte',
        category: 'Beverages',
        price: 4.50,
        description: 'Smooth coffee',
        imageUrl: 'https://example.com/latte.jpg',
      );

      final json = item.toJson();
      expect(json['id'], 'test-2');
      expect(json['name'], 'Test Latte');
      expect(json['price'], 4.50);
    });
  });

  group('2. CartProvider Logic Tests', () {
    late CartProvider cart;
    const itemA = MenuItem(
      id: 'item-a',
      name: 'Crispy Chicken Burger',
      category: 'Meals',
      price: 8.00,
      description: 'Test burger',
      imageUrl: '',
    );
    const itemB = MenuItem(
      id: 'item-b',
      name: 'Iced Latte',
      category: 'Beverages',
      price: 4.00,
      description: 'Test latte',
      imageUrl: '',
    );

    setUp(() {
      cart = CartProvider();
    });

    test('Initial cart is empty', () {
      expect(cart.isEmpty, true);
      expect(cart.totalItemCount, 0);
      expect(cart.subtotal, 0.0);
      expect(cart.total, 0.0);
    });

    test('Adding items updates itemCount and subtotal correctly', () {
      cart.addItem(itemA, quantity: 2); // 2 * 8.00 = 16.00
      expect(cart.isEmpty, false);
      expect(cart.totalItemCount, 2);
      expect(cart.subtotal, 16.00);

      cart.addItem(itemB, quantity: 1); // 1 * 4.00 = 4.00
      expect(cart.totalItemCount, 3);
      expect(cart.subtotal, 20.00);
      expect(cart.tax, 1.00); // 5% of 20.00
      expect(cart.total, 21.00);
    });

    test('Adding same item increments existing item quantity', () {
      cart.addItem(itemA, quantity: 1);
      cart.addItem(itemA, quantity: 2);
      expect(cart.items.length, 1);
      expect(cart.totalItemCount, 3);
      expect(cart.subtotal, 24.00);
    });

    test('Updating quantity updates subtotal and removing when zero', () {
      cart.addItem(itemA, quantity: 3);
      cart.updateQuantity(itemA.id, 5);
      expect(cart.totalItemCount, 5);
      expect(cart.subtotal, 40.00);

      cart.updateQuantity(itemA.id, 0);
      expect(cart.isEmpty, true);
    });

    test('removeItem removes specific item from cart', () {
      cart.addItem(itemA, quantity: 1);
      cart.addItem(itemB, quantity: 1);
      expect(cart.items.length, 2);

      cart.removeItem(itemA.id);
      expect(cart.items.length, 1);
      expect(cart.items.first.item.id, itemB.id);
    });

    test('clearCart empties the cart', () {
      cart.addItem(itemA, quantity: 2);
      cart.addItem(itemB, quantity: 3);
      cart.clearCart();
      expect(cart.isEmpty, true);
      expect(cart.subtotal, 0.0);
    });
  });

  group('3. OrderProvider Logic Tests', () {
    late OrderProvider orderProvider;
    const item = MenuItem(
      id: 'item-1',
      name: 'Burger',
      category: 'Meals',
      price: 10.0,
      description: '',
      imageUrl: '',
    );

    setUp(() {
      orderProvider = OrderProvider();
    });

    test('createOrder adds new order with generated QB-ID and placed status', () {
      final order = orderProvider.createOrder(
        items: [CartItem(item: item, quantity: 2)],
        subtotal: 20.0,
        tax: 1.0,
        total: 21.0,
        pickupLocation: 'Main Student Union Hub',
      );

      expect(order.orderId.startsWith('QB-'), true);
      expect(order.status, OrderStatus.placed);
      expect(order.pickupLocation, 'Main Student Union Hub');
      expect(orderProvider.activeOrder?.orderId, order.orderId);
    });

    test('advanceOrderStatus transitions status through Placed -> Preparing -> Ready', () {
      final order = orderProvider.createOrder(
        items: [CartItem(item: item, quantity: 1)],
        subtotal: 10.0,
        tax: 0.5,
        total: 10.5,
        pickupLocation: 'Library Ground Cafe',
      );

      expect(order.status, OrderStatus.placed);

      orderProvider.advanceOrderStatus(order.orderId);
      expect(orderProvider.activeOrder?.status, OrderStatus.preparing);

      orderProvider.advanceOrderStatus(order.orderId);
      expect(orderProvider.activeOrder?.status, OrderStatus.readyForPickup);

      orderProvider.advanceOrderStatus(order.orderId);
      expect(orderProvider.activeOrder?.status, OrderStatus.completed);
    });
  });

  group('4. QuickBite Widget Smoke Test', () {
    testWidgets('QuickBiteApp boots and displays initial widgets', (WidgetTester tester) async {
      await tester.pumpWidget(const QuickBiteApp());
      // Splash screen should show QuickBite title
      expect(find.text('QuickBite'), findsOneWidget);
      expect(find.text('Campus Food in Minutes'), findsOneWidget);
    });
  });
}
