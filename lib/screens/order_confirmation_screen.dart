import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/order_model.dart';
import '../providers/order_provider.dart';
import '../theme/app_theme.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final OrderModel? order;

  const OrderConfirmationScreen({
    super.key,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    // If order was not directly passed in extra, retrieve the active order from provider
    final activeOrder = order ?? context.watch<OrderProvider>().activeOrder;

    final orderId = activeOrder?.orderId ?? 'QB-5921';
    final pickupTime = activeOrder?.estimatedPickupTime ?? '15-20 min';
    final pickupLocation = activeOrder?.pickupLocation ?? 'Main Student Union Hub';
    final totalAmount = activeOrder?.total ?? 14.15;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Badge with Green Halo
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppTheme.success.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 64,
                      color: AppTheme.success,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Order Confirmed!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your order has been sent to the campus kitchen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 28),

                // Order Details Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Order Number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Order Number', style: TextStyle(color: AppTheme.textSecondary)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '#$orderId',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: AppTheme.primaryDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),

                        // Estimated Pickup Time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Estimated Pickup', style: TextStyle(color: AppTheme.textSecondary)),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 16, color: AppTheme.primary),
                                const SizedBox(width: 4),
                                Text(
                                  pickupTime,
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 24),

                        // Pickup Counter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Pickup Counter', style: TextStyle(color: AppTheme.textSecondary)),
                            Text(
                              pickupLocation,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ],
                        ),
                        const Divider(height: 24),

                        // Total Paid
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Paid', style: TextStyle(color: AppTheme.textSecondary)),
                            Text(
                              '\$${totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Action Buttons: Track Order & Home
                ElevatedButton.icon(
                  icon: const Icon(Icons.delivery_dining),
                  label: const Text('Track Order Status'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    context.push('/order-tracking', extra: activeOrder);
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.home_outlined),
                  label: const Text('Back to Home'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    context.go('/home');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
