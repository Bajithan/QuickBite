import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/menu_item.dart';
import '../models/order_model.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/item_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/order_confirmation_screen.dart';
import '../screens/order_tracking_screen.dart';
import '../screens/profile_screen.dart';
import '../data/menu_data.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/item-detail',
      builder: (BuildContext context, GoRouterState state) {
        final item = state.extra is MenuItem
            ? state.extra as MenuItem
            : MenuData.defaultItems.first;
        return ItemDetailScreen(item: item);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (BuildContext context, GoRouterState state) {
        return const CartScreen();
      },
    ),
    GoRoute(
      path: '/checkout',
      builder: (BuildContext context, GoRouterState state) {
        return const CheckoutScreen();
      },
    ),
    GoRoute(
      path: '/order-confirmation',
      builder: (BuildContext context, GoRouterState state) {
        final order = state.extra is OrderModel ? state.extra as OrderModel : null;
        return OrderConfirmationScreen(order: order);
      },
    ),
    GoRoute(
      path: '/order-tracking',
      builder: (BuildContext context, GoRouterState state) {
        final order = state.extra is OrderModel ? state.extra as OrderModel : null;
        return OrderTrackingScreen(order: order);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
  ],
);
