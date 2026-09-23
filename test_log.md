# QuickBite App — Test Log

This test log records manual and automated functional validation for the QuickBite campus food ordering MVP across navigation, cart calculation, input validation, order progression, and responsive layouts (all pricing in Sri Lankan Rupees - LKR).

| Test ID | Description | Steps | Expected Result | Actual Result | Pass/Fail |
|---|---|---|---|---|---|
| **TC-01** | Splash Screen Auto-Navigation | 1. Launch app.<br>2. Wait 2 seconds on Splash screen without touching. | App automatically navigates from Splash (`/`) to Login screen (`/login`). | Navigated smoothly to `/login` after exactly 2.0 seconds. | **PASS** |
| **TC-02** | Guest Login Bypass | 1. On Login screen, tap "Continue as Guest". | Directly navigate to Home screen (`/home`) without requiring credential inputs. | Home screen loaded immediately displaying campus cafeteria menu. | **PASS** |
| **TC-03** | Menu Search & Category Filter | 1. Type "latte" in search bar.<br>2. Verify filtered list.<br>3. Clear search and tap "Meals" chip. | 1. Only Iced Vanilla Oat Latte & Matcha Latte shown.<br>2. Tapping "Meals" filters to Burgers & Grain Bowls only. | Filtering instantly updated menu grid matching search and category tokens. | **PASS** |
| **TC-04** | Item Detail Quantity & Cart State (LKR) | 1. Tap on "Classic Crispy Chicken Burger" (LKR 1,450.00).<br>2. Increase quantity to 3.<br>3. Tap "Add to Cart • LKR 4,350.00".<br>4. Open Cart. | Cart contains 3 burgers; subtotal is LKR 4,350.00, tax is LKR 217.50 (5%), total is LKR 4,567.50. Badge shows 3. | Quantities and totals in LKR matched calculated values; cart badge updated to 3. | **PASS** |
| **TC-05** | Cart Quantity Modification & Removal | 1. In Cart, click `+` on burger.<br>2. Click `-` until 1, then click `-` again (trash). | Quantity increments to 4 (subtotal LKR 5,800.00); clicking below 1 removes item, showing empty state. | Item was removed cleanly; Empty cart illustration and "Browse Menu" button displayed. | **PASS** |
| **TC-06** | Checkout Validation & Random Order ID | 1. Add items to cart.<br>2. Navigate to Checkout.<br>3. Select "Library Ground Cafe" and click "Place Order". | Generates unique order ID (e.g. `QB-7842`), clears cart, navigates to Confirmation screen with estimated pickup time. | Order ID generated (`QB-XXXX`), cart emptied, confirmation screen displayed with pickup details in LKR. | **PASS** |
| **TC-07** | Order Status Progression | 1. On Order Confirmation, tap "Track Order Status".<br>2. Tap "Advance Status" simulator button. | Status moves sequentially: `Order Placed` ➔ `Preparing` ➔ `Ready for Pickup` with visual timeline update. | Step indicator highlighted active step and changed status chips appropriately. | **PASS** |
| **TC-08** | Responsive Layout (Phone vs Tablet) | 1. Test app on 390px phone width.<br>2. Resize viewport to 840px tablet width. | Phone renders 2-column menu grid and stacked cart; Tablet renders 3-4 column grid and split side-by-side cart layout. | Grid and layouts dynamically adapted using `LayoutBuilder` without overflow. | **PASS** |

### Automated Unit Test Summary
- **Tests Executed**: Unit and widget tests in `test/quickbite_app_test.dart` and `test/golden_screenshots_test.dart`
- **Coverage Areas**: JSON serialization, LKR cart subtotal/tax computation, item increment/decrement, order creation, order status transitions, splash & profile widget rendering.
- **Result**: All Tests Passed.
