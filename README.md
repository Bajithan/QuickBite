# QuickBite – Campus Food Ordering App

A modern cross-platform mobile application built with Flutter for fast and convenient campus cafeteria dining.

---

## Tech Stack

- **Framework**: Flutter (Dart 3.x)
- **State Management**: `provider: ^6.1.2`
- **Routing**: `go_router: ^14.2.7`
- **Formatting**: `intl: ^0.19.0`
- **Currency**: Sri Lankan Rupees (`LKR`)

---

## Folder Structure

```
lib/
 ├─ models/       # MenuItem, CartItem, OrderModel
 ├─ screens/      # splash, login, home, item_detail, cart, checkout, order_confirmation, order_tracking, profile
 ├─ providers/    # cart_provider.dart, order_provider.dart
 ├─ widgets/      # menu_card, cart_tile, quantity_selector, category_chip_bar
 ├─ data/         # menu_data.dart, menu.json
 ├─ theme/        # app_theme.dart (Theming & LKR currency formatter)
 ├─ routes/       # app_router.dart (go_router route definitions)
 └─ main.dart     # MultiProvider root entrypoint
```

---

## Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run automated unit tests**:
   ```bash
   flutter test
   ```

3. **Run on an Android emulator or device**:
   ```bash
   flutter run
   ```

4. **Run in Chrome (Web)**:
   ```bash
   flutter run -d chrome
   ```

---

## GitHub Repository

- **Repository**: [https://github.com/Bajithan/quickbite_app](https://github.com/Bajithan/quickbite_app)
- **Author**: Bajithan Sivathasan
- **Branch**: `main`

---

## Deliverables Checklist

- [x] Full source code adhering to guidelines
- [x] Responsive layout tested on phone and tablet dimensions
- [x] All amounts and currency displayed in **LKR**
- [x] Test log table (`test_log.md`) with 8 passing test cases
- [x] Git commit history following Conventional Commits format
