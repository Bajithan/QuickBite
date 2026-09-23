import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPickupLocation = 'Main Student Union Hub';
  String _selectedPaymentMethod = 'Campus Dining Card';

  final _nameController = TextEditingController(text: 'Alex Morgan');
  final _studentIdController = TextEditingController(text: 'STU-2024-4192');
  final _phoneController = TextEditingController(text: '(555) 234-8901');

  final List<String> _pickupLocations = [
    'Main Student Union Hub',
    'Library Ground Cafe',
    'Engineering Quad Cafeteria',
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'Campus Dining Card',
      'title': 'Campus Dining Card',
      'subtitle': 'Balance: \$45.50 • ID #4192',
      'icon': Icons.credit_card,
    },
    {
      'id': 'Credit / Debit Card',
      'title': 'Credit / Debit Card',
      'subtitle': 'Visa, Mastercard, Amex',
      'icon': Icons.payment,
    },
    {
      'id': 'Apple / Google Pay',
      'title': 'Apple / Google Pay',
      'subtitle': 'Fast 1-tap checkout',
      'icon': Icons.account_balance_wallet,
    },
    {
      'id': 'Cash on Pickup',
      'title': 'Cash on Pickup',
      'subtitle': 'Pay at cafeteria cashier counter',
      'icon': Icons.attach_money,
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handlePlaceOrder() {
    final cart = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();

    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty!')),
      );
      context.go('/home');
      return;
    }

    // Generate random order ID & create order in OrderProvider
    final newOrder = orderProvider.createOrder(
      items: cart.items,
      subtotal: cart.subtotal,
      tax: cart.tax,
      total: cart.total,
      pickupLocation: _selectedPickupLocation,
    );

    // Clear cart state
    cart.clearCart();

    // Navigate to Order Confirmation screen with the new order
    context.go('/order-confirmation', extra: newOrder);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Campus Pickup Station
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.storefront, color: AppTheme.primary, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Campus Pickup Station',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ..._pickupLocations.map((location) {
                        return RadioListTile<String>(
                          value: location,
                          groupValue: _selectedPickupLocation,
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppTheme.primary,
                          title: Text(
                            location,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Estimated pickup in 15-20 min', style: TextStyle(fontSize: 12)),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedPickupLocation = val;
                              });
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2. Student Contact Info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.person_outline, color: AppTheme.primary, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Student Information',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Student Name',
                          prefixIcon: Icon(Icons.badge, size: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _studentIdController,
                        decoration: const InputDecoration(
                          labelText: 'Student ID',
                          prefixIcon: Icon(Icons.school, size: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number (for SMS pickup alert)',
                          prefixIcon: Icon(Icons.phone, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 3. Payment Method
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.payment, color: AppTheme.primary, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Payment Method',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ..._paymentMethods.map((method) {
                        final isSelected = _selectedPaymentMethod == method['id'];
                        return RadioListTile<String>(
                          value: method['id'] as String,
                          groupValue: _selectedPaymentMethod,
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppTheme.primary,
                          secondary: Icon(
                            method['icon'] as IconData,
                            color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                          ),
                          title: Text(
                            method['title'] as String,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            method['subtitle'] as String,
                            style: const TextStyle(fontSize: 12),
                          ),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedPaymentMethod = val;
                              });
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Order Total Breakdown
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Items Subtotal:', style: TextStyle(color: AppTheme.textSecondary)),
                          Text('\$${cart.subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Campus Tax (5%):', style: TextStyle(color: AppTheme.textSecondary)),
                          Text('\$${cart.tax.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Campus Pickup:', style: TextStyle(color: AppTheme.textSecondary)),
                          Text('FREE', style: TextStyle(color: AppTheme.success, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Final Total',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            '\$${cart.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Place Order Button
              ElevatedButton(
                onPressed: _handlePlaceOrder,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 20),
                    const SizedBox(width: 8),
                    Text('Place Order • \$${cart.total.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
